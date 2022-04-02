#!/bin/bash

# --- Part Two ---
#
# The next year, just to show off, Santa decides to take the route
# with the longest distance instead.
#
# He can still start and end at any two (different) locations he
# wants, and he still must visit each location exactly once.
#
# For example, given the distances above, the longest route would
# be 982 via (for example) Dublin -> London -> Belfast.
#
# What is the distance of the longest route?

gawk '{ 
  map[$1][$3] = $5                                   # store location > location relationships in an array of arrays
  map[$3][$1] = $5                                   # store the reverse since we can travel either way
}

function travel(loc, route, total) {                 # recursive function to walk through all possible paths
  split(route, a, ",")                               # split our tracked route on "," to determine how many places we have visited
  if ( length(a) == 8 ) {                            # if we have hit all 8 possible locations, end recursion and print result
      print total, route
      return
  }
  for (l in map[loc]) {                              # we need to visit all possible locations from the point we are at
      if (route !~ l) {                              # except for locations already visited on this path
          travel(l, route","l, total + map[loc][l])  # go to next location
      }
  }
}

END {
  for (location in map) {                            # for each location in the map
    travel(location, location, 0)                    # use that as a starting point for our travels
  }
}
' input.txt | sort -r | head -1                      # reverse sort all results to get highest number, take first result