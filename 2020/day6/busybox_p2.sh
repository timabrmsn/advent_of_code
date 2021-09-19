awk 'BEGIN{RS=""} {
  people = gsub("\n","") + 1
  split($0,a,"")
  for (i in a) {
    x[a[i]] += 1
  }
  for (i in x) {
    if (x[i] == people) {
      sum += 1
    }
  }
  print sum
  delete x
  sum = 0
}' input | paste -sd+ | bc