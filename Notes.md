## NCurses 6 introduced a terminfo format with 32 bit numbers instead of 16 bits.

Relevant commit: https://github.com/ThomasDickey/ncurses-snapshots/commit/7ac78d357c4ea2d4199a742b195eb4a8ce8dad55#diff-2c0786db969084ba9e087d82f8275e0bR85

## For param strings

Either:
1. Read the string EACH TIME you use the param string
  - Read the string (byte by byte) and do things accordingly
  - Read the string, iterator produces a stream of steps, consumer do things accordingly
2. Read the string ONCE (compilation step), then use the compiled list of steps to use the param string
  - First compile the param string to a list of steps, then use this list to do things accordingly
