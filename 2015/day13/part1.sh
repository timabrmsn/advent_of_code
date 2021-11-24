#!/bin/bash

# --- Day 13: Knights of the Dinner Table ---
#
# In years past, the holiday feast with your family hasn't gone
# so well. Not everyone gets along! This year, you resolve, will
# be different. You're going to find the optimal seating
# arrangement and avoid all those awkward conversations.
#
# You start by writing up a list of everyone invited and the amount
# their happiness would increase or decrease if they were to find
# themselves sitting next to each other person. You have a circular
# table that will be just big enough to fit everyone comfortably,
# and so each person will have exactly two neighbors.
#
# For example, suppose you have only four attendees planned, and
# you calculate their potential happiness as follows:
#
# Alice would gain 54 happiness units by sitting next to Bob.
# Alice would lose 79 happiness units by sitting next to Carol.
# Alice would lose 2 happiness units by sitting next to David.
# Bob would gain 83 happiness units by sitting next to Alice.
# Bob would lose 7 happiness units by sitting next to Carol.
# Bob would lose 63 happiness units by sitting next to David.
# Carol would lose 62 happiness units by sitting next to Alice.
# Carol would gain 60 happiness units by sitting next to Bob.
# Carol would gain 55 happiness units by sitting next to David.
# David would gain 46 happiness units by sitting next to Alice.
# David would lose 7 happiness units by sitting next to Bob.
# David would gain 41 happiness units by sitting next to Carol.
# Then, if you seat Alice next to David, Alice would lose 2 
# happiness units (because David talks so much), but David would 
# gain 46 happiness units (because Alice is such a good listener), 
# for a total change of 44.
#
# If you continue around the table, you could then seat Bob next
# to Alice (Bob gains 83, Alice gains 54). Finally, seat Carol,
# who sits next to Bob (Carol gains 60, Bob loses 7) and David
# (Carol gains 55, David gains 41). The arrangement looks like
# this:
#
#      +41 +46
# +55   David    -2
# Carol       Alice
# +60    Bob    +54
#      -7  +83
# After trying every other seating arrangement in this hypothetical 
# scenario, you find that this one is the most optimal, with a total 
# change in happiness of 330.
#
# What is the total change in happiness for the optimal seating arrangement of the actual guest list?

tr -d . <  input.txt | #
gawk '/lose/ {
  happiness[$1][$11] = -$4
}
/gain/ {
  happiness[$1][$11] = $4
}
{ if (last != $1) { names[++i] = $1 }; last=$1 }
END {
  for (a = 1; a < 9; a++) {
    for (b = 1; b < 9; b++) {
      if (b == a) continue
      for (c = 1; c < 9; c++) {
        if ((c == a) || (c == b)) continue
        for (d = 1; d < 9; d++) {
          if ((d == a) || (d == b) || (d == c)) continue
          for (e = 1; e < 9; e++) {
            if ((e == a) || (e == b) || (e == c) || (e == d)) continue
            for (f = 1; f < 9; f++) {
              if ((f == a) || (f == b) || (f == c) || (f == d) || (f == e)) continue
              for (g = 1; g < 9; g++) {
                if ((g == a) || (g == b) || (g == c) || (g == d) || (g == e) || (g == f)) continue
                for (h = 1; h < 9; h++) {
                  if ((h == a) || (h == b) || (h == c) || (h == d) || (h == e) || (h == f) || (h == g)) continue
                  sum = 0
                  seat_a = names[a]
                  seat_b = names[b]
                  seat_c = names[c]
                  seat_d = names[d]
                  seat_e = names[e]
                  seat_f = names[f]
                  seat_g = names[g]
                  seat_h = names[h]
                  sum += (happiness[seat_a][seat_b] + happiness[seat_b][seat_a])
                  sum += (happiness[seat_b][seat_c] + happiness[seat_c][seat_b])
                  sum += (happiness[seat_c][seat_d] + happiness[seat_d][seat_c])
                  sum += (happiness[seat_d][seat_e] + happiness[seat_e][seat_d])
                  sum += (happiness[seat_e][seat_f] + happiness[seat_f][seat_e])
                  sum += (happiness[seat_f][seat_g] + happiness[seat_g][seat_f])
                  sum += (happiness[seat_g][seat_h] + happiness[seat_h][seat_g])
                  sum += (happiness[seat_h][seat_a] + happiness[seat_a][seat_h])
                  if (sum > max) {
                      max = sum
                  }
                }
              }
            }
          }
        }
      }
    }
  }
print max
}'