import re

from aocd import get_data


def part_1(data):
    result = 0
    for line in data:
        result += 10 * int(re.match(r"[a-z]*(\d)", line).group(1))
        result += int(re.match(r"[a-z\d]*(\d)", line).group(1))
    return result

def part_2(data):
    return part_1(
            (line
             .replace("zero", "z0ro")
             .replace("one", "o1e")
             .replace("two", "t2o")
             .replace("three", "th3ee")
             .replace("four", "f4ur")
             .replace("five", "f5ve")
             .replace("six", "s6x")
             .replace("seven", "se7en")
             .replace("eight", "ei8ht")
             .replace("nine", "n9ne")
             )
            for line in data
            )

if __name__ == "__main__":
    data = get_data(day=1, year=2023).splitlines()
    print(part_1(data))
    print(part_2(data))
