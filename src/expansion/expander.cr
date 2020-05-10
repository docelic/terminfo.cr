# based on https://github.com/meh/rust-terminfo/blob/master/src/expand.rs
# and https://stebalien.github.io/doc/term/src/term/terminfo/parm.rs.html

require "./errors"
require "./tokens"

module Terminfo::Expansion
  abstract struct Parameter
    def self.from(str : ::String)
      String.new str
    end

    def self.from(num : Int)
      Number.new num
    end

    record String, value : ::String
    record Number, value : Int32
  end

  # TODO: doc
  # blablabla
  class Expander
    def expand(param_str : Bytes, *args)
      # let's start by parsing the param string to a list of tokens
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
          Token::Format.new :chr
        when 's'.ord
          io.skip(1) # skip s

          # print pop() like %s in printf
          Token::Format.new :str
        when 'p'.ord # %p[1-9]
          io.skip(1) # skip p

          # push i'th parameter
          if '1'.ord <= (byte = read_byte!(io)) <= '9'.ord
            Token::PushParameter.new index: (byte - '1'.ord)
          else
            raise Error::InvalidParameterNum.new byte
          end
        when 'P'.ord # %P[a-z] / %P[A-Z]
          io.skip(1) # skip P

          # read var name
          var_byte = read_byte!(io)

          if 'a'.ord <= var_byte <= 'z'.ord
            # set dynamic variable [a-z] to pop()
            Token::SetVar.new index: (var_byte - 'a'.ord), to: :dynamic
          elsif 'A'.ord <= var_byte <= 'Z'.ord
            # set static variable [A-Z] to pop()
            Token::SetVar.new index: (var_byte - 'A'.ord), to: :static
          else
            raise Error::InvalidVariableName.new var_byte
          end
        when 'g'.ord # %g[a-z] / %g[A-Z]
          io.skip(1) # skip g

          # The terms "static" and "dynamic" are misleading. Historically, these
          # are simply two different sets of variables, whose values are not reset
          # between calls to tparm. However, that fact is not documented in other
          # implementations. Relying on it will adversely impact portability to
          # other implementations.

          # read var name
          var_byte = read_byte!(io)

          if 'a'.ord <= var_byte <= 'z'.ord
            # get dynamic variable [a-z] and push it
            Token::GetVar.new index: byte, from: :dynamic
          elsif 'A'.ord <= var_byte <= 'Z'.ord
            # get static variable [A-Z] and push it
            Token::GetVar.new index: byte, from: :static
          else
            raise Error::InvalidVariableName.new byte
          end
        when '\''.ord # %'c'
          io.skip(1)  # skip '

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
            int_str = String.new(io.to_slice[int_start, int_length])
            if int = int_str.to_i
              Token::PushIntConstant.new int
            else
              raise Error::InvalidIntConstant.new int_str
            end
          end
        when 'l'.ord # %l
          io.skip(1) # skip l

          # push strlen(pop())
          Token::PushStrlen.new
        when '+'.ord, '-'.ord, '*'.ord, '/'.ord, 'm'.ord # %+ %- %* %/ %m
          # arithmetic (%m is mod): push(pop() op pop())
          case op = read_byte!(io)
          when '+'.ord
            Token::Operation::Binary.new :add
          when '-'.ord
            Token::Operation::Binary.new :substract
          when '*'.ord
            Token::Operation::Binary.new :multiply
          when '/'.ord
            Token::Operation::Binary.new :divide
          when 'm'.ord
            Token::Operation::Binary.new :remainder
          else
            raise "unreachable!"
          end
        when '&'.ord, '|'.ord, '^'.ord # %& %| %^
          # bit operations (AND, OR and exclusive-OR): push(pop() op pop())
          case op = read_byte!(io)
          when '&'.ord
            Token::Operation::Binary.new :and
          when '|'.ord
            Token::Operation::Binary.new :or
          when '^'.ord
            Token::Operation::Binary.new :xor
          else
            raise "unreachable!"
          end
        when '='.ord, '>'.ord, '<'.ord # %= %> %<
          # logical operations: push(pop() op pop())
          case op = read_byte!(io)
          when '='.ord
            Token::Operation::Binary.new :equal
          when '>'.ord
            Token::Operation::Binary.new :greater
          when '<'.ord
            Token::Operation::Binary.new :lesser
          else
            raise "unreachable!"
          end
        when 'A'.ord, 'O'.ord # %A, %O
          # logical AND and OR operations (for conditionals)
          case op = read_byte!(io)
          when 'A'.ord
            Token::Operation::Binary.new :logical_and
          when '0'.ord
            Token::Operation::Binary.new :logical_or
          else
            raise "unreachable!"
          end
        when '!'.ord, '~'.ord # %! %~
          # unary operations (logical and bit complement): push(op pop())
          case op = read_byte!(io)
          when '!'.ord
            Token::Operation::Unary.new :logical_not
          when '~'.ord
            Token::Operation::Unary.new :bit_complement
          else
            raise "unreachable!"
          end
        when 'i'.ord # %i
          io.skip(1) # skip i

          # add 1 to first two parameters (for ANSI terminals)
          Token::Operation::Increment.new
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
            Token::Conditional.new :if
          when 't'.ord
            Token::Conditional.new :then
          when 'e'.ord
            Token::Conditional.new :else
          when ';'.ord
            Token::Conditional.new :end_if
          else
            raise "unreachable!"
          end
        else
          # probably a format string

          # %[[:]flags][width[.precision]][doxXs]
          # as in printf, flags are [-+#] and space. Use a ':' to allow the next
          # character to be a '-' flag, avoiding interpreting "%-" as an operator
          fmt_start = io.pos

          flags = Token::Format::Flags.new
          # TODO: read :
          # TODO: read flags
          # TODO: read width
          # TODO: read . precision

          # read doxXs
          case format_byte = read_byte!(io)
          when 'd'.ord
            Token::Format.new :dec, flags: flags
          when 'o'.ord
            Token::Format.new :oct, flags: flags
          when 'x'.ord
            Token::Format.new :hex, flags: flags
          when 'X'.ord
            Token::Format.new :big_hex, flags: flags
          when 's'.ord
            # FIXME: huh I alread have a `when 's'.ord` at the beginning of
            # the % case block..
            Token::Format.new :str, flags: flags
          else
            raise Error::InvalidFormatString.new "At pos #{io.pos} format is '#{format_byte.chr}' (#{format_byte})"
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

    private def read_byte!(io)
      io.read_byte || raise IO::EOFError.new
    end

    private def peek_byte!(io)
      io.peek[0]? || raise IO::EOFError.new
    end
  end
end
