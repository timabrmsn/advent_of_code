with open("input.txt") as file:
    lines = [l.strip() for l in file.readlines()]

def get_most_common(lines):
    return [int(sum(map(int, l)) >= (len(lines)/2)) for l in zip(*lines)]

def find_most_common(lines, n):
    a = 0
    l = len(lines)
    # could stop count early if by value is determined by halfway point
    for line in lines:
        a += int(line[n])
    return 1 if a >= l/2 else 0

def _filter(idx, _list, most=True):
    if len(_list) == 1:
        return _list[0]
    criteria = get_most_common(_list)[idx]
    #criteria = find_most_common(_list, idx)
    if not most:
        criteria = not criteria
    new_list = [x for x in _list if int(x[idx]) == criteria]
    return _filter(idx+1, new_list, most=most)

o2 = _filter(0, lines, most=True)
co2= _filter(0, lines, most=False)

print(int(o2, 2)*int(co2, 2))
