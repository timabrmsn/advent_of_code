import re

with open("input", "r") as file:
    data = [line.strip() for line in file.readlines()]

bags = {}
for line in data:
    bag_name = " ".join(line.split()[:2])
    inner_bags = re.findall(r"([0-9]+) ([\w]+ [\w]+) bag", line)
    inner_bags = [(int(b[0]), b[1]) for b in inner_bags]
    bags[bag_name] = inner_bags


def find(bag):
    inner_bags = bags[bag]
    if not inner_bags:
        return 0
    else:
        total = sum([b[0] for b in inner_bags])
        for bag in inner_bags:
            if result := find(bag[1]):
                total += bag[0] * result
        return total


print(find("shiny gold"))