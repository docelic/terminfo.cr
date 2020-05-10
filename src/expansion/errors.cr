module Terminfo::Expansion
  class Error < Exception
    class InvalidVariableName < Error
      def initialize(@byte : UInt8)
        super "Invalid variable name '#{@byte}'"
      end
    end

    class InvalidParameterNum < Error
      def initialize(@byte : UInt8)
        super "Invalid parameter num '#{@byte}'"
      end
    end

    class InvalidFormatString < Error
    end

    class MalformedIntConstant < Error
    end

    class MalformedCharConstant < Error
    end
  end
end
