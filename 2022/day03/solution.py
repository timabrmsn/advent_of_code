from pathlib import Path
from string import ascii_letters

file = Path(__file__).parent / "input.txt"
lines = [l.strip() for l in file.open()]


total = 0
for line in lines:
    half = int(len(line) / 2)
    shared = (set(line[half:]) & set(line[:half])).pop()
    total += ascii_letters.index(shared) + 1

print(f"part 1 solution: {total}")



total = 0
last = None
for i, line in enumerate(lines, 1):
    this = set(line)
    if last is None:
        last = this
        continue
    else:
        last = last & this
    if i % 3 == 0:
        shared = last.pop()
        total += ascii_letters.index(shared) + 1
        last = None

print(f"part 2 solution: {total}")





