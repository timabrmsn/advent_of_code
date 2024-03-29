#!/bin/bash

# --- Part Two ---
# 
# As you're about to send the thank you note, something in the MFCSAM's
# instructions catches your eye. Apparently, it has an outdated
# retroencabulator, and so the output from the machine isn't exact
# values - some of them indicate ranges.
# 
# In particular, the cats and trees readings indicates that there are
# greater than that many (due to the unpredictable nuclear decay of cat
# dander and tree pollen), while the pomeranians and goldfish readings
# indicate that there are fewer than that many (due to the modial
# interaction of magnetoreluctance).
# 
# What is the number of the real Aunt Sue?

grep -vE 'children: [^3]|cats: [1-7]|samoyeds: [^2]|pomeranians: ([4-9]|1[0-9])|akitas: [^0]|vizslas: [^0]|goldfish: ([5-9]|1[0-9])|trees: [0-3]|cars: [^2]|perfumes: [^1]' input.txt 