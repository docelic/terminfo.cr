require "./terminfo/*"

module Terminfo
  class Error < Exception
  end

  class FileTooShort < Error
    getter db : String

    def initialize(@message, @db)
    end
  end

  def self.parse!
    unless term_name = ENV["TERM"]?
      raise "No terminal set in environment variable TERM."
    end

    parse_for_term term_name
  end

  def self.parse_for_term(term_name)
    unless db_path = Searcher.dbpath_for_term term_name
      raise "No terminfo database found for terminal #{term_name}"
    end

    parse_db db_path
  end

  def self.parse_db(db_path)
    File.open db_path do |file|
      Parser.from_io file
    end
  rescue ex : IO::EOFError
    raise FileTooShort.new "Unexpected end of file #{db_path.inspect}", db: db_path
  end
end
