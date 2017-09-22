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

  def self.parse_header(file)
    names_size = read_i16(file)
    bools_size = read_i16(file)
    numbers_count = read_i16(file)
    string_offsets_count = read_i16(file)
    string_table_size = read_i16(file)

    Header.new(
      names_size: names_size,
      bools_size: bools_size,
      numbers_count: numbers_count,
      string_offsets_count: string_offsets_count,
      string_table_size: string_table_size,
    )
  end

  def self.validate_header!(header)
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

  def self.parse_names_section(file, header)
    names_section = Bytes.new(header.names_size)
    file.read_fully(names_section)

    String.new(names_section).split '|'
  end

  def self.parse_bools_section(file, header, name_key)
    bools_section = Bytes.new(header.bools_size)
    file.read_fully(bools_section)

    # Compensate for padding
    # > Between the boolean section and the number section, a null byte will
    # > be inserted, if necessary, to ensure that the number section begins on
    # > an even byte.
    if (header.names_size + header.bools_size) % 2 != 0
      file.skip(1)
    end

    # > The boolean flags have one byte for each flag.
    # So bools_size is the number of bools for this terminfo.
    bools = Hash(String, Bool).new(initial_capacity: header.bools_size)
    bools_section.each_with_index do |value, idx|
      if value == 1
        key = BoolNames[idx][name_key]
        bools[key] = true
      end
    end

    bools
  end

  def self.parse_numbers_section(file, header, name_key)
    numbers = Hash(String, Int16).new(initial_capacity: header.numbers_count)
    header.numbers_count.times do |idx|
      value = read_i16(file)
      if value != -1
        key = NumNames[idx][name_key]
        numbers[key] = value
      end
    end

    numbers
  end

  def self.parse_strings_section(file, header, name_key)
    # collect string offsets
    string_offsets = Hash(String, Int16).new(initial_capacity: header.string_offsets_count)
    header.string_offsets_count.times do |idx|
      value = read_i16(file)
      if value != -1
        key = StringNames[idx][name_key]
        string_offsets[key] = value
      elsif value < -1
        raise "Invalid string offset"
      end
    end

    string_table_section = Bytes.new(header.string_table_size)
    file.read_fully(string_table_section)

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

  def self.parse_terminfo(db_path, longnames = true)
    name_length_key = (longnames ? :full : :short)

    File.open db_path do |file|
      # Note: all read operations (mainly file.read_bytes) can raises EOFError

      # Verify magic number
      if read_i16(file) != 0x11A
        raise "Not a terminfo database"
      end

      # Header
      header = parse_header file

      validate_header! header

      # Names section
      names = parse_names_section file, header

      # Bools section
      bools = parse_bools_section file, header, name_length_key

      # Numbers section
      numbers = parse_numbers_section file, header, name_length_key

      # String sections
      strings = parse_strings_section file, header, name_length_key

      Database.new(
        names:   names,
        bools:   bools,
        numbers: numbers,
        strings: strings,
      )
    end
  end

  private def self.read_i16(io)
    io.read_bytes(Int16, IO::ByteFormat::LittleEndian)
  end
end
