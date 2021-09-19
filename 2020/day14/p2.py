from fileinput import input
from itertools import combinations_with_replacement, permutations
import re


def masker(mask, address):
    masked = mask_non_x(address, mask)
    possible_replacements = get_all_combinations(masked)
    addresses = []
    for x in possible_replacements:
        addresses.append(replace_possibility(masked, x))
    return addresses


def mask_non_x(address, mask):
    masked = []
    address = format(int(address), "b").zfill(36)
    for a, m in zip(address, mask):
        if m == "0":
            val = a
        elif m == "1":
            val = m
        else:
            val = "X"
        masked.append(val)
    return "".join(masked)


def get_all_combinations(mask):
    possible = set()
    for comb in combinations_with_replacement(("0", "1"), mask.count("X")):
        for perm in permutations(comb):
            possible.add(perm)
    return possible


def replace_possibility(address, possible):
    for item in possible:
        address = re.sub("X", item, address, count=1)
    return address


mem = {}
for line in input("input"):
    if match := re.match(r"mask = ([01X]+)", line):
        mask = match.groups()[0]
        continue
    if match := re.match(r"mem\[(\d+)\] = (\d+)", line):
        address, value = match.groups()
        modified_addresses = masker(mask, address)
        for a in modified_addresses:
            mem[a] = value

print(sum(int(v) for v in mem.values()))
