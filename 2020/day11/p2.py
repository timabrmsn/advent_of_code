from collections import Counter


with open("input") as file:
    data = [row.strip() for row in file.readlines()]


def visible_occupied_seat(start: tuple, direction: tuple, map: dict):
    x, y = direction
    while True:
        start = start[0] + x, start[1] + y
        try:
            value = map[start]
            if value == ".":
                continue
            if value == "#":
                return True
            else:
                return False
        except KeyError:
            return False


directions = {
    "nw": (-1, -1),
    "n": (-1, 0),
    "ne": (-1, 1),
    "w": (0, -1),
    "e": (0, 1),
    "sw": (1, -1),
    "se": (1, 1),
    "s": (1, 0),
}

map_dict = {}
for i, x in enumerate(data):
    for j, y in enumerate(x):
        map_dict[(i, j)] = y
        
while True:
    updated_map_dict = {}
    for point in map_dict:
        if map_dict[point] == ".":
            updated_map_dict[point] = "."
            continue
        occupied_seat_count = 0
        for d in directions:
            if visible_occupied_seat(point, directions[d], map_dict):
                occupied_seat_count += 1
        if map_dict[point] == "L":
            updated_map_dict[point] = "#" if occupied_seat_count == 0 else "L"
        if map_dict[point] == "#":
            updated_map_dict[point] = "L" if occupied_seat_count >= 5 else "#"
    
    if updated_map_dict == map_dict:
        counter = Counter(updated_map_dict.values())
        print(counter["#"])
        exit()
    else:
        map_dict = updated_map_dict