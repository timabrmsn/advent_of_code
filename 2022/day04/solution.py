import re
from pathlib import Path

file = Path(__file__).parent / "input.txt"

p1_total = p2_total = 0
for line in file.open():
    a, b, c, d = map(int, re.findall("\d+", line))
    x, y = set(range(a, b + 1)), set(range(c, d + 1))
    intersection = x & y
    p1_total += intersection == x or intersection == y
    p2_total += bool(intersection)

print(f"part 1 solution: {p1_total}")
print(f"part 2 solution: {p2_total}")
