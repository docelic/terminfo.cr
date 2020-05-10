module Terminfo::Expansion
  abstract class Token
  end

  class Token::Binary < Token
    enum Op
      Add
      Substract
      Multiply
      Divide
      Remainder
      And
      Or
      Xor
      Equal
      Greater
      Lesser
      LogicalAnd
      LogicalOr
    end

    getter op

    def initialize(@op : Op)
    end
  end

  class Token::Unary < Token
    enum Op
      LogicalNot
      BitComplement
    end

    getter op

    def initialize(@op : Op)
    end
  end

  class Token::RawText < Token
    getter text

    def initialize(@text : Bytes)
    end
  end

  class Token::Conditionnal < Token
    enum Kind
      If
      Then
      Else
      EndIf
    end

    getter kind

    def initialize(@kind : Kind)
    end
  end

  class Token::IncTwoFirstParams < Token
  end

  enum GetSetVarWhere
    Dynamic
    Static
  end

  class Token::GetVar < Token
    getter name, where

    def initialize(@name : UInt8, from @where : GetSetVarWhere)
    end
  end

  class Token::SetVar < Token
    getter name, where

    def initialize(@name : UInt8, to @where : GetSetVarWhere)
    end
  end

  class Token::PushParameter < Token
    getter num : UInt8

    def initialize(name : UInt8)
      @num = name - '1'.ord # to get num:0 for name:'1'
    end
  end

  class Token::PushIntConstant < Token
    getter value

    def initialize(@value : Int32)
    end
  end

  class Token::FormattedPrint < Token
    class Flags
      property alternate = false
      property left = false
      property sign = false
      property space = false
      property width : Int32?
      property precision : Int32?
    end

    enum Format
      Dec
      Oct
      Hex
      BigHex
      Str
      Chr
      Uni
    end

    getter format, flags

    def initialize(@format : Format, @flags : Flags? = nil)
    end
  end

  class Token::Strlen < Token
  end
end
