awk '
BEGIN {key=1309761972}

function check(arr) {
   if (sum(arr) == key) {
       for (i in arr) {
           val=arr[i]
           if (r["min"] == 0)  { r["min"]=val; r["max"]=val }
           if (val < r["min"]) { r["min"]=val }
           if (val > r["max"]) { r["max"]=val }
   }
   print r["min"] + r["max"]
   exit
  }
}

function sum(arr,    s) {
   s=0
   for (i in arr) {
     s+=arr[i]
   }
   return s
}

{
  rolling[NR]=$0
  check(rolling)
  if (sum(rolling) > key) {
      len = length(rolling)
      while (sum(rolling) > key) {
          delete rolling[NR-len]
          len-=1
          check(rolling)
      }
  }
}' input