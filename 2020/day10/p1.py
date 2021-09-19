from collections import Counter

with open("input") as file:
    data = sorted([int(line) for line in file.readlines()])

c = Counter()
last = 0

for i in data:
    c[i-last] += 1
    last = i

c[3] += 1  # device's adapter

print(c[1]*c[3])