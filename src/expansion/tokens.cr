module Terminfo::Expansion
  abstract class Token # TODO?: class → struct
  end

  abstract class Token::Operation < Token
    class Binary < Operation
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

    class Unary < Operation
      enum Op
        LogicalNot
        BitComplement
      end

      getter op

      def initialize(@op : Op)
      end
    end

    class Increment < Operation
    end
  end


  class Token::RawText < Token
    getter text

    def initialize(@text : Bytes)
    end
  end

  class Token::Conditional < Token
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

  enum GetSetVarWhere
    Dynamic
    Static
  end

  class Token::GetVar < Token
    getter index, where

    def initialize(@index : UInt8, from @where : GetSetVarWhere)
    end
  end

  class Token::SetVar < Token
    getter index, where

    def initialize(@index : UInt8, to @where : GetSetVarWhere)
    end
  end

  class Token::PushParameter < Token
    getter index

    def initialize(@index : UInt8)
    end
  end

  class Token::PushIntConstant < Token # FIXME: not always a constant...?
    getter value

    def initialize(@value : Int32)
    end
  end

  class Token::PushStrlen < Token
  end

  class Token::PrintFormat < Token
    class Flags
      property alternate = false
      property left = false
      property sign = false
      property space = false
      property width : Int32? = nil
      property precision : Int32? = nil
    end

    enum Format
      Dec    # 236 : 236
      Oct    # 236 : 354
      Hex    # 236 : ec
      BigHex # 236 : EC
      Uni    # like Dec but as a UInt32
      Chr    # 126 : ~
      Str
    end

    getter format, flags

    def initialize(@format : Format, @flags : Flags? = nil)
    end
  end
end
