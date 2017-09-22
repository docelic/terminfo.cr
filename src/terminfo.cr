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

    unless db_path = Searcher.dbpath_for_term term_name
      raise "terminfo database found for terminal #{term_name}"
    end

    begin
      parse_terminfo db_path
    rescue ex : IO::EOFError
      raise FileTooShort.new "Unexpected end of file #{db_path.inspect}", db: db_path
    end
  end
end
