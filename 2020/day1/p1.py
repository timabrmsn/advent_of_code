from fileinput import FileInput
from itertools import combinations
from operator import mul

print([mul(*comb) for comb in combinations([int(l.strip()) for l in FileInput("input")], 2) if sum(comb) == 2020][0])


