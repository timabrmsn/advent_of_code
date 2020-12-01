from fileinput import FileInput
from itertools import combinations
from operator import mul
from functools import reduce

print([reduce(mul, comb) for comb in combinations([int(l.strip()) for l in FileInput("input")], 3) if sum(comb) == 2020][0])