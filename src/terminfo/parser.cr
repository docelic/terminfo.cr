require "./searcher"
require "./names"

module Terminfo
  def self.parse_terminfo(db_path, longnames = true)
    name_length_key = (longnames ? :full : :short)

    File.open db_path do |file|
      # Note: all read operations (mainly file.read_bytes) can raises EOFError

      # Verify magic number
      if read_i16(file) != 0x11A
        raise "Not a terminfo database"
      end

      # Header
      names_size = read_i16(file)
      bools_size = read_i16(file)
      numbers_count = read_i16(file)
      string_offsets_count = read_i16(file)
      string_table_size = read_i16(file)

      raise "Invalid section size: names" if names_size <= 0
      raise "Invalid section size: bools" if bools_size < 0
      raise "Invalid section size: numbers" if numbers_count < 0
      if string_offsets_count < 0 || string_table_size < 0
        raise "Invalid section size: strings"
      end

      if bools_size > BoolNames.size
        raise "Too many bool"
      end

      if numbers_count > NumNames.size
        raise "Too many numbers"
      end

      if string_offsets_count > StringNames.size
        raise "Too many strings"
      end

      # Names section

      names_section = Bytes.new(names_size)
      file.read_fully(names_section)

      names = String.new(names_section).split '|'

      # Bools section

      bools_section = Bytes.new(bools_size)
      file.read_fully(bools_section)

      # > The boolean flags have one byte for each flag.
      # So bools_size is the number of bools for this terminfo.
      bools = Hash(String, Bool).new(initial_capacity: bools_size)
      bools_section.each_with_index do |value, idx|
        if value == 1
          key = BoolNames[idx][name_length_key]
          bools[key] = true
        end
      end

      # Compensate for padding
      # > Between the boolean section and the number section, a null byte will
      # > be inserted, if necessary, to ensure that the number section begins on
      # > an even byte.
      if (names_size + bools_size) % 2 != 0
        file.skip(1)
      end

      # Numbers section

      numbers = Hash(String, Int16).new(initial_capacity: numbers_count)
      numbers_count.times do |idx|
        value = read_i16(file)
        if value != -1
          key = NumNames[idx][name_length_key]
          numbers[key] = value
        end
      end

      # String sections

      # collect string offsets
      string_offsets = Hash(String, Int16).new(initial_capacity: string_offsets_count)
      string_offsets_count.times do |idx|
        value = read_i16(file)
        if value != -1
          key = StringNames[idx][name_length_key]
          string_offsets[key] = value
        elsif value < -1
          raise "Invalid string offset"
        end
      end

      string_table_section = Bytes.new(string_table_size)
      file.read_fully(string_table_section)

      strings = Hash(String, Bytes).new(initial_capacity: string_offsets_count)
      string_offsets.each do |key, offset|
        unless nul_index = string_table_section.index('\0'.ord, offset: offset)
          raise "String table too short (#{offset} out of bounds or no NUL at end of string)"
        end

        length = nul_index - offset
        strings[key] = string_table_section[offset, count: length]
      end

      {
        names:   names,
        bools:   bools,
        numbers: numbers,
        strings: strings,
      }
    end
  end

  private def self.read_i16(io)
    io.read_bytes(Int16, IO::ByteFormat::LittleEndian)
  end
end
