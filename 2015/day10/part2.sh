#!/bin/bash

# --- Part Two ---
#
# Neat, right? You might also enjoy hearing John Conway talking
# about this sequence (that's Conway of Conway's Game of Life fame).
#
# Now, starting again with the digits in your puzzle input, apply this
# process 50 times. What is the length of the new result?

input=$(cat input.txt)               # store initial value in $input var

for i in {1..50}; do                 # iterate 50x
input=$(                             # overwrite $input with result
    fold -1 <<<$input |              # put each char on its own line
    uniq -c |                        # uniq -c gives count of successive chars
    gawk '{ printf $1$2 }'           # format back into single line without spaces
)
done
echo -n $input | wc -c               # get count of characters in result