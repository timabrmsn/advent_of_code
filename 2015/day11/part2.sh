#!/bin/bash

# --- Part Two ---
#
# Santa's password expired again. What's the next one?

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
head -2 |                                                                                                   # of the first two results
tail -1                                                                                                     # take the second one