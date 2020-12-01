import itertools
from functools import reduce
import operator as op


with open("input.txt", "r") as f:
    nums = [int(line) for line in f if line]


def find_combo(n):
    for combo in itertools.combinations(nums, n):
        if sum(combo) == 2020:
            print(reduce(op.mul, combo))
            break

find_combo(2)
find_combo(3)
