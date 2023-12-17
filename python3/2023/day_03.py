import math
import re
from collections import defaultdict

from aocd import get_data


def neighbors(max_row, max_col, row, start_col, end_col):
    if row != 0:
        for col in range(max(start_col - 1, 0), min(end_col + 1, max_col)):
            yield row - 1, col
    if start_col != 0:
        yield row, start_col - 1
    if end_col != max_col:
        yield row, end_col
    if row != max_row:
        for col in range(max(start_col - 1, 0), min(end_col + 1, max_col)):
            yield row + 1, col

def nums_and_neighbors(data):
    max_row = len(data) - 1
    max_col = len(data[0])
    result = 0
    for row, line in enumerate(data):
        for num in re.finditer("\d+", line):
            start_col = num.start()
            end_col = num.end()
            for nbr_row, nbr_col in neighbors(max_row, max_col, row, start_col, end_col):
                yield num, nbr_row, nbr_col

def part_1(data):
    result = 0
    for num, nbr_row, nbr_col in nums_and_neighbors(data):
        ch = data[nbr_row][nbr_col]
        if ch != "." and not ch.isdigit():
            result += int(num.group())
    return result

def part_2(data):
    gears = defaultdict(set)
    for num, nbr_row, nbr_col in nums_and_neighbors(data):
        ch = data[nbr_row][nbr_col]
        if ch == "*":
            gears[nbr_row, nbr_col].add(num)
    gears = {coords: nums for coords, nums in gears.items() if len(nums) == 2}
    return sum(math.prod(int(n.group()) for n in nums) for nums in gears.values())


if __name__ == "__main__":
    data = get_data(day=3, year=2023).splitlines()
    print(part_1(data))
    print(part_2(data))
