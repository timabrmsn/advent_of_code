import re

print(len(
    [
        i for i in
        [re.match(r"(\d+)-(\d+) ([a-z]): ([a-z]+)", line).groups() for line in open("input", "r")]
        if ((i[3][int(i[0])-1] == i[2]) ^ (i[3][int(i[1])-1] == i[2]))
    ]
))