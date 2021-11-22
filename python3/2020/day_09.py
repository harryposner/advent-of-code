from itertools import combinations


with open("input.txt", "r") as f:
    nums = [int(line) for line in f]


def sliding_window(a_list, window_size):
    for i in range(0, len(a_list) - window_size):
        yield a_list[i:i + window_size]


def part_1():
    for window in sliding_window(nums, 26):
        prev = window[:25]
        current = window[-1]
        for combo in combinations(prev, 2):
            if sum(combo) == current:
                break
        else:
            return current


def part_2():
    target = part_1()
    for start, n in enumerate(nums):
        offset = 0
        total = n
        while total < target:
            offset += 1
            total += nums[start + offset]
        if total == target and offset > 0:
            contiguous_set = nums[start:start + offset + 1]
            return max(contiguous_set) + min(contiguous_set)


print("Part 1:", part_1())
print("Part 2:", part_2())
