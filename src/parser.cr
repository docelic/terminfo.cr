require "./searcher"
require "./names"

module Terminfo
  class ParseError < Exception
  end

  class Header
    getter names_bytesize : Int16
    getter bools_count : Int16
    getter numbers_count : Int16
    getter string_offsets_count : Int16
    getter string_table_size : Int16

    def initialize(@names_bytesize, @bools_count, @numbers_count,
                   @string_offsets_count, @string_table_size)
    end
  end

  class Parser
    def parse(io : IO)
      # NOTE: all read operations can raises IO::EOFError

      # Verify magic number
      numbers_encoding = check_magic_number! io

      # Header
      header = parse_header io

      validate_header! header

      # Names section
      names = parse_names_section io, header

      # Bools section
      bools = parse_bools_section io, header

      # Compensate for padding
      # > Between the boolean section and the number section, a null byte will
      # > be inserted, if necessary, to ensure that the number section begins on
      # > an even byte.
      if (header.names_bytesize + header.bools_count) % 2 != 0
        io.skip(1)
      end

      # Numbers section
      numbers = parse_numbers_section io, header, numbers_encoding

      # String sections
      strings = parse_strings_section io, header

      # FIXME: this should build a Compiled::Database instead (which is an
      # implementation of the "interface" `Database`)
      Database.new(
        names: names,
        booleans: bools,
        numbers: numbers,
        strings: strings,
      )
    end

    private enum NumbersEncoding
      OnInt16
      OnInt32
    end

    MAGIC_NUMBER__nums_are_i16 = 0x11A
    MAGIC_NUMBER__nums_are_i32 = 0x21E

    def check_magic_number!(io : IO) : NumbersEncoding
      # Some terminfo databases encode there numbers as i16 or i32, defined by the magic number.
      # Solved by https://github.com/meh/rust-terminfo/blob/e2848c31c9a44233c7734c69f424a0841f8bffdd/src/parser/compiled.rs#L112-L120
      case magic = read_i16(io)
      when MAGIC_NUMBER__nums_are_i16
        return NumbersEncoding::OnInt16
      when MAGIC_NUMBER__nums_are_i32
        return NumbersEncoding::OnInt32
      else
        parse_error "Not a terminfo database: bad magic number (expected #{MAGIC_NUMBER__nums_are_i16} or #{MAGIC_NUMBER__nums_are_i32} but got #{magic})"
      end
    end

    def parse_header(io : IO)
      names_bytesize = read_i16(io)
      bools_count = read_i16(io)
      numbers_count = read_i16(io)
      string_offsets_count = read_i16(io)
      string_table_size = read_i16(io)

      Header.new(
        names_bytesize: names_bytesize,
        bools_count: bools_count,
        numbers_count: numbers_count,
        string_offsets_count: string_offsets_count,
        string_table_size: string_table_size,
      )
    end

    def validate_header!(header : Header)
      parse_error "Invalid section size: names" if header.names_bytesize <= 0
      parse_error "Invalid section size: bools" if header.bools_count < 0
      parse_error "Invalid section size: numbers" if header.numbers_count < 0
      if header.string_offsets_count < 0 || header.string_table_size < 0
        parse_error "Invalid section size: strings"
      end

      if header.bools_count > KeyNames::Booleans.size
        parse_error "Too many bools"
      end

      if header.numbers_count > KeyNames::Numbers.size
        parse_error "Too many numbers"
      end

      if header.string_offsets_count > KeyNames::Strings.size
        parse_error "Too many strings"
      end
    end

    private def read_i16(io : IO)
      io.read_bytes(Int16, IO::ByteFormat::LittleEndian)
    end

    private def read_i32(io : IO)
      io.read_bytes(Int32, IO::ByteFormat::LittleEndian)
    end

    def parse_names_section(io : IO, header : Header)
      # NOTE: header.names_bytesize contains the last ASCII NUL
      names_section = Bytes.new(header.names_bytesize)
      io.read_fully(names_section)

      String.new(names_section).split '|'
    end

    def parse_bools_section(io : IO, header : Header)
      bools_section = Bytes.new(header.bools_count)
      io.read_fully(bools_section)

      # > The boolean flags have one byte for each flag.
      # So bools_count is the number of bools for this database.
      bools = Hash(Keys::Booleans, Bool).new(initial_capacity: header.bools_count)
      bools_section.each_with_index do |value, idx|
        if value == 1
          bool_key = Keys::Booleans.from_value idx
          bools[bool_key] = true
        end
      end

      bools
    end

    def parse_numbers_section(io : IO, header : Header, numbers_encoding : NumbersEncoding)
      numbers = Hash(Keys::Numbers, Int32).new(initial_capacity: header.numbers_count)
      header.numbers_count.times do |idx|
        value = read_i16(io)
        # Crystal doesn't want this, still says it could be Nil :/
        # case numbers_encoding
        # in NumbersEncoding::OnInt16
        #   value = read_i16(io)
        # in .on_int32?
        #   value = read_i32(io)
        # end
        if value != -1
          num_key = Keys::Numbers.from_value idx.to_i32
          numbers[num_key] = value.to_i32
        end
      end

      numbers
    end

    def parse_strings_section(io : IO, header : Header)
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

    private def parse_error(msg : String)
      raise ParseError.new msg
    end
  end
end
