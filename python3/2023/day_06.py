import math

from aocd import get_data

def quadratic(a, b, c):
    zero_1 = (-b + math.sqrt(b**2 - 4*a*c)) / (2 * a)
    zero_2 = (-b - math.sqrt(b**2 - 4*a*c)) / (2 * a)
    return zero_1, zero_2

# Distance in excess of record
# (p = press time, T = total time, R = record distance):
# D = p(T - p) - R
#   = -p**2 + Tp - R

EPSILON = 0.0001

def ways_to_win(total_time, record_distance):
    zeros = quadratic(-1, total_time, -record_distance)
    zero_1 = math.ceil(min(zeros) + EPSILON)
    zero_2 = math.floor(max(zeros) - EPSILON)
    return int(zero_2 - zero_1) + 1

def part_1(data):
    times = [int(num) for num in data[0].split()[1:]]
    distances = [int(num) for num in data[1].split()[1:]]
    return math.prod(ways_to_win(t, d) for t, d in zip(times, distances))

def part_2(data):
    total_time = int("".join(ch for ch in data[0] if ch.isdigit()))
    record_distance = int("".join(ch for ch in data[1] if ch.isdigit()))
    return ways_to_win(total_time, record_distance)

if __name__ == "__main__":
    data = get_data(day=6, year=2023).splitlines()
    print(part_1(data))
    print(part_2(data))
