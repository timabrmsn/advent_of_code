#!/bin/bash

# --- Part Two ---
#
# Uh oh - the Accounting-Elves have realized that they double-counted
# everything red.
#
# Ignore any object (and all of its children) which has any property
# with the value "red". Do this only for objects ({...}), not arrays
# ([...]).
#
# - [1,2,3] still has a sum of 6.
# - [1,{"c":"red","b":2},3] now has a sum of 4, because the middle object is ignored.
# - {"d":"red","e":[1,2,3,4],"f":5} now has a sum of 0, because the entire structure is ignored.
# - [1,"red",5] has a sum of 6, because "red" in an array has no effect.

jq 'walk(                                                # walk through every object in the input
  if type == "object" then                               # only process objects (not arrays)
    if (to_entries | any(select(.value == "red"))) then  # check the object to see any of its keys has a value of "red"
      del(.)                                             # if so, delete the whole object
    else . end                                           # othewise leave it alone
  else . end) |                                          # also leave the arrays alone
[getpath(leaf_paths) | numbers] | add' input.txt         # flatten and count all the remaining values