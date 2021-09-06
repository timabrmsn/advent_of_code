import re
from collections import defaultdict
from fileinput import input
from functools import reduce
from itertools import chain
from operator import mul


rule_pattern = r"([^:]+): (\d+)-(\d+) or (\d+)-(\d+)"
rules = {}
tickets = []
start_nearby = False
my_ticket = False
for line in input("input"):
    if m := re.match(rule_pattern, line):
        name, a, b, c, d = m.groups()
        rules[name] = set(chain(range(int(a), int(b)+1), range(int(c), int(d)+1)))
    
    if re.match("your ticket:", line):
        my_ticket = True
        continue
    
    if my_ticket and re.match(r"[\d,]+", line):
        ticket = [int(num) for num in line.split(",")]
        my_ticket = False
        continue
    
    if re.match("nearby tickets:", line):
        start_nearby = True
        valid_values = set()
        for rule in rules:
            valid_values |= rules[rule]
        continue
    if start_nearby:
        numbers = [int(num) for num in line.split(",")]
        if not (set(numbers) - valid_values):
            tickets.append(numbers)
        

ticket_rows = list(zip(*tickets))
possible = defaultdict(list)
for i, row in enumerate(ticket_rows):
    for rule in rules:
        if not (set(row) - rules[rule]):
            possible[rule].append(i)


filtered = {}
while len(filtered) < len(rules):
    for rule in rules:
        if rule in possible and len(possible[rule]) == 1:
            row = possible.pop(rule)[0]
            filtered[rule] = row
            for r in possible:
                try:
                    possible[r].remove(row)
                except ValueError:
                    pass
        
departure_values = [ticket[v] for k,v in filtered.items() if k.startswith("departure")]
print(reduce(mul, departure_values))