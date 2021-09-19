from collections import defaultdict
with open("input") as file:
    data = [line.split() for line in file.readlines()]

acc_total = 0
position = 0
cmd_counts = defaultdict(lambda: 0)


def check_position_only_run_once(position):
    global acc_total
    global cmd_counts
    cmd_counts[position] += 1
    if cmd_counts[position] > 1:
        print(acc_total)
        exit()
        

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

while True:
    cmd, num = data[position]
    check_position_only_run_once(position)
    exec_dict[cmd](num)
