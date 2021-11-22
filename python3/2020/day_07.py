import re
from collections import defaultdict


outer_bag_pattern = re.compile(r"^(\w+ \w+) bags")
inner_bag_pattern = re.compile(r"(\d+) (\w+ \w+) bag")


def parse_rule(line):
    outer_bag = outer_bag_pattern.match(line).group(1)
    if inner_bag_pattern.search(line):
        inner_bags = inner_bag_pattern.findall(line)
    else:
        inner_bags = []
    return outer_bag, inner_bags


with open("input.txt", "r") as f:
    outer_to_inner = {outer: inners for outer, inners in map(parse_rule, f)}


inner_to_outer = defaultdict(list)
for outer, inners in outer_to_inner.items():
    for __, bag in inners:
        inner_to_outer[bag].append(outer)


def part_1():
    visited = set()

    def traverse(description):
        visited.add(description)
        for outer in inner_to_outer[description]:
            traverse(outer)
    traverse("shiny gold")

    return len(visited) - 1


def part_2():

    def traverse(description):
        total = 1
        for quantity, inner_description in outer_to_inner[description]:
            q = int(quantity)
            total += q * traverse(inner_description)
        return total

    return traverse("shiny gold") - 1


print("Part 1:", part_1())
print("Part 2:", part_2())
