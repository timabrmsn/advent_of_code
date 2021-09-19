import re
from fileinput import input


def new_math(problem):
    if isinstance(problem, str):
        problem = problem.split()
    if len(problem) == 1:
        return problem[0]
    x = str(eval("".join(problem[:3])))
    return new_math([x] + problem[3:])
    

def reduce_problem(prob):
    while True:
        new = re.sub(pattern=r"\([^(]+?\)", repl=lambda x: new_math(x.group().strip("()")), string=prob)
        if new == prob:
            break
        else:
            prob = new
    return new_math(prob)

_sum = 0
for line in input("input"):
    _sum += int(reduce_problem(line))

print(_sum)