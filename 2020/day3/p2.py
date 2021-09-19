from itertools import cycle, islice
from operator import mul
from functools import reduce

slopes = [[1, 1, 0], [3, 1, 0], [5, 1, 0], [7, 1, 0], [1, 2, 0]]

for slope in slopes:
    hill = [cycle(line.strip()) for line in open("input", "r")]
    row, column = (0, 1)
    while True:
        try:
            if list(islice(hill[row], column))[-1] == "#":
                slope[2] += 1
            column += slope[0]
            row += slope[1]
        except:
            break

print(reduce(mul, [s[2] for s in slopes]))