from itertools import cycle
from operator import mul
from functools import reduce

def advance_cycle(c, num):
    for _ in range(num - 1):
        next(c)
    return next(c)


slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
slope_results = []
for slope in slopes:
    x = [cycle(line.strip()) for line in open("input", "r")]
    row = 0
    column = 1
    trees = 0
    while True:
        try:
            row += slope[1]
            column += slope[0]
            if advance_cycle(x[row], column) == "#":
                trees += 1
        except:
            slope_results.append(trees)
            break

print(reduce(mul, slope_results))