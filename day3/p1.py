from itertools import cycle


def advance_cycle(c, num):
    for _ in range(num - 1):
        next(c)
    return next(c)


x = [cycle(line.strip()) for line in open("input", "r")]

row = 0
column = 1
trees = 0
while True:
    try:
        row += 1
        column += 3
        if advance_cycle(x[row], column) == "#":
            trees += 1
    except:
        print(trees)
        break
