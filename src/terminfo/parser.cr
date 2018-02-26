require "./searcher"
require "./names"

module Terminfo
  class ParseError < Exception
  end

  class Header
    getter names_count : Int16
    getter bools_count : Int16
    getter numbers_count : Int16
    getter string_offsets_count : Int16
    getter string_table_size : Int16

    def initialize(@names_count, @bools_count, @numbers_count,
                   @string_offsets_count, @string_table_size)
    end
  end

  class Parser
    def self.from_io(io : IO)
      new.parse(io)
    end

    def parse(io : IO)
      # NOTE: all read operations (mainly io.read_bytes) can raises EOFError

      # Verify magic number
      check_magic_number! io

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
        booleans: bools,
        numbers: numbers,
        strings: strings,
      )
    end

    MAGIC_NUMBER = 0x11A

    def check_magic_number!(io)
      if read_i16(io) != MAGIC_NUMBER
        parse_error "Not a terminfo database: bad magic number"
      end
    end

    def parse_header(io)
      names_count = read_i16(io)
      bools_count = read_i16(io)
      numbers_count = read_i16(io)
      string_offsets_count = read_i16(io)
      string_table_size = read_i16(io)

      Header.new(
        names_count: names_count,
        bools_count: bools_count,
        numbers_count: numbers_count,
        string_offsets_count: string_offsets_count,
        string_table_size: string_table_size,
      )
    end

    def validate_header!(header)
      parse_error "Invalid section size: names" if header.names_count <= 0
      parse_error "Invalid section size: bools" if header.bools_count < 0
      parse_error "Invalid section size: numbers" if header.numbers_count < 0
      if header.string_offsets_count < 0 || header.string_table_size < 0
        parse_error "Invalid section size: strings"
      end

      if header.bools_count > KeyNames::Booleans.size
        parse_error "Too many bool"
      end

      if header.numbers_count > KeyNames::Numbers.size
        parse_error "Too many numbers"
      end

      if header.string_offsets_count > KeyNames::Strings.size
        parse_error "Too many strings"
      end
    end

    private def read_i16(io)
      io.read_bytes(Int16, IO::ByteFormat::LittleEndian)
    end

    def parse_names_section(io, header)
      names_section = Bytes.new(header.names_count)
      io.read_fully(names_section)

      String.new(names_section).split '|'
    end

    def parse_bools_section(io, header)
      bools_section = Bytes.new(header.bools_count)
      io.read_fully(bools_section)

      # Compensate for padding
      # > Between the boolean section and the number section, a null byte will
      # > be inserted, if necessary, to ensure that the number section begins on
      # > an even byte.
      if (header.names_count + header.bools_count) % 2 != 0
        io.skip(1)
      end

      # > The boolean flags have one byte for each flag.
      # So bools_count is the number of bools for this terminfo.
      bools = Hash(Keys::Booleans, Bool).new(initial_capacity: header.bools_count)
      bools_section.each_with_index do |value, idx|
        if value == 1
          bool_key = Keys::Booleans.from_value idx
          bools[bool_key] = true
        end
      end

      bools
    end

    def parse_numbers_section(io, header)
      numbers = Hash(Keys::Numbers, Int16).new(initial_capacity: header.numbers_count)
      header.numbers_count.times do |idx|
        value = read_i16(io)
        if value != -1
          num_key = Keys::Numbers.from_value idx.to_i32
          numbers[num_key] = value
        end
      end

      numbers
    end

    def parse_strings_section(io, header)
      # collect string offsets
      string_offsets = Hash(Keys::Strings, Int16).new(initial_capacity: header.string_offsets_count)
      header.string_offsets_count.times do |idx|
        value = read_i16(io)
        if value != -1
          str_key = Keys::Strings.from_value idx.to_i32
          string_offsets[str_key] = value
        elsif value < -1
          parse_error "Invalid string offset"
        end
      end

      string_table_section = Bytes.new(header.string_table_size)
      io.read_fully(string_table_section)

      strings = Hash(Keys::Strings, Bytes).new(initial_capacity: header.string_offsets_count)
      string_offsets.each do |str_key, offset|
        unless nul_index = string_table_section.index('\0'.ord, offset: offset)
          parse_error "String table too short (#{offset} out of bounds or no NUL at end of string)"
        end

        length = nul_index - offset
        strings[str_key] = string_table_section[offset, count: length]
      end

      strings
    end

    private def parse_error(msg)
      raise ParseError.new msg
    end
  end
end
