require "./**"

module Terminfo
  class Error < Exception
  end

  class NotFoundError < Error
    getter term_name : String

    def initialize(@term_name)
      super "No terminfo database found for terminal #{term_name}"
    end
  end

  class ReadError < Error
    getter db_path : String

    def initialize(@db_path, cause = nil)
      super %(Unexpected end of terminfo file "#{@db_path}"), cause
    end
  end

  def self.from_term(term_name)
    unless db_path = Searcher.dbpath_for_term(term_name)
      raise NotFoundError.new term_name
    end

    {from_file(db_path), db_path}
  end

  def self.from_file(db_path)
    File.open db_path do |file|
      Parser.new.parse file
    end
  rescue ex : IO::EOFError
    raise ReadError.new db_path, cause: ex
  end
end
