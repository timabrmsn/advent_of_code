#!/bin/bash

# --- Part Two ---
# In all the commotion, you realize that you forgot to seat yourself. At this point, 
# you're pretty apathetic toward the whole thing, and your happiness wouldn't really 
# go up or down regardless of who you sit next to. You assume everyone else would be
# just as ambivalent about sitting next to you, too.

# So, add yourself to the list, and give all happiness relationships that involve you a score of 0.

# What is the total change in happiness for the optimal seating arrangement that actually includes yourself?

tr -d . <  input.txt | #
gawk '/lose/ {
  happiness[$1][$11] = -$4
}
/gain/ {
  happiness[$1][$11] = $4
}
{ if (last != $1) { names[++x] = $1 }; last=$1 }
END {
  names[++x] = "me"
  x++
  for (a = 1; a < x; a++) {
    for (b = 1; b < x; b++) {
      if (b == a) continue
      for (c = 1; c < x; c++) {
        if ((c == a) || (c == b)) continue
        for (d = 1; d < x; d++) {
          if ((d == a) || (d == b) || (d == c)) continue
          for (e = 1; e < x; e++) {
            if ((e == a) || (e == b) || (e == c) || (e == d)) continue
            for (f = 1; f < x; f++) {
              if ((f == a) || (f == b) || (f == c) || (f == d) || (f == e)) continue
              for (g = 1; g < x; g++) {
                if ((g == a) || (g == b) || (g == c) || (g == d) || (g == e) || (g == f)) continue
                for (h = 1; h < x; h++) {
                  if ((h == a) || (h == b) || (h == c) || (h == d) || (h == e) || (h == f) || (h == g)) continue
                  for (i = 1; i < x; i++) {
                    if ((i == a) || (i == b) || (i == c) || (i == d) || (i == e) || (i == f) || (i == g) || (i == h)) continue
                    sum = 0
                    seat_a = names[a]
                    seat_b = names[b]
                    seat_c = names[c]
                    seat_d = names[d]
                    seat_e = names[e]
                    seat_f = names[f]
                    seat_g = names[g]
                    seat_h = names[h]
                    seat_i = names[i]
                    sum += (happiness[seat_a][seat_b] + happiness[seat_b][seat_a])
                    sum += (happiness[seat_b][seat_c] + happiness[seat_c][seat_b])
                    sum += (happiness[seat_c][seat_d] + happiness[seat_d][seat_c])
                    sum += (happiness[seat_d][seat_e] + happiness[seat_e][seat_d])
                    sum += (happiness[seat_e][seat_f] + happiness[seat_f][seat_e])
                    sum += (happiness[seat_f][seat_g] + happiness[seat_g][seat_f])
                    sum += (happiness[seat_g][seat_h] + happiness[seat_h][seat_g])
                    sum += (happiness[seat_h][seat_i] + happiness[seat_i][seat_h])
                    sum += (happiness[seat_i][seat_a] + happiness[seat_a][seat_i])
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
  }
print max
}'