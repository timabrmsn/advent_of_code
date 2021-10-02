#!/bin/bash
#################################################################

# --- Part Two ---
#
# Now, take the signal you got on wire a, override wire b to that 
# signal, and reset the other wires (including wire a). What new 
# signal is ultimately provided to wire a?

gawk '
function get(wire,     i, parts, val) {
    if (wire ~ /[0-9]+/) return wire
    if (wire in vals) return vals[wire]
    i = instructions[wire]
    split(i, parts)
    
    if (i ~ /NOT/) { val = and( compl(get(parts[2])), 0xFFFF ) }
    
    else if (i ~ /AND/) { val = and( get(parts[1]), get(parts[3]) ) }
    
    else if (i ~ /OR/) { val = or( get(parts[1]), get(parts[3]) ) }
    
    else if (i ~ /RSHIFT/) { val = rshift( get(parts[1]), parts[3] )}
    
    else if (i ~ /LSHIFT/) { val = lshift( get(parts[1]), parts[3] ) }
    
    else { val = get(parts[1]) }
    vals[wire] = val
    return val
}
{ instructions[$NF] = $0 }
/^[0-9]+ -> [a-z]+$/ { instructions[$NF] = "0 -> "$NF }
/^[0-9]+ -> b$/ { instructions["b"] = "46065 -> b" }
END { print get("a") }
' input.txt