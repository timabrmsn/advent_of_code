with open("input") as file:
    data = [row.strip() for row in file.readlines()]

move_east =  lambda point, waypoint, val: (point, (waypoint[0], waypoint[1] + val))
move_west =  lambda point, waypoint, val: (point, (waypoint[0], waypoint[1] - val))
move_north = lambda point, waypoint, val: (point, (waypoint[0] - val, waypoint[1]))
move_south = lambda point, waypoint, val: (point, (waypoint[0] + val, waypoint[1]))


def forward_to_waypoint(point, waypoint, n):
    for _ in range(n):
        point, waypoint = move_to_waypoint(point, waypoint)
    return point, waypoint


def move_to_waypoint(point, waypoint):
    x_diff, y_diff = waypoint_diff(point, waypoint)
    new_waypoint = waypoint[0] + x_diff, waypoint[1] + y_diff
    return waypoint, new_waypoint
    
    
def waypoint_diff(point, waypoint):
    return waypoint[0] - point[0], waypoint[1] - point[1]


def rotate_left(point, waypoint, d):
    d = d % 360
    x_diff, y_diff = waypoint_diff(point, waypoint)
    if d == 0:
        return point, waypoint
    if d == 90:
        return point, (point[0] - y_diff, point[1] + x_diff)
    if d == 180:
        return point, (point[0] - x_diff, point[1] - y_diff)
    if d == 270:
        return point, (point[0] + y_diff, point[1] - x_diff)
    
    
def rotate_right(point, waypoint, d):
    d = d % 360
    x_diff, y_diff = waypoint_diff(point, waypoint)
    if d == 0:
        return point, waypoint
    if d == 90:
        return point, (point[0] + y_diff, point[1] - x_diff)
    if d == 180:
        return point, (point[0] - x_diff, point[1] - y_diff)
    if d == 270:
        return point, (point[0] - y_diff, point[1] + x_diff)


instructions = {
    "E": move_east,
    "S": move_south,
    "W": move_west,
    "N": move_north,
    "R": rotate_right,
    "L": rotate_left,
    "F": forward_to_waypoint,
}
    
point = (0, 0)
waypoint = (-1, 10)
for i in data:
    ins, val = i[0], int(i[1:])
    print(ins, point, waypoint, val)
    point, waypoint = instructions[ins](point, waypoint, val)

print(abs(point[0]) + abs(point[1]))
