#!/bin/bash

# --- Part Two ---
#
# The next year, to speed up the process, Santa creates a robot
# version of himself, Robo-Santa, to deliver presents with him.
#
# Santa and Robo-Santa start at the same location (delivering two
# presents to the same starting house), then take turns moving based
# on instructions from the elf, who is eggnoggedly reading from the
# same script as the previous year.
#
# This year, how many houses receive at least one present?
#
# For example:
#
# ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa goes south.
# ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where they started.
# ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and Robo-Santa going the other.

fold -1 input.txt |    # put each char of file on it's own line for easier processing in awk
gawk '
BEGIN {
  x=y=0                       # initialize real santa as x & y
  rx=ry=0                     # initialize robo santa as rx & ry
  map[0","0]+=2               # visit initial house in array
}
{
  if (NR % 2) {               # if record number is odd (real santa moves)
    if ($0 ~ /\^/) { y++ }    # north: increment y
    if ($0 ~ /v/)  { y-- }    # south: decrement y
    if ($0 ~ />/)  { x++ }    # east:  increment x
    if ($0 ~ /</)  { x-- }    # west:  decrement x
    map[x","y]++              # mark house santa visited
  } else {                    # robo santa moves on even records
    if ($0 ~ /\^/) { ry++ }   # north: increment ry
    if ($0 ~ /v/)  { ry-- }   # south: decrement ry
    if ($0 ~ />/)  { rx++ }   # east:  increment rx
    if ($0 ~ /</)  { rx-- }   # west:  decrement rx
    map[rx","ry]++            # mark house robo santa visited
  }
}
END {
  print length(map)           # print total houses visited
}'