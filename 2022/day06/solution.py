from pathlib import Path
from itertools import count

file = Path(__file__).parent / "input.txt"
data = file.read_text().strip()

packet_found = False

for i in count():
    if not packet_found and len(set(data[i:i+4])) == 4:
        print(f"part 1 solution: {i+4}")
        packet_found = True
    if len(set(data[i:i+14])) == 14:
        print(f"part 2 solution: {i+14}")
        break
