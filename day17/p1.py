from fileinput import input
from collections import defaultdict
from itertools import groupby

_map = defaultdict(lambda: False)

        
def get_neighbors(x, y, z):
    for _x in range(x-1, x+2):
        for _y in range(y-1, y+2):
            for _z in range(z-1, z+2):
                if (_x, _y, _z) != (x,y,z):
                    yield (_x, _y, _z)


def active_neighbor_count(x, y, z):
    return len(list(filter(None, [_map[coords] for coords in get_neighbors(x,y,z)])))


def draw_map(_map):
    z_plane = lambda x: x[2]
    x_row = lambda x: x[0]
    sorted_map = sorted(_map.keys(), key=z_plane)
    for plane, plane_group in groupby(sorted_map, key=z_plane):
        print(f"Z={plane}")
        for _row, row_group in groupby(plane_group, key=x_row):
            print("".join("#" if _map[x] else "." for x in row_group))


# read input
for row, line in enumerate(input("input")):
    for column, value in enumerate(line.strip()):
        _map[(row, column, 0)] = value == "#"

# populate the first neighbors so we can see/process them
for coords in list(_map):
    active_neighbor_count(*coords)

for _ in range(6):
    counts = [(coords, active_neighbor_count(*coords)) for coords in list(_map)]
    for coords, count in counts:
        active = _map[coords]
        # If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active. Otherwise, the cube becomes inactive.
        if active and (count not in (2,3)):
            _map[coords] = False
        # If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active. Otherwise, the cube remains inactive.
        if not active and (count == 3):
            _map[coords] = True

print(len(list(filter(None, _map.values()))))