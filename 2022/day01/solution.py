from pathlib import Path
from collections import Counter

elfs = Counter()
num = 1

file = Path(__file__).parent / "input.txt"

for line in file.open():
    if line.strip():
        elfs[num] += int(line)
    else:
        num += 1

print("part 1 solution:")
print(elfs.most_common(1)[0])

print("part 2 solution:")
print(sum(e[1] for e in elfs.most_common(3)))