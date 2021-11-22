#!/usr/bin/env python3

import re
from collections import Counter, namedtuple
from itertools import chain, product

Claim = namedtuple("Claim", ["id", "n", "s", "e", "w"])


def string_to_claim(line):
    claim_id, west, north, width, height = map(int, re.findall(r"\d+", line))
    return Claim(claim_id, north, north + height, west + width, west)

with open("day_3_input.txt", "r") as infile:
    claims = list(map(string_to_claim, infile))

def claim_covers(claim):
    return product(range(claim.w, claim.e), range(claim.n, claim.s))

claimed_spots = Counter(chain.from_iterable(
    chain(claim_covers(claim)) for claim in claims)
)

n_double_claims = sum(freq >= 2 for __, freq in claimed_spots.most_common())
print("Part 1:", n_double_claims)

for claim in claims:
    if all(claimed_spots[coord] == 1 for coord in claim_covers(claim)):
        print("Part 2:", claim.id)
        break
