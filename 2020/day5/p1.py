with open("input", "r") as file:
    data = [line.strip() for line in file]

rows = [x for x in range(128)]
seats = [x for x in range(8)]


def bin_search(arr, code):
    if len(arr) == 1:
        return arr[0]
    half = len(arr) // 2
    first, rest = code[0], code[1:]
    if first in ("F", "L"):
        return bin_search(arr[:half], rest)
    else:
        return bin_search(arr[half:], rest)


highest = max([
    (bin_search(rows, boarding_pass[:7]) * 8) + bin_search(seats, boarding_pass[7:])
    for boarding_pass in data
])
print(highest)