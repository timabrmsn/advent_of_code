from pathlib import Path
from collections import UserDict
from re import match
from typing import Iterator

file = Path(__file__).parent / "input.txt"
lines = (l.strip() for l in file.open())

def read_cmd(line):
    if m := match("(\$ cd|dir|[0-9]+) (.*)?", line):
        return m.groups()
    else:
        return (None, None)

full_dir_list = []

class Dir(UserDict):
    def __init__(self, parent=None):
        self.parent = parent
        self._size = 0
        super().__init__()
        full_dir_list.append(self)
    
    def process_instructions(self, i: Iterator):
        for line in i:
            cmd, val = read_cmd(line)
            if cmd is None:  # ls
                continue
            elif cmd == "dir":
                self.data[val] = Dir(parent=self)
            elif cmd == "$ cd":
                if val == "..":
                    self.parent.process_instructions(i)
                else:
                    self.data[val].process_instructions(i)
                break
            else:
                file_size = int(cmd)
                self.data[val] = file_size
                self._size += file_size

    @property
    def size(self):
        size = self._size
        for x, y in self.items():
            if isinstance(y, Dir):
                size += y.size
        return size


_ = next(lines)  # we'll create root manually
root = Dir()
root.process_instructions(lines)

small_dirs = [d.size for d in full_dir_list if d.size <= 100000]
print(f"part 1 solution: {sum(small_dirs)}")

current_free_space = 70000000 - root.size
needed_free_space = 30000000 - current_free_space
big_enough_dirs = [d.size for d in full_dir_list if d.size >= needed_free_space]
print(f"part 2 solution: {min(big_enough_dirs)}")
