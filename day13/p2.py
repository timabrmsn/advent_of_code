from itertools import count

with open("input") as file:
    start_time = int(file.readline())
    buses = file.readline().strip().split(",")

offsets = {int(b): i for i, b in enumerate(buses) if b != "x"}


def find_common(start, step, buses):
    if not step:
        step = next(buses)
    try:
        nxt = next(buses)
    except StopIteration:
        return start

    found = None
    for i in count(start, step):
        if (i + offsets[nxt]) % nxt == 0:
            if not found:
                found = i
            else:
                return find_common(found, i-found, buses)


print(find_common(0, None, iter(offsets)))