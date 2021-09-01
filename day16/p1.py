import re
from fileinput import input
from itertools import chain

rule_pattern = r"(?P<name>[^:]+): (?P<start1>\d+)-(?P<end1>\d+) or (?P<start2>\d+)-(?P<end2>\d+)"

rules = {}
start_nearby = False
invalids = []
for line in input("input"):
    if m := re.match(rule_pattern, line):
        start1 = int(m.group("start1"))
        end1 = int(m.group("end1")) + 1
        start2 = int(m.group("start2"))
        end2 = int(m.group("end2")) + 1
        rules[m.group("name")] = set(chain(range(start1, end1), range(start2, end2)))
    if re.match("nearby tickets:", line):
        start_nearby = True
        valid_values = set()
        for rule in rules:
            valid_values |= rules[rule]
        continue
    if start_nearby:
        numbers = set(int(num) for num in line.split(","))
        invalid = numbers - valid_values
        invalids.extend(list(invalid))

print(sum(invalids))