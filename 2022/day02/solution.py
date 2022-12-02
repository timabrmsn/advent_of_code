from pathlib import Path
from itertools import combinations_with_replacement

file = Path(__file__).parent / "input.txt"

rounds = []

for line in file.open():
    rounds.append(line.strip().split())


round_1_points = {
    ("A", "A"): 3 + 1,  # tie
    ("A", "B"): 6 + 2,  # paper beats rock
    ("A", "C"): 0 + 3,  # scissors loses to rock
    ("B", "B"): 3 + 2,  # tie
    ("B", "C"): 6 + 3,  # scissors beats paper
    ("B", "A"): 0 + 1,  # rock loses to paper
    ("C", "C"): 3 + 3,  # tie
    ("C", "A"): 6 + 1,  # rock beats scissors
    ("C", "B"): 0 + 2,  # paper loses to scissors
}

total = 0
for round in rounds:
    r = round[0], {"X": "A", "Y": "B", "Z": "C"}[round[1]]
    total += round_1_points[r]
print(f"part 1 solution: {total}")


round_2_points = {
    ("A", "X"): 0 + 3,  # lose with scissors
    ("A", "Y"): 3 + 1,  # tie with rock
    ("A", "Z"): 6 + 2,  # win with paper
    ("B", "X"): 0 + 1,  # lose with rock
    ("B", "Y"): 3 + 2,  # tie with paper
    ("B", "Z"): 6 + 3,  # win scissors
    ("C", "X"): 0 + 2,  # lose with paper
    ("C", "Y"): 3 + 3,  # tie with scissors
    ("C", "Z"): 6 + 1,  # win with rock
}
total = 0
for round in rounds:
    total += round_2_points[tuple(round)]
print(f"part 2 solution: {total}")
