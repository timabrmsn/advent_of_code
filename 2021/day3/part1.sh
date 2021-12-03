#!/bin/bash

gawk '{
  split($0, a, "")
  for (i in a) sum[i] += a[i]
}
END {
  for (i in sum) {
      e[i] = (sum[i] > (NR/2))
      g[i] = (sum[i] < (NR/2))
  }
  for (i in e) estr = estr "" e[i]
  for (i in g) gstr = gstr "" g[i]
  
  print "ibase=2;obase=A;"estr |& "bc"
  "bc" |& getline edec
  
  print "ibase=2;obase=A;"gstr |& "bc"
  "bc" |& getline gdec
  
  print edec * gdec
}' input.txt