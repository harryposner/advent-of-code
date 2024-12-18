advent_of_code::solution!(11);

fn parse_input(input: &str) -> Vec<u64> {
    input
        .trim()
        .split(" ")
        .filter_map(|numstr| numstr.parse::<u64>().ok())
        .collect()
}

fn count_digits(mut n: u64) -> u64 {
    let mut result = 0;
    while n > 0 {
        result += 1;
        n /= 10;
    }
    result
}

fn split_digits(n: u64) -> (u64, u64) {
    let n_result_digits = count_digits(n) / 2;
    let left = n / 10_u64.pow(n_result_digits.try_into().unwrap());
    let right = n % 10_u64.pow(n_result_digits.try_into().unwrap());
    (left, right)
}

fn blink(stones: Vec<u64>) -> Vec<u64> {
    let mut result = Vec::new();
    for stone in stones {
        if stone == 0 {
            result.push(1);
        } else if count_digits(stone) % 2 == 0 {
            let (left, right) = split_digits(stone);
            result.push(left);
            result.push(right);
        } else {
            result.push(stone * 2024);
        }
    }
    result
}

pub fn part_one(input: &str) -> Option<u64> {
    let mut stones = parse_input(input);
    for _ in 0..25 {
        stones = blink(stones);
    }
    Some(stones.len().try_into().unwrap())
}

pub fn part_two(input: &str) -> Option<u64> {
    let mut stones = parse_input(input);
    for _ in 0..75 {
        stones = blink(stones);
    }
    Some(stones.len().try_into().unwrap())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(55312));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, None);
    }
}
