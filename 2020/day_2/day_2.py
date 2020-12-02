import re


parts = re.compile(r"(\d+)-(\d+) ([a-z]): ([a-z]+)")


def part_1(line):
    match = parts.match(line)
    lbound, ubound, char, pw = match.groups()
    lbound, ubound = int(lbound), int(ubound)
    return lbound <= len([c for c in pw if c == char]) <= ubound


def part_2(line):
    match = parts.match(line)
    index_1, index_2, char, pw = match.groups()
    index_1, index_2 = int(index_1) - 1, int(index_2) - 1
    return (pw[index_1] == char) ^ (pw[index_2] == char)


with open("input.txt", "r") as f:
    lines = f.readlines()


print(sum(map(part_1, lines)))
print(sum(map(part_2, lines)))
