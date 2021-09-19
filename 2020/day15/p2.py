from collections import deque, defaultdict

with open("input", "r") as file:
    numbers = [int(num) for num in file.readline().split(",")]


class Tracker(deque):
    def __init__(self):
        super().__init__(maxlen=2)

    @property
    def diff(self):
        if len(self) == 1:
            return 0
        return self[1] - self[0]


counter = defaultdict(Tracker)
step = 1
for num in numbers:
    counter[num].append(step)
    step += 1

spoken = 0
while step < 30_000_000:
    counter[spoken].append(step)
    spoken = counter[spoken].diff
    step += 1

print(spoken)
