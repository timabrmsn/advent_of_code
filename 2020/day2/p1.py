import re

print(len(
    [
        i for i in
        [re.match(r"(\d+)-(\d+) ([a-z]): ([a-z]+)", line).groups() for line in open("input", "r")]
        if int(i[0]) <= i[3].count(i[2]) <= int(i[1])
    ]
))