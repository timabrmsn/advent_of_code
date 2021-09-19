from collections import deque

with open("input") as file:
    data = [int(line.strip()) for line in file.readlines()]

key = 1309761972
current = deque()


def check_key(c):
    if sum(c) == key:
        print(min(c) + max(c))
        exit()


for i in data:
    current.append(i)
    check_key(current)
    if sum(current) > key:
        while sum(current) > key:
            current.popleft()
            check_key(current)
