sed 's/^$/@/' input | tr '\n' ' ' | awk 'BEGIN{RS="@"}
  !/byr:(19[2-9][0-9]|200[012])/ {next}
  !/iyr:20(1[0-9]|20)/ {next}
  !/eyr:20(2[0-9]|30)/ {next}
  !/hgt:(1([5678][0-9]|9[0-3])cm|(59|6[0-9]|7[0-6])in)/ {next}
  !/hcl:#[0-9a-f]{6}/ {next}
  !/ecl:(amb|blu|brn|gry|grn|hzl|oth)/ {next}
  !/pid:[0-9]{9}[ $]/ {next}
  {print "valid"}' | wc -l