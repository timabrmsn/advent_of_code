#!/bin/bash

# --- Part Two ---
#
# Now, take the signal you got on wire a, override wire b to that 
# signal, and reset the other wires (including wire a). What new 
# signal is ultimately provided to wire a?

gawk '
{ instructions[$NF] = $0 }                                               # store all instructions in array based on target value ($NF)
/^[0-9]+ -> [a-z]+$/ { instructions[$NF] = "0 -> "$NF }                  # reset all the wires to 0
/^[0-9]+ -> b$/ { instructions["b"] = "46065 -> b" }                     # set "b" input to 46065 (previous "a" value)

function get(wire,     i, parts, val) {                                  # recursive function to get wire value
    if (wire ~ /[0-9]+/) return wire                                     # stop recursing if we have a number
    if (wire in vals) return vals[wire]                                  # memoize already found results
    i = instructions[wire]                                               # get instruction
    split(i, parts)                                                      # split instruction into parts array
    
    if (i ~ /NOT/) { val = and( compl(get(parts[2])), 0xFFFF ) }         # process NOT/complement (and with 0xFFFF to ensure 16-bit value)
    
    else if (i ~ /AND/) { val = and( get(parts[1]), get(parts[3]) ) }    # process AND
    
    else if (i ~ /OR/) { val = or( get(parts[1]), get(parts[3]) ) }      # process OR
    
    else if (i ~ /RSHIFT/) { val = rshift( get(parts[1]), parts[3] )}    # process rshift
    
    else if (i ~ /LSHIFT/) { val = lshift( get(parts[1]), parts[3] ) }   # process lshift
    
    else { val = get(parts[1]) }                                         # process direct signals
    vals[wire] = val                                                     # cache result for memoization
    return val
}
END { print get("a") }                                                   # find the "a" signal
' input.txt