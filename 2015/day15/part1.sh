#!/bin/bash

# --- Day 15: Science for Hungry People ---
# 
# Today, you set out on the task of perfecting your milk-dunking
# cookie recipe. All you have to do is find the right balance of
# ingredients.
# 
# Your recipe leaves room for exactly 100 teaspoons of ingredients.
# You make a list of the remaining ingredients you could use to
# finish the recipe (your puzzle input) and their properties per
# teaspoon:
# 
# capacity (how well it helps the cookie absorb milk)
# durability (how well it keeps the cookie intact when full of milk)
# flavor (how tasty it makes the cookie)
# texture (how it improves the feel of the cookie)
# calories (how many calories it adds to the cookie)
# You can only measure ingredients in whole-teaspoon amounts accurately,
# and you have to be accurate so you can reproduce your results in the
# future. The total score of a cookie can be found by adding up each
# of the properties (negative totals become 0) and then multiplying
# together everything except calories.
# 
# For instance, suppose you have these two ingredients:
# 
# Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
# Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
# Then, choosing to use 44 teaspoons of butterscotch and 56 teaspoons of
# cinnamon (because the amounts of each ingredient must add up to 100)
# would result in a cookie with the following properties:
# 
# A capacity of 44*-1 + 56*2 = 68
# A durability of 44*-2 + 56*3 = 80
# A flavor of 44*6 + 56*-2 = 152
# A texture of 44*3 + 56*-1 = 76
# Multiplying these together (68 * 80 * 152 * 76, ignoring calories for now)
# results in a total score of 62842880, which happens to be the best score
# possible given these ingredients. If any properties had produced a negative
# total, it would have instead become zero, causing the whole score to multiply
# to zero.
# 
# Given the ingredients in your kitchen and their properties, what is the total
# score of the highest-scoring cookie you can make?

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
            cap = dur = flv = txt = 0
            for (i = 1; i <= 4; i++) {
              cap += (cnt[i] * I[i]["cap"])
              dur += (cnt[i] * I[i]["dur"])
              flv += (cnt[i] * I[i]["flv"])
              txt += (cnt[i] * I[i]["txt"])
            }
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