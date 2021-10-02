#!/bin/bash

# --- Day 6: Probably a Fire Hazard ---
#
# Because your neighbors keep defeating you in the holiday house
# decorating contest year after year, you've decided to deploy one
# million lights in a 1000x1000 grid.
#
# Furthermore, because you've been especially nice this year, Santa
# has mailed you instructions on how to display the ideal lighting
# configuration.
#
# Lights in your grid are numbered from 0 to 999 in each direction;
# the lights at each corner are at 0,0, 0,999, 999,999, and 999,0. 
# The instructions include whether to turn on, turn off, or toggle 
# various inclusive ranges given as coordinate pairs. Each coordinate 
# pair represents opposite corners of a rectangle, inclusive; a 
# coordinate pair like 0,0 through 2,2 therefore refers to 9 lights 
# in a 3x3 square. The lights all start turned off.
#
# To defeat your neighbors this year, all you have to do is set up 
# your lights by doing the instructions Santa sent you in order.
#
# For example:
#
# turn on 0,0 through 999,999 would turn on (or leave on) every light.
# toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.
# turn off 499,499 through 500,500 would turn off (or leave off) the middle four lights.
# After following the instructions, how many lights are lit?

gawk '
{ 
  match($0, /(turn on|turn off|toggle) ([0-9]+),([0-9]+) through ([0-9]+),([0-9]+)/, a)   # extract values via regex
  
  for ( x = a[2]; x <= a[4]; x++ ) {                                                      # loop over coordinates
    for ( y = a[3]; y <= a[5]; y++ ) {
      switch (a[1]) {                                                
        case /on/:
          lightmap[x","y] = 1; break                                                      # flip lights on
        case /off/:
          lightmap[x","y] = 0; break                                                      # flip lights off
        case /toggle/:
          lightmap[x","y] = !lightmap[x","y]; break                                       # toggle lights
      }
    } 
  }  
}  
END {  
  for (coord in lightmap) { total += lightmap[coord] }                                    # sum lights that are on
  print total
}' input.txt