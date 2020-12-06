with open("input.txt", "r") as f:
    seats = [int(line.strip()
                 .replace("F", "0")
                 .replace("B", "1")
                 .replace("L", "0")
                 .replace("R", "1"),
                 2)
             for line in f]

print("Part 1:", max(seats))

seats.sort()

for seat, next_seat in zip(seats[:-1], seats[1:]):
    if seat + 1 == next_seat - 1:
        print("Part 2:", seat + 1)
