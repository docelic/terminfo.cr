require "./searcher"
require "./names"

module Terminfo
  class Header
    getter names_size : Int16
    getter bools_size : Int16
    getter numbers_count : Int16
    getter string_offsets_count : Int16
    getter string_table_size : Int16

    def initialize(@names_size, @bools_size, @numbers_count,
                   @string_offsets_count, @string_table_size)
    end
  end

  class Parser
    def self.from_io(io : IO, longnames = true)
      new(longnames).parse(io)
    end

    def initialize(longnames)
      @name_key = (longnames ? :full : :short)
    end

    def parse(io : IO)
      # Note: all read operations (mainly io.read_bytes) can raises EOFError

      # Verify magic number
      if read_i16(io) != 0x11A
        raise "Not a terminfo database"
      end

      # Header
      header = parse_header io

      validate_header! header

      # Names section
      names = parse_names_section io, header

      # Bools section
      bools = parse_bools_section io, header

      # Numbers section
      numbers = parse_numbers_section io, header

      # String sections
      strings = parse_strings_section io, header

      Database.new(
        names: names,
        bools: bools,
        numbers: numbers,
        strings: strings,
      )
    end

    def parse_header(io)
      names_size = read_i16(io)
      bools_size = read_i16(io)
      numbers_count = read_i16(io)
      string_offsets_count = read_i16(io)
      string_table_size = read_i16(io)

      Header.new(
        names_size: names_size,
        bools_size: bools_size,
        numbers_count: numbers_count,
        string_offsets_count: string_offsets_count,
        string_table_size: string_table_size,
      )
    end

    def validate_header!(header)
      raise "Invalid section size: names" if header.names_size <= 0
      raise "Invalid section size: bools" if header.bools_size < 0
      raise "Invalid section size: numbers" if header.numbers_count < 0
      if header.string_offsets_count < 0 || header.string_table_size < 0
        raise "Invalid section size: strings"
      end

      if header.bools_size > BoolNames.size
        raise "Too many bool"
      end

      if header.numbers_count > NumNames.size
        raise "Too many numbers"
      end

      if header.string_offsets_count > StringNames.size
        raise "Too many strings"
      end
    end

    private def read_i16(io)
      io.read_bytes(Int16, IO::ByteFormat::LittleEndian)
    end

    def parse_names_section(io, header)
      names_section = Bytes.new(header.names_size)
      io.read_fully(names_section)

      String.new(names_section).split '|'
    end

    def parse_bools_section(io, header)
      bools_section = Bytes.new(header.bools_size)
      io.read_fully(bools_section)

      # Compensate for padding
      # > Between the boolean section and the number section, a null byte will
      # > be inserted, if necessary, to ensure that the number section begins on
      # > an even byte.
      if (header.names_size + header.bools_size) % 2 != 0
        io.skip(1)
      end

      # > The boolean flags have one byte for each flag.
      # So bools_size is the number of bools for this terminfo.
      bools = Hash(String, Bool).new(initial_capacity: header.bools_size)
      bools_section.each_with_index do |value, idx|
        if value == 1
          key = BoolNames[idx][@name_key]
          bools[key] = true
        end
      end

      bools
    end

    def parse_numbers_section(io, header)
      numbers = Hash(String, Int16).new(initial_capacity: header.numbers_count)
      header.numbers_count.times do |idx|
        value = read_i16(io)
        if value != -1
          key = NumNames[idx][@name_key]
          numbers[key] = value
        end
      end

      numbers
    end

    def parse_strings_section(io, header)
      # collect string offsets
      string_offsets = Hash(String, Int16).new(initial_capacity: header.string_offsets_count)
      header.string_offsets_count.times do |idx|
        value = read_i16(io)
        if value != -1
          key = StringNames[idx][@name_key]
          string_offsets[key] = value
        elsif value < -1
          raise "Invalid string offset"
        end
      end

      string_table_section = Bytes.new(header.string_table_size)
      io.read_fully(string_table_section)

      strings = Hash(String, Bytes).new(initial_capacity: header.string_offsets_count)
      string_offsets.each do |key, offset|
        unless nul_index = string_table_section.index('\0'.ord, offset: offset)
          raise "String table too short (#{offset} out of bounds or no NUL at end of string)"
        end

        length = nul_index - offset
        strings[key] = string_table_section[offset, count: length]
      end

      strings
    end
  end
end
