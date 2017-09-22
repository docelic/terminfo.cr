require "./terminfo/*"

module Terminfo
  def self.parse!
    unless term_name = ENV["TERM"]?
      raise "No terminal set in environment variable TERM."
    end

    unless db_path = Searcher.dbpath_for_term term_name
      raise "terminfo database found for terminal #{term_name}"
    end

    parse_terminfo db_path
  end
end
