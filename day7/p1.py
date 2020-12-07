import re
from collections import defaultdict

with open("input", "r") as file:
    data = [line.strip() for line in file.readlines()]

bags = [re.findall(r"(?P<name>[a-z]+ [a-z]+) bag", d) for d in data]

bagerarchy = defaultdict(list)

for b in bags:
    parent, children = b[0], b[1:]
    for child in children:
        bagerarchy[child].append(parent)


def find_parent_totals(bag):
    parents = bagerarchy[bag]
    total = []
    for parent in parents:
        total.extend(find_parent_totals(parent))
    parents.extend(total)
    return parents


print(len(set(find_parent_totals("shiny gold"))))
