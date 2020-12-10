with open("input.txt", "r") as f:
    adapters = [0] + sorted(int(line.strip()) for line in f)


cache = {adapters[-1]: 1}


def arrangements(from_index):
    from_num = adapters[from_index]
    if from_num in cache:
        return cache[from_num]
    next_nums = [n for n in
                 adapters[from_index+1:max(from_index+4, len(adapters))]
                 if n - from_num <= 3]
    next_indices = [from_index + i + 1 for i in range(len(next_nums))]
    cache[from_num] = sum(map(arrangements, next_indices))
    return cache[from_num]


print("Part 2:", arrangements(0))
