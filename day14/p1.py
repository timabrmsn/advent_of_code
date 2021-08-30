from fileinput import input
import re


def masker(mask, number):
    numlist = list(format(int(number), "b").zfill(36))
    return "".join([x if x != "X" else numlist[i] for i, x in enumerate(mask)])


mem = {}
for line in input("input"):
    if match := re.match(r"mask = ([01X]+)", line):
        mask = match.groups()[0]
        continue
    if match := re.match(r"mem\[(\d+)\] = (\d+)", line):
        address, value = match.groups()

    mem[address] = masker(mask, value)

print(sum(int(v, 2) for v in mem.values()))
