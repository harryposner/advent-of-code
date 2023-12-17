import re
from collections import defaultdict

from aocd import get_data


def parse_line(line):
    sections = re.match(r"Card +(\d+):(( +\d+)+) +\|(( +\d+)+)", line).groups()
    card_id = int(sections[0])
    winning_nums = set(int(num) for num in sections[1].split(" ") if num)
    nums_in_hand = set(int(num) for num in sections[3].split(" ") if num)
    return card_id, winning_nums, nums_in_hand

def part_1(data):
    result = 0
    for line in data:
        card_id, winning_nums, nums_in_hand = parse_line(line)
        n_winners = len(winning_nums.intersection(nums_in_hand))
        if n_winners:
            result += 2 ** (n_winners - 1)
    return result

def part_2(data):
    n_copies_for_card = defaultdict(lambda: 1)
    for line in data:
        card_id, winning_nums, nums_in_hand = parse_line(line)
        n_winners = len(winning_nums.intersection(nums_in_hand))
        current_card_n_copies = n_copies_for_card[card_id]
        for id_to_inc in range(card_id + 1, card_id + n_winners + 1):
            n_copies_for_card[id_to_inc] += current_card_n_copies
    return sum(n_copies_for_card.values())


if __name__ == "__main__":
    data = get_data(day=4, year=2023).splitlines()
    print(part_1(data))
    print(part_2(data))
