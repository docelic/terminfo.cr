require "./names"

require "./database"
require "./parser"

module Terminfo
  class Dumper
    def dump(db : Database, io : IO)
      write_i16(io, MAGIC_NUMBER)

      # write header
      write_header(db, io)

      # write names section
      write_names_section(db, io)

      # write bools section
      write_bools_section(db, io)
    end

    def write_header(db, io)
      write_i16(io, db.names.size)    # names count

      # Must be the booleans count in the final dump
      #
      # Since it needs to have the booleans in order, if the first ones
      # are `false` I still need to put them in the final dump (and so until the
      # last boolean in the database).
      #
      # Example:
      #
      # Given the bool names are: A, B, C, D, E, F.
      # The database contains: B(1), C(1), E(1)
      # The final dump must contain: A(0), B(1), C(1), D(0), E(1)
      last_bool_index = db.booleans.last_key?.try(&.value) || 0
      write_i16(io, last_bool_index + 1) # booleans count

      write_i16(io, db.numbers.size)  # numbers count
      write_i16(io, db.strings.size)  # string offsets count

      string_table_size = db.strings.each_value.sum { |str| str.bytesize + 1 }
      write_i16(io, string_table_size) # string table size in bytes
    end

    def write_names_section(db, io)
      # > The terminal names section comes next. It contains the first line of
      # > the terminfo description, listing the various names for the terminal,
      # > separated by the `|' character. The section is terminated with an
      # > ASCII NUL character.
      db.names.join('|', io: io)
      io.write_byte(0) # ASCII NUL
      # FIXME: NUL needed? seems it's not skipped in the parser...
    end

    def write_bools_section(db, io)
      current_bool = Keys::Booleans::AutoLeftMargin # first bool

      # > The boolean flags have one byte for each flag.
      # > This byte is either 0 or 1 as the flag is present or absent.
      #
      # Since it needs to have the booleans in order, if the first ones
      # are `false` I still need to put them in the final dump (and so until the
      # last boolean in the database).
      #
      # Example:
      #
      # Given the bool names are: A, B, C, D, E, F.
      # The database contains: B(1), C(1), E(1)
      # The final dump must contain: A(0), B(1), C(1), D(0), E(1)
      db.booleans.each do |key, value|
        # TODO: implement above..
      end
    end

    def write_i16(io : IO, number : Int)
      io.write_bytes(number.to_i16, IO::ByteFormat::LittleEndian)
    end
  end

  # Quick test!
  db = Database.new_empty
  db.names << "Dumper test!" << "Other name"
  db.set :auto_left_margin, true
  dumper = Dumper.new
  io = IO::Memory.new
  dumper.dump(db, io)
  puts io.to_slice.hexdump
end
