import re
from itertools import takewhile

from aocd import get_data


class Map:

    def __init__(self):
        self.entries = []

    def add(self, dest, source, length):
        self.entries.append((dest, source, length))
        self.next_map = None
        self.prev_map = None

    def get_dest(self, source):
        for dest_start, source_start, length in self.entries:
            if source in range(source_start, source_start + length):
                return dest_start + (source - source_start)
        else:
            return source

    def lookup(self, source):
        dest = self.get_dest(source)
        if self.next_map is None:
            return dest
        return self.next_map.lookup(dest)

def parse(data):
    seeds = [int(num) for num in re.findall(r"\d+", data[0])]
    maps = []
    for line in data[2:]:
        if not line:
            continue
        if (m := re.match(r"([a-z-]+) map:", line)):
            current_map = Map()
            maps.append(current_map)
            continue
        dest, source, length = (int(num) for num in line.split())
        current_map.add(dest, source, length)
    for cur, next_map in zip(maps[:-1], maps[1:]):
        cur.next_map = next_map
        next_map.prev_map = cur
    return seeds, maps

def partition(iterable, n):
    result = []
    for elem in iterable:
        result.append(elem)
        if len(result) == n:
            yield tuple(result)
            result = []


def part_1(seeds, maps):
    init_map = maps[0]
    locations = [init_map.lookup(seed) for seed in seeds]
    return min(locations)


if __name__ == "__main__":
    seeds, maps = parse(get_data(day=5, year=2023).splitlines())
    print(part_1(seeds, maps))
