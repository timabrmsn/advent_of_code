#!/bin/bash

# --- Day 21: RPG Simulator 20XX ---
#
# Little Henry Case got a new video game for Christmas. It's an RPG, and he's stuck on a boss. He needs to know what
# equipment to buy at the shop. He hands you the controller.
#
# In this game, the player (you) and the enemy (the boss) take turns attacking. The player always goes first. Each
# attack reduces the opponent's hit points by at least 1. The first character at or below 0 hit points loses.
#
# Damage dealt by an attacker each turn is equal to the attacker's damage score minus the defender's armor score. An
# attacker always does at least 1 damage. So, if the attacker has a damage score of 8, and the defender has an armor
# score of 3, the defender loses 5 hit points. If the defender had an armor score of 300, the defender would still lose
# 1 hit point.
#
# Your damage score and armor score both start at zero. They can be increased by buying items in exchange for gold.
# You start with no items and have as much gold as you need. Your total damage or armor is equal to the sum of those
# stats from all of your items. You have 100 hit points.
#
# Here is what the item shop is selling:
#
# Weapons:    Cost  Damage  Armor
# Dagger        8     4       0
# Shortsword   10     5       0
# Warhammer    25     6       0
# Longsword    40     7       0
# Greataxe     74     8       0
#
# Armor:      Cost  Damage  Armor
# Leather      13     0       1
# Chainmail    31     0       2
# Splintmail   53     0       3
# Bandedmail   75     0       4
# Platemail   102     0       5
#
# Rings:      Cost  Damage  Armor
# Damage +1    25     1       0
# Damage +2    50     2       0
# Damage +3   100     3       0
# Defense +1   20     0       1
# Defense +2   40     0       2
# Defense +3   80     0       3
#
# You must buy exactly one weapon; no dual-wielding. Armor is optional, but you can't use more than one. You can
# buy 0-2 rings (at most one for each hand). You must use any items you buy. The shop only has one of each item,
# so you can't buy, for example, two rings of Damage +3.
#
# For example, suppose you have 8 hit points, 5 damage, and 5 armor, and that the boss has 12 hit points, 7 damage,
# and 2 armor:
#
#     The player deals 5-2 = 3 damage; the boss goes down to 9 hit points.
#     The boss deals 7-5 = 2 damage; the player goes down to 6 hit points.
#     The player deals 5-2 = 3 damage; the boss goes down to 6 hit points.
#     The boss deals 7-5 = 2 damage; the player goes down to 4 hit points.
#     The player deals 5-2 = 3 damage; the boss goes down to 3 hit points.
#     The boss deals 7-5 = 2 damage; the player goes down to 2 hit points.
#     The player deals 5-2 = 3 damage; the boss goes down to 0 hit points.
#
# In this scenario, the player wins! (Barely.)
#
# You have 100 hit points. The boss's actual stats are in your puzzle input. What is the least amount of gold you can
# spend and still win the fight?

awk 'BEGIN {
  wpns["Dagger"]["cost"] = 8;      wpns["Dagger"]["dmg"] = 4
  wpns["Shortsword"]["cost"] = 10; wpns["Shortsword"]["dmg"] = 5
  wpns["Warhammer"]["cost"] = 25;  wpns["Warhammer"]["dmg"] = 6
  wpns["Longsword"]["cost"] = 40;  wpns["Longsword"]["dmg"] = 7
  wpns["Greataxe"]["cost"] = 74;   wpns["Greataxe"]["dmg"] = 8

  armr["None"]["cost"] = 0;        armr["None"]["armor"] = 0
  armr["Leather"]["cost"] = 13;    armr["Leather"]["armor"] = 1
  armr["Chainmail"]["cost"] = 31;  armr["Chainmail"]["armor"] = 2
  armr["Splintmail"]["cost"] = 53; armr["Splintmail"]["armor"] = 3
  armr["Bandedmail"]["cost"] = 75; armr["Bandedmail"]["armor"] = 4
  armr["Platemail"]["cost"] = 102; armr["Platemail"]["armor"] = 5

  rngs["None"]["cost"] = 0;        rngs["None"]["dmg"] = 0;       rngs["None"]["armor"] = 0
  rngs["Damage +1"]["cost"] = 25;  rngs["Damage +1"]["dmg"] = 1;  rngs["Damage +1"]["armor"] = 0
  rngs["Damage +2"]["cost"] = 50;  rngs["Damage +2"]["dmg"] = 2;  rngs["Damage +2"]["armor"] = 0
  rngs["Damage +3"]["cost"] = 100; rngs["Damage +3"]["dmg"] = 3;  rngs["Damage +3"]["armor"] = 0
  rngs["Defense +1"]["cost"] = 20; rngs["Defense +1"]["dmg"] = 0; rngs["Defense +1"]["armor"] = 1
  rngs["Defense +2"]["cost"] = 40; rngs["Defense +2"]["dmg"] = 0; rngs["Defense +2"]["armor"] = 2
  rngs["Defense +3"]["cost"] = 80; rngs["Defense +3"]["dmg"] = 0; rngs["Defense +3"]["armor"] = 3
}

/Hit Points:/ {boss_hp = $3 }
/Damage:/ { boss_damage = $2 }
/Armor:/ { boss_armor = $2 }

END {
  for (w in wpns) {
    for (a in armr) {
      for (r1 in rngs) {
        for (r2 in rngs) {
          if ((r1 != "None") && (r1 == r2)) { continue }
          cost = wpns[w]["cost"] + armr[a]["cost"] + rngs[r1]["cost"] + rngs[r2]["cost"]
          damage = wpns[w]["dmg"] + rngs[r1]["dmg"] + rngs[r2]["dmg"]
          armor = armr[a]["armor"] + rngs[r1]["armor"] + rngs[r2]["armor"]
          my_damage = damage - boss_armor
          if (my_damage < 1) { my_damage = 1 }
          round_boss_damage = boss_damage - armor
          if (round_boss_damage < 1) { round_boss_damage = 1 }
          boss_rounds_to_dead = (boss_hp / my_damage)
          my_rounds_to_dead = (100 / round_boss_damage)
          if (boss_rounds_to_dead < my_rounds_to_dead) { print cost }
        }
      }
    }
  }
}' input.txt | sort -n | head -1