#!/usr/bin/env python3


with open("day_1_input.txt", "r") as in_file:
    deltas = [int(x) for x in in_file]

print("Part 1:", sum(deltas))

print("Part 2:", end=" ")
seen = set()
frequency = 0
while frequency not in seen:
    for delta in deltas:
        if frequency in seen:
            break
        seen.add(frequency)
        frequency += delta

print(frequency)
