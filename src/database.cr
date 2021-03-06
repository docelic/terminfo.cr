require "./names"

module Terminfo

  class Database
    getter names = Array(String).new
    getter booleans = Hash(Keys::Booleans, Bool).new(initial_capacity: KeyNames::Booleans.size)
    getter numbers = Hash(Keys::Numbers, Int16).new(initial_capacity: KeyNames::Numbers.size)
    getter strings = Hash(Keys::Strings, Bytes).new(initial_capacity: KeyNames::Strings.size)

    def initialize(@names, @booleans, @numbers, @strings)
    end

    def self.new_empty
      new
    end

    private def initialize
    end

    {% for key_type, cr_type in {Booleans: Bool, Numbers: Int16, Strings: Bytes} %}
      # Gets the `{{ cr_type }}` value for the key *key*, or `nil` if not set.
      def get?(key : Keys::{{ key_type.id }})
        if key.valid?
          @{{ key_type.id.downcase }}[key]?
        end
      end

      # Gets the `{{ cr_type }}` value for the key *key*, raises an InvalidKeyError if not set.
      def get!(key : Keys::{{ key_type.id }})
        if (value = get?(key)).nil?
          raise InvalidKeyError.new(key)
        end
        value
      end

      # Sets key *key* to value *value*, raises InvalidKeyError if *key* is invalid.
      def set(key : Keys::{{ key_type.id }}, value : {{ cr_type }})
        if key.valid?
          @{{ key_type.id.downcase }}[key] = value
        else
          raise InvalidKeyError.new(key)
        end
      end
    {% end %}
  end

  class InvalidKeyError < Exception
    getter key : Keys::Booleans | Keys::Numbers | Keys::Strings

    def initialize(@key)
      super "Invalid terminfo key '#{key}'"
    end
  end
end
