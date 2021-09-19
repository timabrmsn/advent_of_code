from collections import Counter

with open("input", "r") as file:
    data = file.read().split("\n\n")

counters = [Counter(d) for d in data]
print(sum(
    [
        len([i for i in c if c[i] == (c["\n"]+1)])
        for c in counters
    ]
))