require "./names"

module Terminfo

  class Database
    def self.new_empty
      new
    end

    getter names = Array(String).new
    getter booleans = Hash(Int32, Bool).new(initial_capacity: KeyNames::Booleans.size)
    getter numbers = Hash(Int32, Int16).new(initial_capacity: KeyNames::Numbers.size)
    getter strings = Hash(Int32, Bytes).new(initial_capacity: KeyNames::Strings.size)

    def initialize(@names, @booleans, @numbers, @strings)
    end

    private def initialize
    end

    {% for ti_type, cr_type in {boolean: Bool, number: Int16, string: String } %}
      # TODO: doc
      def get_{{ ti_type.id }}?(key : String)
        if idx = KeyNames.idx_for_boolean? key
          @booleans[idx]?
        end
      end

      # TODO: doc
      def get_{{ ti_type.id }}!(key : String)
        get_{{ ti_type.id }}?(key) || raise InvalidKeyError.new(key, {{ ti_type.id.stringify }})
      end

      # TODO: doc
      def set_{{ ti_type.id }}(key : String, value : {{ cr_type.id }})
        if idx = KeyNames.idx_for_{{ ti_type.id }}? key
          @booleans[idx] = value
        else
          raise InvalidKeyError.new(key, {{ ti_type.id.stringify }})
        end
      end
    {% end %}
  end

  class InvalidKeyError < Exception
    getter key : String
    getter type : String

    def initialize(@key, @type)
      super "Invalid terminfo key '#{key}' for type '#{type}'"
    end
  end
end
