#!/bin/bash

# --- Part Two ---
#
# You just finish implementing your winning light pattern when you
# realize you mistranslated Santa's message from Ancient Nordic Elvish.
#
# The light grid you bought actually has individual brightness controls;
# each light can have a brightness of zero or more. The lights all 
# start at zero.
#
# The phrase turn on actually means that you should increase the
# brightness of those lights by 1.
#
# The phrase turn off actually means that you should decrease the
# brightness of those lights by 1, to a minimum of zero.
#
# The phrase toggle actually means that you should increase the
# brightness of those lights by 2.
#
# What is the total brightness of all lights combined after following
# Santa's instructions?
#
# For example:
#
# turn on 0,0 through 0,0 would increase the total brightness by 1.
# toggle 0,0 through 999,999 would increase the total brightness by 2000000.

gawk '
{ 
  match($0, /(turn on|turn off|toggle) ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)/, a)   # extract values via regex
  
  for ( x = a[2]; x <= a[4]; x++ ) {                                                      # loop over coordinates
    for ( y = a[3]; y <= a[5]; y++ ) {
      switch (a[1]) {
        case /on/:
          lightmap[x","y]++; break                                                        # +1 brightness for "on"
        case /off/:
          lightmap[x","y] == 0 ? 0 : lightmap[x","y]--; break                             # -1 brightness for "off"
        case /toggle/:
          lightmap[x","y] += 2; break                                                     # +2 brightness for "toggle"
      }                                               
    }  
  }  
}  
END {  
  for (coord in lightmap) { total += lightmap[coord] }                                    # sum light brightness
  print total
}' input.txt