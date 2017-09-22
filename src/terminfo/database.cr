module Terminfo
  class Database
    getter names : Array(String)
    getter bools : Hash(String, Bool)
    getter numbers : Hash(String, Int16)
    getter strings : Hash(String, Bytes)

    def initialize(@names, @bools, @numbers, @strings)
    end
  end
end
