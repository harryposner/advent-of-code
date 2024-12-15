advent_of_code::solution!(8);

use std::collections::{HashMap, HashSet};
use itertools::Itertools;

fn gcd(mut a: i32, mut b: i32) -> i32 {
    while b != 0 {
        let t = b;
        b = a % b;
        a = t;
    }
    a
}

struct Map {
    n_rows: i32,
    n_cols: i32,
    antennas: HashMap<char, Vec<(i32, i32)>>
}

impl Map {
    fn from_input(input: &str) -> Map {
        let n_cols = input.chars().position(|c| c == '\n').unwrap().try_into().unwrap();
        let mut current_col  = 0;
        let mut current_row = 0;
        let mut antennas = HashMap::new();
        for c in input.chars() {
            match c {
                '\n' => {
                    current_row += 1;
                    current_col = 0;
                },
                '.'  => current_col += 1,
                _    => {
                    antennas.entry(c).or_insert(Vec::new()).push((current_row, current_col));
                    current_col += 1;
                },
            }
        };
        Map {
            n_rows: current_row,
            n_cols,
            antennas,
        }
    }

    fn count_antinodes(&self) -> u64 {
        let mut antinodes: HashSet<(i32, i32)> = HashSet::new();
        for antennas in self.antennas.values() {
            for pair in antennas.iter().combinations(2) {
                let (r1, c1) = pair[0].to_owned();
                let (r2, c2) = pair[1].to_owned();

                let delta_r = r2 - r1;
                let r_antinode1 = r1 - delta_r;
                let r_antinode2 = r2 + delta_r;

                let delta_c = c2 - c1;
                let c_antinode1 = c1 - delta_c;
                let c_antinode2 = c2 + delta_c;

                if r_antinode1 >= 0 && r_antinode1 < self.n_rows && c_antinode1 >= 0 && c_antinode1 < self.n_cols {
                    antinodes.insert((r_antinode1, c_antinode1));
                }
                if r_antinode2 >= 0 && r_antinode2 < self.n_rows && c_antinode2 >= 0 && c_antinode2 < self.n_cols {
                    antinodes.insert((r_antinode2, c_antinode2));
                }
            }
        };
        antinodes.len().try_into().unwrap()
    }

    fn gen_antinodes(&self) -> HashSet<(i32, i32)> {
        self.antennas.values()
            .flat_map(|antennas| antennas.iter().combinations(2))
            .flat_map(|pair| {
                let (r1, c1) = pair[0].to_owned();
                let (r2, c2) = pair[1].to_owned();
                let delta_r = r2 - r1;
                let delta_c = c2 - c1;
                let dr = delta_r / gcd(delta_r, delta_c);
                let dc = delta_c / gcd(delta_r, delta_c);

                let mut antinodes = Vec::new();
                let mut r = r1;
                let mut c = c1;
                while r >= 0 && r < self.n_rows && c >= 0 && c < self.n_cols {
                    antinodes.push((r, c));
                    r += dr;
                    c += dc
                }
                r = r1;
                c = c1;
                while r >= 0 && r < self.n_rows && c >= 0 && c < self.n_cols {
                    antinodes.push((r, c));
                    r -= dr;
                    c -= dc
                }
                antinodes
            }
            )
            .collect()
    }
}

pub fn part_one(input: &str) -> Option<u64> {
    let map = Map::from_input(input);
    Some(map.count_antinodes())
}

pub fn part_two(input: &str) -> Option<u64> {
    let map = Map::from_input(input);
    let antinodes = map.gen_antinodes();
    Some(antinodes.len().try_into().unwrap())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(14));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(34));
    }
}
