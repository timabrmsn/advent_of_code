from collections import defaultdict

with open("input") as file:
    start_time = int(file.readline())
    buses = [int(x) for x in file.readline().strip().split(",") if x != "x"]

bus_dict = defaultdict(lambda: 0)

for bus in buses:
    while bus_dict[bus] <= start_time:
        bus_dict[bus] += bus

closest = max(buses)
for bus in bus_dict:
    wait_time = bus_dict[bus] - start_time
    if wait_time < closest:
        closest = wait_time
        closest_bus = bus

print(closest_bus * closest)