#!/bin/bash

# --- Part Two ---
#
# Now, given the same instructions, find the position of the first 
# character that causes him to enter the basement (floor -1). The 
# first character in the instructions has position 1, the second 
# character has position 2, and so on.
#
# For example:
#
# ) causes him to enter the basement at character position 1.
# ()()) causes him to enter the basement at character position 5.
#
# What is the position of the character that causes Santa to first enter the basement?

fold -1 input.txt |         # put each char of file on it's own line for easier processing in awk
gawk '/\(/ { total++ }      # increment on "("
      /\)/ { total-- }      # decrement on ")"
      { if ( total < 0 ) {  # check for going < 0
        print NR            # print number of records processed
        exit                # no need to continue
      }}'