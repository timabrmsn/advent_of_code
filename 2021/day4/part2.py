# --- Part Two ---
# On the other hand, it might be wise to try a different strategy: let the giant 
# squid win.
# 
# You aren't sure how many bingo boards a giant squid could play at once, so 
# rather than waste time counting its arms, the safe thing to do is to figure out 
# which board will win last and choose that one. That way, no matter which boards 
# it picks, it will win for sure.
# 
# In the above example, the second board is the last to win, which happens after 
# 13 is eventually called and its middle column is completely marked. If you were 
# to keep playing until this point, the second board would have a sum of unmarked 
# numbers equal to 148 for a final score of 148 * 13 = 1924.
# 
# Figure out which board will win last. Once it wins, what would its final score 
# be?


class BingoBoard:
    def __init__(self):
        self.rows = [set() for _ in range(5)]
        self.columns = [set() for _ in range(5)]
        self.all = set()
        self.called = set()
        self.bingo = False
    
    def add_row(self, num, cols):
        self.all.update(cols)
        self.rows[num].update(cols)
        for i, val in enumerate(cols):
            self.columns[i].add(val)

    def call_number(self, num):
        if self.bingo:
            return
        self.all.discard(num)
        self.called.add(num)
        for line in self.rows + self.columns:
            if line.issubset(self.called):
                self.bingo = True
                print("BINGO")
                print( sum(self.all)*num )


boards = []
b = None
for line in open("input.txt").readlines():
    if "," in line:
        numbers = [int(n) for n in line.split(",")]
    elif line == "\n":
        row = 0
        if b:
            boards.append(b)
        b = BingoBoard()
    else:
        cols = [int(n) for n in line.split()]
        b.add_row(row, cols)
        row += 1

for num in numbers:
    for b in boards:
        b.call_number(num)


