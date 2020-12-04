from itertools import cycle, islice

column, trees = (1, 0)

for row in [cycle(line.strip()) for line in open("input", "r")]:
    if list(islice(row, column))[-1] == "#":
        trees += 1
    column += 3
    
print(trees)