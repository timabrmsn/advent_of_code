#!/bin/bash

# --- Day 11: Corporate Policy ---
#
# Santa's previous password expired, and he needs help choosing a 
# new one.
#
# To help him remember his new password after the old one expires,
# Santa has devised a method of coming up with a password based on
# the previous one. Corporate policy dictates that passwords must be
# exactly eight lowercase letters (for security reasons), so he finds
# his new password by incrementing his old password string repeatedly
# until it is valid.
#
# Incrementing is just like counting with numbers: xx, xy, xz, ya, yb,
# and so on. Increase the rightmost letter one step; if it was z, it
# wraps around to a, and repeat with the next letter to the left until
# one doesn't wrap around.
#
# Unfortunately for Santa, a new Security-Elf recently started, and he
# has imposed some additional password requirements:
#
# - Passwords must include one increasing straight of at least three letters, like abc, bcd, cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
# - Passwords may not contain the letters i, o, or l, as these letters can be mistaken for other characters and are therefore confusing.
# - Passwords must contain at least two different, non-overlapping pairs of letters, like aa, bb, or zz.
#
# For example:
#
# hijklmmn meets the first requirement (because it contains the straight hij) but fails the second requirement requirement (because it contains i and l).
# abbceffg meets the third requirement (because it repeats bb and ff) but fails the first requirement.
# abbcegjk fails the third requirement, because it only has one double letter (bb).
# The next password after abcdefgh is abcdffaa.
# The next password after ghijklmn is ghjaabcc, because you eventually skip all the passwords that start with ghi..., since i is not allowed.
#
# Given Santa's current password (your puzzle input), what should his next password be?

gawk '
BEGIN {
    split("abcdefghijklmnopqrstuvwxyz", ord, "")  # make an array of the alphabet to be able to convert numbers > letters
    for (i in ord) { char[ord[i]] = i }           # reverse the array to be able to convert letters > numbers
}
{ 
    split($0, input, "")                          # convert input to array of characters
    for (i in input) {
        password[i] = char[input[i]]              # create the "password" array that has the number values of input
    }
}

function increment(i,       val, x)               # define recursive function that increments the password
{
    val = (password[i] % 26) + 1                  # "% 26" lets the number roll over once it hits "z"
    if (ord[val] ~ /i|o|l/) {                     # if we get an "i", "o", or "l"
        password[i] = val+1                       # increment +1 to skip it
    }
    else {                                        
        password[i] = val                         # replace current value with incremented
        if ((val == 1) && (i != 1)) {             # if we have rolled over and arent in index 1
            increment(i-1)                        # increment the adjacent value as well
        }
    }
}

END {
    while (1) {                                   # keep going forever
        increment(8)                              # do the incrementing
        for (i in password) {
            printf ord[password[i]]               # print the characters
        }
        print ""
    }
}' input.txt |\
grep -E 'abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz' | # filter for increasing straights
grep -E '(.)\1.*(.)\2' |                                                                                    # filter for double pairs
head -1                                                                                                     # take first result