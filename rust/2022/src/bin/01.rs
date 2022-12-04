use std::collections::BinaryHeap;
use std::cmp::Reverse;

fn parse_input(input: &str) -> Vec<Vec<u32>> {
    input
        .split("\n\n")
        .map(|txt| txt
             .split("\n")
             .filter(|line| *line != "")
             .map(|line| line.parse().unwrap())
             .collect())
        .collect()
}

pub fn part_one(input: &str) -> Option<u32> {
    parse_input(input)
        .iter()
        .map(|elf| elf.iter().sum())
        .max()
        .into()
}

pub fn part_two(input: &str) -> Option<u32> {
    let elves: Vec<u32> = parse_input(input)
        .iter()
        .map(|elf| elf.iter().sum())
        .collect();
    let mut heap: BinaryHeap<Reverse<u32>> = BinaryHeap::new();
    heap.push(Reverse(0));
    heap.push(Reverse(0));
    heap.push(Reverse(0));
    for elf in elves {
        heap.push(Reverse(elf));
        heap.pop();
    }
    heap.iter().map(|elf| elf.0).sum::<u32>().into()
}

fn main() {
    let input = &advent_of_code::read_file("inputs", 1);
    advent_of_code::solve!(1, part_one, input);
    advent_of_code::solve!(2, part_two, input);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let input = advent_of_code::read_file("examples", 1);
        assert_eq!(part_one(&input), None);
    }

    #[test]
    fn test_part_two() {
        let input = advent_of_code::read_file("examples", 1);
        assert_eq!(part_two(&input), None);
    }
}
