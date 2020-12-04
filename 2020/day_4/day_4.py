required_keys = {
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
}

passports = []
with open("input.txt") as f:
    current_passport = {}
    for line in f:
        line = line.strip()
        if line:
            for pair in line.split():
                k, v = pair.split(":")
                current_passport[k] = v
        else:
            passports.append(current_passport)
            current_passport = {}
    passports.append(current_passport)


def part_1(passport):
    return len(required_keys & set(passport)) == len(required_keys)


def valid_year(to_check, lower, upper):
    return (len(to_check) == 4
            and to_check.isdigit()
            and lower <= int(to_check) <= upper)


def part_2(passport):
    if not part_1(passport):
        return False
    if not valid_year(passport["byr"], 1920, 2002):
        return False
    if not valid_year(passport["iyr"], 2010, 2020):
        return False
    if not valid_year(passport["eyr"], 2020, 2030):
        return False

    hgt = passport["hgt"]
    if hgt[-2:] not in ("cm", "in"):
        return False
    elif hgt[-2:] == "cm" and not (150 <= int(hgt[:-2]) <= 193):
        return False
    elif hgt[-2:] == "in" and not (59 <= int(hgt[:-2]) <= 76):
        return False

    hcl = passport["hcl"]
    if (hcl[0] != "#"
            or len(hcl) != 7
            or any(x not in "1234567890abcdef" for x in hcl[1:])):
        return False

    if passport["ecl"] not in "amb blu brn gry grn hzl oth".split():
        return False

    pid = passport["pid"]
    if len(pid) != 9 or not pid.isdigit():
        return False

    return True


print("Part 1:", sum(map(part_1, passports)))
print("Part 2:", sum(map(part_2, passports)))
