with open("input", "r") as file:
    data = [line.replace("\n", "") for line in file.read().split("\n\n")]

print(sum([len(set(x)) for x in data]))