from collections import Counter

from aocd import get_data


def card_rank_1(card):
    return "23456789TJQKA".find(card)

def card_rank_2(card):
    return "J23456789TQKA".find(card)

def score_hand(card_rank, hand):
    count = Counter(Counter(hand).values())
    tiebreakers = tuple(map(card_rank, hand))
    if count[5]:
        return (7, tiebreakers)
    if count[4]:
        return (6, tiebreakers)
    if count[3] and count[2]:
        return (5, tiebreakers)
    if count[3]:
        return (4, tiebreakers)
    if count[2] == 2:
        return (3, tiebreakers)
    if count[2]:
        return (2, tiebreakers)
    return (1, tiebreakers)

def part_1(data):
    result = 0
    data.sort(key=lambda x: score_hand(card_rank_1, x[0]))
    for rank, (hand, bid) in enumerate(data):
        result += (rank + 1) * bid
    return result


if __name__ == "__main__":
    data = []
    for line in get_data(day=7, year=2023).splitlines():
        hand, bid = line.split()
        data.append((hand, int(bid)))
    print(part_1(data))
