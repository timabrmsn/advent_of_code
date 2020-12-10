awk '
function check(arr, key,     valid, i, j) {
    valid = 0
    for (i in arr) {
      for (j in arr) {
        if (arr[i]+arr[j] == key) { valid = 1 }
      }
    }
    if (valid == 0) { print key; exit }
}
NR <= 25 {rolling[NR] = $0}
NR > 25 {
    check(rolling, $0)
    delete rolling[NR-25]
    rolling[NR] = $0
}' input