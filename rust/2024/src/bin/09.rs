advent_of_code::solution!(9);

#[derive(Copy, Clone)]
enum Block {
    Free,
    File(u64),
}

struct Drive {
    blocks: Vec<Block>,
}

impl Drive {
    fn from_input(input: &str) -> Drive {
        let mut blocks = Vec::new();
        for (i, c) in input.trim().chars().enumerate() {
            let n = c.to_digit(10).unwrap();
            let current_block = if i % 2 == 0 {
                Block::File((i as u64) / 2)
            } else {
                Block::Free
            };
            for _ in 0..n {
                blocks.push(current_block);
            }
        }
        Drive { blocks }
    }

    fn move_blocks(&mut self) {
        let mut i = 0;
        let mut j = self.blocks.len() - 1;
        while i < j {
            match (self.blocks[i], self.blocks[j]) {
                (Block::File(_), _) => i += 1,
                (_, Block::Free) => j -= 1,
                (Block::Free, Block::File(_)) => self.blocks.swap(i, j),
            }
        }
    }

    fn checksum(&self) -> u64 {
        let mut result = 0;
        for (i, block) in self.blocks.iter().enumerate() {
            match block {
                Block::Free => break,
                Block::File(id) => result += (i as u64) * id,
            }
        }
        result
    }
}

pub fn part_one(input: &str) -> Option<u64> {
    let mut drive = Drive::from_input(input);
    drive.move_blocks();
    Some(drive.checksum())
}

pub fn part_two(input: &str) -> Option<u64> {
    None
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(1928));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, None);
    }
}
