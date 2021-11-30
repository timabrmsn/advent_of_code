#!/bin/bash

# --- Part Two ---
#
# While playing with all the containers in the kitchen, another
# load of eggnog arrives! The shipping and receiving department
# is requesting as many containers as you can spare.
#
# Find the minimum number of containers that can exactly fit all
# 150 liters of eggnog. How many different ways can you fill that
# number of containers and still hold exactly 150 litres?
#
# In the example above, the minimum number of containers was two.
# There were three ways to use that many containers, and so the
# answer there would be 3.


list=$(jq -cs < input.txt)              # convert input text to list
{                                       # bracket cmd so we can pipe out after HEREDOC
python - <<HERE                         # python!
import itertools as it                  # itertools is great
for i in range(1, len($list)):          # for each length i 
  for c in it.combinations($list, i):   # get all combinations of lists length i from our main list
    if sum(c) == 150:                   # if the sum of those == 150
      print(list(c))                    # print the list
HERE  
} 2>/dev/null |                         # silence broken pipe errors from python
gawk 'NR==1 {LEN=NF}                    # for the first record, save the number of fields (our minimum)
{ 
  if (NF==LEN) { print }                # for every combination that matches the minimum, print it
  else { exit }                         # once we go over the min, we can quit
}' | wc -l                              # count how many we get