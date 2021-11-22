#!/usr/bin/env python3
from collections import Counter

with open("day_2_input.txt", "r") as in_file:
    box_ids = list(in_file)

n_2 = n_3 = 0
for box_id in box_ids:
    count_chars = Counter(box_id)
    n_2 += any(val == 2 for val in count_chars.values())
    n_3 += any(val == 3 for val in count_chars.values())

print("Part 1:", n_2 * n_3)

def common_letters(id_1, id_2):
    return "".join(c1 for c1, c2 in zip(id_1, id_2) if c1 == c2)

def diff_by_1(id_1, id_2):
    return len(id_1) - len(common_letters(id_1, id_2)) == 1

for which_id, id_1 in enumerate(box_ids):
    for id_2 in box_ids[(which_id + 1):]:
        if diff_by_1(id_1, id_2):
            print("Part 2:", common_letters(id_1, id_2))
            break
    else:
        continue
    break
