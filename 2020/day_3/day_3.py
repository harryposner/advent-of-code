import math


with open("input.txt", "r") as f:
    lines = [line.strip() for line in f.readlines()]


n_cols = len(lines[0])


def toboggan(right, down):
    current_col = 0
    n_trees = 0
    for line in lines[::down]:
        if line[current_col] == "#":
            n_trees += 1
        current_col = (current_col + right) % n_cols
    return n_trees


print("Part 1:", toboggan(3, 1))
print("Part 2:", math.prod(map(toboggan, [1, 3, 5, 7, 1], [1, 1, 1, 1, 2])))
