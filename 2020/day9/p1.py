from collections import deque
from itertools import combinations

with open("input") as file:
    data = [int(line.strip()) for line in file.readlines()]

preamble, message = data[:25], data[25:]
d = deque(preamble, 25)

for i in message:
    if any(sum(comb) == i for comb in combinations(d, 2)):
        d.append(i)
    else:
        print(i)
        exit()