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
  a[1][NR][0]
  split($0, a[1][NR], "")
}
(NR == 1 || NR == 100) { 
    a[1][NR][1] == "#"
    a[1][NR][100] == "#"
}
function is_on(val) {
    if (val == "#") return 1
    else return 0
}
function flip(x,y,i,      sum) {
    if (((x == 1) && (y == 1)) ||
       ((x == 1) && (y == 100)) ||
       ((x == 100) && (y == 1)) ||
       ((x == 100) && (y == 100))) { 
        a[i+1][x][y] = "#"
        return 
    }
    sum += is_on(a[i][x-1][y+1])
    sum += is_on(a[i][x][y+1])
    sum += is_on(a[i][x+1][y+1])
    sum += is_on(a[i][x-1][y])
    sum += is_on(a[i][x+1][y])
    sum += is_on(a[i][x-1][y-1])
    sum += is_on(a[i][x][y-1])
    sum += is_on(a[i][x+1][y-1])
    if ( is_on(a[i][x][y]) ) {
        if ((sum != 2) && (sum != 3)) { a[i+1][x][y] = "." } 
        else { a[i+1][x][y] = "#" }
    }
    else {
        if ( sum == 3 ) { a[i+1][x][y] = "#" }
        else { a[i+1][x][y] = "."}
    }
}
END {
for (i=1; i<=100; i++) {
    for (x=1; x<=100; x++) {
        for (y=1; y<=100; y++) {
            flip(x,y,i)
            if (i == 100) print a[101][x][y]
        }
    }
}
}' input.txt