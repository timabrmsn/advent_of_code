awk 'BEGIN{RS=""} {
  gsub("\n","")
  split($0,a,"")
  for (i in a) {x[a[i]]}
  print length(x)
  delete x
}' input | paste -sd+ | bc