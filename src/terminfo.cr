require "./terminfo/*"

module Terminfo
  class Error < Exception
  end

  class FileTooShort < Error
    getter db_path : String

    def initialize(@db_path)
      super "Unexpected end of file #{db_path.inspect}"
    end
  end

  def self.from_term(term_name)
    unless db_path = Searcher.dbpath_for_term term_name
      raise "No terminfo database found for terminal #{term_name}"
    end

    from_file db_path
  end

  def self.from_file(db_path)
    File.open db_path do |file|
      Parser.new.parse file
    end
  rescue ex : IO::EOFError
    raise FileTooShort.new db_path
  end
end
