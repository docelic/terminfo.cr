# Terminfo database discovery, compatible with ncurses.
#
# Does not support hashed database, only filesystem!
module Terminfo::Searcher
  # Returns the path to the terminfo database of terminal *term*.
  def self.dbpath_for_term(term : String)
    dirs_to_search = [] of String

    # Find search directory
    # The terminfo manual says:
    #
    # > If  the  environment  variable  TERMINFO is set, it is interpreted
    # > as the pathname of a directory containing the compiled description
    # > you are working on.  Only that directory is searched.
    #
    # However, the ncurses manual says:
    #
    # > If the environment variable TERMINFO is defined, any program using
    # > curses checks for a local terminal definition  before  checking in
    # > the standard place.
    #
    # Given that ncurses is the defacto standard, we follow the ncurses manual.
    if dir = ENV["TERMINFO"]?
      dirs_to_search << dir
    end

    if dirs = ENV["TERMINFO_DIRS"]?
      dirs.split(':').each do |dir|
        if dir.empty?
          dirs_to_search << "/usr/share/terminfo"
        else
          dirs_to_search << dir
        end
      end
    else
      # Found nothing in TERMINFO_DIRS, use the default paths:
      # According to  /etc/terminfo/README, after looking at
      # ~/.terminfo, ncurses will search /etc/terminfo, then
      # /lib/terminfo, and eventually /usr/share/terminfo.
      # On Haiku the database can be found at /boot/system/data/terminfo
      if home_dir = ENV["HOME"]?
        dirs_to_search << File.join(home_dir, ".terminfo")
      end

      dirs_to_search << "/etc/terminfo"
      dirs_to_search << "/lib/terminfo"
      dirs_to_search << "/usr/share/terminfo"
      dirs_to_search << "/boot/system/data/terminfo"
    end

    # Look for the terminal in all of the search directories
    dirs_to_search.each do |dir|
      next unless Dir.exists? dir

      term_path = File.join(dir, term[0].to_s, term)
      return term_path if File.exists? term_path

      # on some installations the dir is named after the hex of the char
      # (e.g. OS X)
      term_path = File.join(dir, term[0].ord.to_s(16), term)
      return term_path if File.exists? term_path
    end

    nil
  end
end
