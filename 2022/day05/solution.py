from pathlib import Path
from collections import defaultdict, deque
from re import findall
from copy import deepcopy

file = Path(__file__).parent / "input.txt"

lines = [l.strip("\n") for l in file.open()]
stacks_pt1 = defaultdict(deque)
for s in list(zip(*lines[:9])):
    if s[-1].isdigit():
        for x in s[:-1]:
            if x.isalnum():
                stacks_pt1[s[-1]].appendleft(x)
stacks_pt2 = deepcopy(stacks_pt1)


def move(n, from_, to):
    for _ in range(int(n)):
        stacks_pt1[to].append(stacks_pt1[from_].pop())


def move_multiple(n, from_, to):
    ministack = deque()
    for _ in range(int(n)):
        ministack.appendleft(stacks_pt2[from_].pop())
    stacks_pt2[to].extend(ministack)


for line in lines[10:]:
    instructions = findall("\d+", line)
    move(*instructions)
    move_multiple(*instructions)

print(f"part 1 solution: {''.join(s[-1] for s in stacks_pt1.values())}")
print(f"part 1 solution: {''.join(s[-1] for s in stacks_pt2.values())}")
