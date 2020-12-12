from collections import Counter

with open("input") as file:
    data = [row.strip() for row in file.readlines()]


def neighbor_points(i, j):
    up = i-1
    left = j-1
    right = j+1
    down = i+1
    return [
        (up, left),
        (up, j),
        (up, right),
        (i, right),
        (i, left),
        (down, left),
        (down, j),
        (down, right),
    ]


map_dict = {}
for i, x in enumerate(data):
    for j, y in enumerate(x):
        map_dict[(i, j)] = y


while True:
    updated_map_dict = {}
    for point in map_dict:
        adjacent_occupied_count = 0
        for neighbor in neighbor_points(*point):
            try:
                if map_dict[neighbor] == "#":
                    adjacent_occupied_count += 1
            except KeyError:
                pass
        seat = map_dict[point]
        if seat == ".":
            updated_map_dict[point] = "."
        elif seat == "L":
            updated_map_dict[point] = "#" if adjacent_occupied_count == 0 else "L"
        elif seat == "#":
            updated_map_dict[point] = "L" if adjacent_occupied_count >= 4 else "#"

    if updated_map_dict == map_dict:
        counter = Counter(updated_map_dict.values())
        print(counter["#"])
        exit()
    else:
        map_dict = updated_map_dict
