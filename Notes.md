## For param strings

Either:
1. Read the string EACH TIME you use the param string
  - Read the string (byte by byte) and do things accordingly
  - Read the string, iterator produces a stream of steps, consumer do things accordingly
2. Read the string ONCE (compilation step), then use the compiled list of steps to use the param string
  - First compile the param string to a list of steps, then use this list to do things accordingly
