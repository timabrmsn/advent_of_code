import re
from collections import defaultdict

with open("input", "r") as file:
    data = [line.strip() for line in file.readlines()]

bags = defaultdict(list)

for line in data:
    bag_names = re.findall(r"([\w]+ [\w]+) bag", line)
    parent, children = bag_names[0], bag_names[1:]
    for child in children:
        bags[child].append(parent)


def find(bag):
    parents = bags[bag]
    total = []
    for parent in parents:
        total.extend(find(parent))
    parents.extend(total)
    return parents


print(len(set(find("shiny gold"))))
