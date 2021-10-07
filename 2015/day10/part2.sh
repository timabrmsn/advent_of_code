#!/bin/bash

# --- Part Two ---
#
# Neat, right? You might also enjoy hearing John Conway talking
# about this sequence (that's Conway of Conway's Game of Life fame).
#
# Now, starting again with the digits in your puzzle input, apply this
# process 50 times. What is the length of the new result?

input=$(cat input.txt)               # store initial value in $input var

for x in {1..50}; do                 # iterate 50 times
input=$(echo $input |                # overwrite $input var with result
fold -1 |                            # print each character from $input on its own line
gawk '
NR == 1 {                            # for the first line only
  last=$1                            # initiate $last to first char
  count=1                            # count first char
  next                               # skip to processing the next line
}
$1 ~ last {                          # if current char is same as last seen
  count++                            # increment $count
}
$1 !~ last {                         # if current char is different than last
  printf count last                  # print count & last char
  count=1                            # reset count
  last=$1                            # set current char to $last
}
END { printf count last }')          # handle last char
done
echo -n $input | wc -c