tr ':-' ' ' < input | awk '{ c=gsub($3,"",$4); valid += ($1<=c && c<=$2) } END { print valid }'