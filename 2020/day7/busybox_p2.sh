sed 's/ bags\?//g; s/\.//g; s/\([0-9]\) /\1@/g; s/ //g' input | awk -F 'contain' '
function find(bag_name,   total, inner, bag_count) {
  total = bag_totals[bag_name]
  if (total == 0) {
      return 0
  }
  else {
      split(bags[bag_name], inner, ",")
      for (i in inner) {
          split(inner[i], bag_count, "@")
          total += (bag_count[1] * find(bag_count[2]))
      }
  }
  return total
}
{
  numbers=gensub(/[@a-z ,\.]+/, " ", "g")
  split(numbers, num_arr, " ")
  sum=0
  for (i in num_arr) {
    sum += num_arr[i]
  }
  bag_totals[$1] = sum
  bags[$1] = $2
}
END {
  print find("shinygold")
}'
