#!/bin/bash

# --- Part Two ---

# Seeing how reindeer move in bursts, Santa decides he's not pleased
# with the old scoring system.
# 
# Instead, at the end of each second, he awards one point to the reindeer
# currently in the lead. (If there are multiple reindeer tied for the lead,
# they each get one point.) He keeps the traditional 2503 second time limit,
# of course, as doing otherwise would be entirely ridiculous.

# Given the example reindeer from above, after the first second, Dancer is
# in the lead and gets one point. He stays in the lead until several seconds
# into Comet's second burst: after the 140th second, Comet pulls into the
# lead and gets his first point. Of course, since Dancer had been in the lead
# for the 139 seconds before that, he has accumulated 139 points by the 140th
# second.

# After the 1000th second, Dancer has accumulated 689 points, while poor Comet,
# our old champion, only has 312. So, with the new scoring system, Dancer would
# win (if the race ended at 1000 seconds).

# Again given the descriptions of each reindeer (in your puzzle input), after
# exactly 2503 seconds, how many points does the winning reindeer have?

gawk '{
  D[$1]["speed"] = $4                              # store deer speed
  D[$1]["mod"] = $7+$14                            # store deer total move + wait window
  D[$1]["move"] = $7                               # store move window
}
END {
  for (i = 1; i <= 2503; i++) {                    # tick each second until stopping point
    max = 0                                        # reset max counter each second
    for (d in D) {                                 # calculate for each deer
      mod = (i % D[d]["mod"])                      # take the modulo of current second + (move + wait) window
      if ((1 <= mod) && (mod <= D[d]["move"])) {   # of modulo is within the "move" window 
        D[d]["traveled"] += D[d]["speed"]          # increment the "traveled" value by speed
      }
      if (D[d]["traveled"] > max) {                # keep track of max distance
        max = D[d]["traveled"]
      }
    }
    for (d in D) {                                 # check each deer
      if (D[d]["traveled"] == max) {               # for "winner" of the current second
        D[d]["points"] += 1                      # if so, give them a point
      }
    }
  }
  for (d in D) {                                   # for each deer
    print D[d]["points"]                         # print total traveled distance
  }
}' input.txt |                                     #
sort -n | tail -1                                  # sort results and take highest