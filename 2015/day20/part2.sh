#!/bin/bash

# --- Part Two ---
#
# The Elves decide they don't want to visit an infinite number of houses. Instead, each Elf will stop after delivering
# presents to 50 houses. To make up for it, they decide to deliver presents equal to eleven times their number at each
# house.
#
# With these changes, what is the new lowest house number of the house to get at least as many presents as the number
# in your puzzle input?

awk -v target=$(cat input.txt) '
{
  sum = 0
  for (i=1; i<=$1; i++) {
    if ($1 <= i*50) {
      if ($1 % i == 0) {
        sum += i
        sum += ($1 / i)
      }
    }
  }
  print (sum*11)
  if (sum*11 > target) {
    print $1
    exit
  }
}' <(seq 10 10 inf)