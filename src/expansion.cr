# based on https://github.com/meh/rust-terminfo/blob/master/src/expand.rs
# and https://stebalien.github.io/doc/term/src/term/terminfo/parm.rs.html

module Terminfo::Expansion
  # ---- Tokens

  class Token
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

  # ---- Exceptions

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

  # ---- Expander

  class Expander
    def expand(param_str : Bytes, *args)
      # let's start by parsing the param string to AST nodes
      to_tokens param_str
    end

    def to_tokens(param_str : Bytes)
      io = IO::Memory.new param_str, writeable: false

      arr = [] of Token
      while token = next_token(io)
        arr << token
      end
      p! arr
    end

    def next_token(io : IO::Memory) : Token?
      return nil if io.pos == io.bytesize # no more char

      initial_pos = io.pos
      case byte = peek_byte!(io)
      when '%'.ord
        io.skip(1) # skip %

        case byte = peek_byte!(io)
        when '%'.ord
          io.skip(1) # skip %

          # outputs '%'
          Token::RawText.new "%".to_slice
        when 'c'.ord
          io.skip(1) # skip c

          # print pop() like %c in printf
          Token::FormattedPrint.new :chr
        when 's'.ord
          io.skip(1) # skip s

          # print pop() like %s in printf
          Token::FormattedPrint.new :str
        when 'p'.ord # %p[1-9]
          io.skip(1) # skip p

          # push i'th parameter
          if '1'.ord <= (byte = read_byte!(io)) <= '9'.ord
            Token::PushParameter.new name: byte
          else
            raise Error::InvalidParameterNum.new byte
          end
        when 'P'.ord # %P[a-z]
          io.skip(1) # skip P

          # set dynamic variable [a-z] to pop()
          if 'a'.ord <= (byte = read_byte!(io)) <= 'z'.ord
            Token::SetVar.new name: byte, to: :dynamic
          else
            raise Error::InvalidVariableName.new byte
          end

        when 'g'.ord # %g[a-z]
          io.skip(1) # skip g

          # get dynamic variable [a-z] and push it
          if 'a'.ord <= (byte = read_byte!(io)) <= 'z'.ord
            Token::GetVar.new name: byte, from: :dynamic
          else
            raise Error::InvalidVariableName.new byte
          end

        when 'P'.ord # %P[A-Z]
          io.skip(1) # skip P

          # set static variable [a-z] to pop()
          if 'A'.ord <= (byte = read_byte!(io)) <= 'Z'.ord
            Token::SetVar.new name: byte, to: :static
          else
            raise Error::InvalidVariableName.new byte
          end

        when 'g'.ord # %g[A-Z]
          io.skip(1) # skip g

          # get static variable [a-z] and push it
          # The terms "static" and "dynamic" are misleading. Historically, these
          # are simply two different sets of variables, whose values are not reset
          # between calls to tparm. However, that fact is not documented in other
          # implementations. Relying on it will adversely impact portability to
          # other implementations.
          # read var name
          if 'A'.ord <= (byte = read_byte!(io)) <= 'Z'.ord
            Token::GetVar.new name: byte, from: :static
          else
            raise Error::InvalidVariableName.new byte
          end

        when '\''.ord # %'c'
          io.skip(1) # skip '

          # char constant c
          byte = read_byte!(io)
          unless read_byte!(io) == '\''.ord
            raise Error::MalformedCharConstant.new
          end
          Token::PushIntConstant.new byte.to_i

        when '{'.ord # %{nn}
          io.skip(1) # skip {

          # integer constant nn (any numbers between { and })
          int_start = io.pos
          int_length = 0
          while '0'.ord <= peek_byte!(io) <= '9'.ord
            int_length += 1
            io.skip(1)
          end

          unless read_byte!(io) == '}'.ord
            raise Error::MalformedIntConstant.new
          end

          if int_length == 0
            Token::PushIntConstant.new 0
          else
            # FIXME: use Slice#to_i when available instead of creating a tmp String
            # int = io.to_slice[int_start, int_length].to_i
            int = String.new(io.to_slice[int_start, int_length]).to_i
            Token::PushIntConstant.new int
          end

        when 'l'.ord # %l
          io.skip(1) # skip l

          # push strlen(pop())
          Token::Strlen.new

        when '+'.ord, '-'.ord, '*'.ord, '/'.ord, 'm'.ord # %+ %- %* %/ %m
          # arithmetic (%m is mod): push(pop() op pop())
          case op = read_byte!(io)
          when '+'.ord
            Token::Binary.new :add
          when '-'.ord
            Token::Binary.new :substract
          when '*'.ord
            Token::Binary.new :multiply
          when '/'.ord
            Token::Binary.new :divide
          when 'm'.ord
            Token::Binary.new :remainder
          else
            raise "unreachable!"
          end
        when '&'.ord, '|'.ord, '^'.ord # %& %| %^
          # bit operations (AND, OR and exclusive-OR): push(pop() op pop())
          case op = read_byte!(io)
          when '&'.ord
            Token::Binary.new :and
          when '|'.ord
            Token::Binary.new :or
          when '^'.ord
            Token::Binary.new :xor
          else
            raise "unreachable!"
          end
        when '='.ord, '>'.ord, '<'.ord # %= %> %<
          # logical operations: push(pop() op pop())
          case op = read_byte!(io)
          when '='.ord
            Token::Binary.new :equal
          when '>'.ord
            Token::Binary.new :greater
          when '<'.ord
            Token::Binary.new :lesser
          else
            raise "unreachable!"
          end
        when 'A'.ord, 'O'.ord # %A, %O
          # logical AND and OR operations (for conditionals)
          case op = read_byte!(io)
          when 'A'.ord
            Token::Binary.new :logical_and
          when '0'.ord
            Token::Binary.new :logical_or
          else
            raise "unreachable!"
          end
        when '!'.ord, '~'.ord # %! %~
          # unary operations (logical and bit complement): push(op pop())
          case op = read_byte!(io)
          when '!'.ord
            Token::Unary.new :logical_not
          when '~'.ord
            Token::Unary.new :bit_complement
          else
            raise "unreachable!"
          end
        when 'i'.ord # %i
          io.skip(1) # skip i

          # add 1 to first two parameters (for ANSI terminals)
          Token::IncTwoFirstParams.new
        when '?'.ord, 't'.ord, 'e'.ord, ';'.ord # %? expr %t thenpart %e elsepart %;
          # This forms an if-then-else. The %e elsepart is optional.
          # Usually the %? expr part pushes a value onto the stack, and %t pops
          # it from the stack, testing if it is nonzero (true). If it is zero (false),
          # control passes to the %e (else) part.
          # It is possible to form else-if's a la Algol 68:
          #   %? c1 %t b1 %e c2 %t b2 %e c3 %t b3 %e c4 %t b4 %e %;
          # where ci are conditions, bi are bodies.
          case ctrl_flow = read_byte!(io)
          when '?'.ord
            Token::Conditionnal.new :if
          when 't'.ord
            Token::Conditionnal.new :then
          when 'e'.ord
            Token::Conditionnal.new :else
          when ';'.ord
            Token::Conditionnal.new :end_if
          else
            raise "unreachable!"
          end
        else # probably a format string
          # %[[:]flags][width[.precision]][doxXs]
          # as in printf, flags are [-+#] and space. Use a ':' to allow the next
          # character to be a '-' flag, avoiding interpreting "%-" as an operator
          fmt_start = io.pos

          flags = Token::FormattedPrint::Flags.new
          # TODO: read :
          # TODO: read flags
          # TODO: read width
          # TODO: read . precision

          # read doxXs
          case byte = io.read_byte
          when 'd'.ord
            Token::FormattedPrint.new :dec, flags: flags
          when 'o'.ord
            Token::FormattedPrint.new :oct, flags: flags
          when 'x'.ord
            Token::FormattedPrint.new :hex, flags: flags
          when 'X'.ord
            Token::FormattedPrint.new :big_hex, flags: flags
          when 's'.ord
            # FIXME: huh I alread have a `when 's'.ord` at the beginning of
            # the % case block..
            Token::FormattedPrint.new :str, flags: flags
          else
            raise Error::InvalidFormatString.new
          end
        end
      else
        # There is raw text!
        rest = io.to_slice + initial_pos
        if percent_index = rest.index '%'.ord
          io.skip(percent_index) # skip until just before the next % char
          Token::RawText.new rest[0, percent_index]
        else
          # from initial_pos to the end
          io.skip_to_end
          Token::RawText.new rest
        end
      end
    end

    def read_byte!(io)
      io.read_byte || raise IO::EOFError.new
    end

    def peek_byte!(io)
      io.peek[0]? || raise IO::EOFError.new
    end
  end
end
