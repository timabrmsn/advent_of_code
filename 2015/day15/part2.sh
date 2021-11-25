#!/bin/bash

# --- Part Two ---
# 
# Your cookie recipe becomes wildly popular! Someone asks if you can make another
# recipe that has exactly 500 calories per cookie (so they can use it as a meal
# replacement). Keep the rest of your award-winning process the same (100 teaspoons,
# same ingredients, same scoring system).
# 
# For example, given the ingredients above, if you had instead selected 40 teaspoons
# of butterscotch and 60 teaspoons of cinnamon (which still adds to 100), the total
# calorie count would be 40*8 + 60*3 = 500. The total score would go down, though:
# only 57600000, the best you can do in such trying circumstances.
# 
# Given the ingredients in your kitchen and their properties, what is the total
# score of the highest-scoring cookie you can make with a calorie total of 500?

gawk '{
  I[NR]["cap"] = $3
  I[NR]["dur"] = $5
  I[NR]["flv"] = $7
  I[NR]["txt"] = $9
  I[NR]["cal"] = $11
}
END {
  for (a = 1; a < 100; a++) {
    for (b = 1; b < 100; b++) {
      for (c = 1; c < 100; c++) {
        for (d = 1; d < 100; d++) {
          if ((a+b+c+d) == 100) {
            cnt[1] = a; cnt[2] = b; cnt[3] = c; cnt[4] = d
            cap = dur = flv = txt = cal = 0
            for (i = 1; i <= 4; i++) {
              cap += (cnt[i] * I[i]["cap"])
              dur += (cnt[i] * I[i]["dur"])
              flv += (cnt[i] * I[i]["flv"])
              txt += (cnt[i] * I[i]["txt"])
              cal += (cnt[i] * I[i]["cal"])
            }
            if (cal != 500) continue
            if (cap < 0) cap = 0
            if (dur < 0) dur = 0
            if (flv < 0) flv = 0
            if (txt < 0) txt = 0
            total = (cap * dur * flv * txt)
            if (total > best) best = total
          }
        }
      }
    }
  }
  print best
}
' input.txt