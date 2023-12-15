import enum
import math
import re

from collections import defaultdict
from dataclasses import dataclass
from typing import List, Dict

from aocd import get_data


class Color(enum.Enum):
    RED = enum.auto()
    GREEN = enum.auto()
    BLUE = enum.auto()

@dataclass
class Game:
    id: int
    sets: List[Dict[Color, int]]

    @classmethod
    def from_str(cls, game_str: str):
        id = int(re.search(r"Game (\d+)", game_str).group(1))
        sets = []
        for set_str in game_str.split(": ")[1].split("; "):
            set = defaultdict(int)
            for count, color in re.findall("(\d+) (red|green|blue)", set_str):
                set[Color.RED if color == "red" else
                    Color.GREEN if color == "green" else
                    Color.BLUE] = int(count)
            sets.append(set)
        return cls(id, sets)

    def min_needed(self) -> Dict[Color, int]:
        result = defaultdict(int)
        for set in self.sets:
            for color in Color:
                result[color] = max(result[color], set[color])
        return result

    def possible_with_bag(self, bag: Dict[Color, int]) -> bool:
        min_needed = self.min_needed()
        for color in Color:
            if bag[color] < min_needed[color]:
                return False
        return True

    def min_power(self) -> int:
        return math.prod(self.min_needed().values())


def part_1(data):
    bag = {Color.RED: 12, Color.GREEN: 13, Color.BLUE: 14}
    return sum(
            game.id
            for line in data
            if (game:=Game.from_str(line)).possible_with_bag(bag)
            )

def part_2(data):
    return sum(Game.from_str(line).min_power() for line in data)


if __name__ == "__main__":
    data = get_data(day=2, year=2023).splitlines()
    print(part_1(data))
    print(part_2(data))
