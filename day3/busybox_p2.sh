echo -e "1\n1\n3\n1\n5\n1\n7\n1\n1\n2" |\
xargs -n2 sh -c 'awk -F "" -v rows=$2 -v columns=$1 "(NR+1) % rows == 0 {print \$((c % 31)+1); c+=columns}" < input | grep -c "#"' sh |\
awk -v total=1 '{total=(total*$0)} END {print total}'