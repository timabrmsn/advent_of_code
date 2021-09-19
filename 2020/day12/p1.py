with open("input") as file:
    data = [row.strip() for row in file.readlines()]

move_east = lambda point, direction, val: ((point[0], point[1] + val), direction)
move_west = lambda point, direction, val: ((point[0], point[1] - val), direction)
move_north = lambda point, direction, val: ((point[0] - val, point[1]), direction)
move_south = lambda point, direction, val: ((point[0] + val, point[1]), direction)
turn_right = lambda point, direction, val: (point, (direction + val) % 360)
turn_left = lambda point, direction, val: (point, (direction - val) % 360)
move_forward = lambda point, direction, val: instructions[direction](point, direction, val)

instructions = {
    "E": move_east,
    0: move_east,
    "S": move_south,
    90: move_south,
    "W": move_west,
    180: move_west,
    "N": move_north,
    270: move_north,
    "R": turn_right,
    "L": turn_left,
    "F": move_forward,
}

point = (0, 0)
direction = 0
for i in data:
    ins, val = i[0], int(i[1:])
    point, direction = instructions[ins](point, direction, val)
    
print(abs(point[0] + abs(point[1])))