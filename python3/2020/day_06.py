from functools import reduce

groups = [[]]
with open("input.txt", "r") as f:
    for line in f:
        line = line.strip()
        if line:
            groups[-1].append(line)
        else:
            groups.append([])


print("Part 1:",
      sum(map(lambda group: len(set(c for s in group for c in s)),
              groups)))


print("Part 2:",
      sum(map(lambda group: len(reduce(lambda p1, p2: p1 & p2,
                                       map(set, group))),
              groups)))
