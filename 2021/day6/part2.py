# --- Part Two ---
# Suppose the lanternfish live forever and have unlimited 
# food and space. Would they take over the entire ocean?
#
# After 256 days in the example above, there would be a 
# total of 26984457539 lanternfish!
#
# How many lanternfish would there be after 256 days?

from collections import Counter

init = [int(f) for f in open("input.txt").readline().split(",")]
fishcount = Counter(init)


def update(counter):
    d = dict(counter)
    for i in range(8):
        counter[i] = d.get(i+1, 0)
    counter[6] += d.get(0, 0)
    counter[8] = d.get(0, 0)

for i in range(256):
    update(fishcount)

print(sum(fishcount.values()))