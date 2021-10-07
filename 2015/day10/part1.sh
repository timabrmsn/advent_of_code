#!/bin/bash

# --- Day 10: Elves Look, Elves Say ---
#
# Today, the Elves are playing a game called look-and-say. They take
# turns making sequences by reading aloud the previous sequence and
# using that reading as the next sequence. For example, 211 is read
# as "one two, two ones", which becomes 1221 (1 2, 2 1s).
#
# Look-and-say sequences are generated iteratively, using the previous
# value as input for the next step. For each step, take the previous
# value, and replace each run of digits (like 111) with the number of
# digits (3) followed by the digit itself (1).
#
# For example:
#
# 1 becomes 11 (1 copy of digit 1).
# 11 becomes 21 (2 copies of digit 1).
# 21 becomes 1211 (one 2 followed by one 1).
# 1211 becomes 111221 (one 1, one 2, and two 1s).
# 111221 becomes 312211 (three 1s, two 2s, and one 1).
# Starting with the digits in your puzzle input, apply this process 40 times. What is the length of the result?

input=$(cat input.txt)               # store initial value in $input var

for x in {1..40}; do                 # iterate 40 times
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