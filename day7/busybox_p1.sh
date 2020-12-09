sed 's/ bags\?//g; s/\.//g; s/[0-9] //g; s/ //g' input | awk -F 'contain' '
function find(bag,   p, a, i) {
  p = parents[bag]
  if (p) {
      split(p, a, ",")
      for (i in a) {
          x = find(a[i])
          if (x) {
            p = x "," p
          }
      }
      return p
  }
  else { return "" }
}
{
  split($2, children, ",")
  for (i in children) {
    parents[children[i]] = parents[children[i]]","$1
  }
}
END { print find("shinygold") }' | sed 's/^,//' | tr -s , '\n' | sort -u | wc -l