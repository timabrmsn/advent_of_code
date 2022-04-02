#!/bin/bash

# --- Day 9: All in a Single Night ---
#
# Every year, Santa manages to deliver all of his presents in a
# single night.
#
# This year, however, he has some new locations to visit; his elves
# have provided him the distances between every pair of locations.
# He can start and end at any two (different) locations he wants,
# but he must visit each location exactly once. What is the shortest
# distance he can travel to achieve this?
#
# For example, given the following distances:
#
# - London to Dublin = 464
# - London to Belfast = 518
# - Dublin to Belfast = 141
# The possible routes are therefore:
#
# - Dublin -> London -> Belfast = 982
# - London -> Dublin -> Belfast = 605
# - London -> Belfast -> Dublin = 659
# - Dublin -> Belfast -> London = 659
# - Belfast -> Dublin -> London = 605
# - Belfast -> London -> Dublin = 982
# The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.
#
# What is the distance of the shortest route?

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
' input.txt | sort | head -1                         # sort all results to get lowest number, take first result