# --- Part Two ---
#
# Turns out the shopkeeper is working with the boss, and can persuade you to buy whatever items he wants.
# The other rules still apply, and he still only has one of each item.
#
# What is the most amount of gold you can spend and still lose the fight?

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
          if (boss_rounds_to_dead > my_rounds_to_dead) { print cost }
        }
      }
    }
  }
}' input.txt | sort -n | tail -1