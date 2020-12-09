from collections import Counter
from copy import deepcopy

with open("input") as file:
    data = [line.split() for line in file.readlines()]
    

def flip_cmd(data):
    for i, cmd in enumerate(data):
        if cmd[0] == "jmp":
            d = deepcopy(data)
            d[i][0] = "nop"
            yield d
        if cmd[0] == "nop":
            d = deepcopy(data)
            d[i][0] = "jmp"
            yield d
    

def check_position(cmd_counts, position):
    cmd_counts[position] += 1
    if cmd_counts[position] > 1:
        raise Exception


def jmp(num):
    global position
    position += int(num)


def acc(num):
    global acc_total
    global position
    position += 1
    acc_total += int(num)


def nop(num):
    global position
    position += 1


exec_dict = {
    "acc": acc,
    "jmp": jmp,
    "nop": nop,
}

for d in flip_cmd(data):
    acc_total = 0
    position = 0
    cmd_counts = Counter()
    try:
        while True:
            cmd, num = d[position]
            check_position(cmd_counts, position)
            exec_dict[cmd](num)
            if position == len(data):
                print(acc_total)
                exit()
    except:
        pass