#!/usr/bin/env python3

from itertools import groupby

with open("input.txt", "r") as f:
    start, end = [int(x) for x in f.read().split("-")]


def non_dec(n):
    for cur, nxt in zip(str(n)[:-1], str(n)[1:]):
        if int(cur) > int(nxt):
            return False
    return True

def two_same(n):
    for cur, nxt in zip(str(n)[:-1], str(n)[1:]):
        if cur == nxt:
            return True
    return False

def exact_two(n):
    for grp in groupby(str(n), lambda x: x):
        if len(list(grp[1])) == 2:
            return True
    return False

for preds in [(non_dec, two_same), (non_dec, exact_two)]:
    count = 0
    for ii in range(start, end+1):
        count += all(p(ii) for p in preds)
    print(count)
