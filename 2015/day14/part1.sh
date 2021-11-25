#!/bin/bash

# --- Day 14: Reindeer Olympics ---
# 
# This year is the Reindeer Olympics! Reindeer can fly at high speeds,
# but must rest occasionally to recover their energy. Santa would like
# to know which of his reindeer is fastest, and so he has them race.
# 
# Reindeer can only either be flying (always at their top speed) or
# resting (not moving at all), and always spend whole seconds in either
# state.
# 
# For example, suppose you have the following Reindeer:
# 
# Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
# Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
# After one second, Comet has gone 14 km, while Dancer has gone 16 km. After
# ten seconds, Comet has gone 140 km, while Dancer has gone 160 km. On the
# eleventh second, Comet begins resting (staying at 140 km), and Dancer continues
# on for a total distance of 176 km. On the 12th second, both reindeer are
# resting. They continue to rest until the 138th second, when Comet flies for
# another ten seconds. On the 174th second, Dancer flies for another 11 seconds.
# 
# In this example, after the 1000th second, both reindeer are resting, and Comet
# is in the lead at 1120 km (poor Dancer has only gotten 1056 km by that point).
# So, in this situation, Comet would win (if the race ended at 1000 seconds).
# 
# Given the descriptions of each reindeer (in your puzzle input), after exactly
# 2503 seconds, what distance has the winning reindeer traveled?

gawk '{
  deer[$1]["speed"] = $4                                # store deer speed
  deer[$1]["mod"] = $7+$14                              # store deer total move + wait window
  deer[$1]["move"] = $7                                 # store move window
}
END {
  for (i = 1; i <= 2503; i++) {                         # tick each second until stopping point
    for (d in deer) {                                   # calculate for each deer
      mod = (i % deer[d]["mod"])                        # take the modulo of current second + (move + wait) window
      if ((1 <= mod) && (mod <= deer[d]["move"])) {     # of modulo is within the "move" window 
        deer[d]["traveled"] += deer[d]["speed"]       # increment the "traveled" value by speed
      }
    }
  }
  for (d in deer) {                                     # for each deer
    print deer[d]["traveled"]                         # print total traveled distance
  }
}' input.txt |                                          #
sort -n | tail -1                                       # sort results and take highest