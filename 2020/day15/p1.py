from collections import Counter

with open("input", "r") as file:
    numbers = [int(num) for num in file.readline().split(",")]

step_counter = Counter()
for num, step in zip(numbers[::-1], range(len(numbers))):
    step_counter[num] = step

spoken = numbers[-1]

for _ in range(2020-len(numbers)):
    position = step_counter[spoken]
    for number in step_counter:
        step_counter[number] += 1
    step_counter[spoken] = 1
    spoken = position

print(spoken)
