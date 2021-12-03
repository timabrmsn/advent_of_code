#!/bin/bash

# --- Part Two ---
#
# You flip the instructions over; Santa goes on to point out
# that this is all just an implementation of Conway's Game of
# Life. At least, it was, until you notice that something's
# wrong with the grid of lights you bought: four lights, one
# in each corner, are stuck on and can't be turned off. The
# example above will actually run like this:
#
# Initial state:
# ##.#.#
# ...##.
# #....#
# ..#...
# #.#..#
# ####.#
#
# After 1 step:
# #.##.#
# ####.#
# ...##.
# ......
# #...#.
# #.####
#
# After 2 steps:
# #..#.#
# #....#
# .#.##.
# ...##.
# .#..##
# ##.###
#
# After 3 steps:
# #...##
# ####.#
# ..##.#
# ......
# ##....
# ####.#
#
# After 4 steps:
# #.####
# #....#
# ...#..
# .##...
# #.....
# #.#..#
#
# After 5 steps:
# ##.###
# .##..#
# .##...
# .##...
# #.#...
# ##...#
# After 5 steps, this example now has 17 lights on.
#
# In your grid of 100x100 lights, given your initial configuration,
# but with the four corners always in the on state, how many lights
# are on after 100 steps?

gawk '{
  split($0, a, "")
  for (x in a) {
      state[1][NR][x] = (a[x] == "#")
  }
}
function flip(x,y,i,      sum) {
    if ((x==1) && (y==1)) return 1
    if ((x==1) && (y==100)) return 1
    if ((x==100) && (y==1)) return 1
    if ((x==100) && (y==100)) return 1
    sum += state[i][x-1][y+1]
    sum += state[i][x][y+1]
    sum += state[i][x+1][y+1]
    sum += state[i][x-1][y]
    sum += state[i][x+1][y]
    sum += state[i][x-1][y-1]
    sum += state[i][x][y-1]
    sum += state[i][x+1][y-1]
    if ( state[i][x][y] == 1 ) {
        return ((sum == 2) || (sum == 3))
    }
    else {
        return ( sum == 3 )
    }
}
END {
state[1][1][1] = state[1][1][100] = state[1][100][1] = state[1][100][100] = 1
for (i=1; i<=100; i++) {
    sum = 0
    for (x=1; x<=100; x++) {
        for (y=1; y<=100; y++) {
            status = flip(x,y,i)
            state[i+1][x][y] = status
            sum += status
        }
    }
  } print sum
}' input.txt