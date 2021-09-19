from itertools import groupby

with open("input") as file:
    data = sorted([int(line) for line in file.readlines()])

diffs = []
last = 0
for i in data:
    diffs.append(i - last)
    last = i

group_len_permutations = {0: 1, 1: 1, 2: 2, 3: 4, 4: 7, 5: 13}

total = 1
for key, group in groupby(diffs):
    if key == 1:
        total *= group_len_permutations[len(list(group))]

print(total)