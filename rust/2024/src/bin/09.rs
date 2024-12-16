advent_of_code::solution!(9);

#[derive(Copy, Clone, PartialEq)]
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
            if let Block::File(id) = block {
                result += (i as u64) * id
            }
        }
        result
    }

    fn move_chunk(&mut self, from: usize, to: usize, length: usize) {
        for i in 0..length {
            self.blocks.swap(from + i, to + i);
        }
    }

    fn file_start(&self, end: usize) -> usize {
        let mut i = end - 1;
        while i > 0 && self.blocks[i - 1] == self.blocks[end - 1] {
            i -= 1;
        }
        i
    }

    fn is_chunk_free(&self, start: usize, length: usize) -> bool {
        self.blocks[start..start + length]
            .iter()
            .all(|block| *block == Block::Free)
    }

    fn move_files(&mut self) {
        let mut file_end = self.blocks.len();
        while file_end > 0 {
            if self.blocks[file_end - 1] == Block::Free {
                file_end -= 1;
                continue;
            }
            let file_start = self.file_start(file_end);
            let file_size = file_end - file_start;
            if file_start < file_size {
                break;
            }
            for free_start in 0..file_start {
                if self.is_chunk_free(free_start, file_size) {
                    self.move_chunk(file_start, free_start, file_size);
                    break;
                }
            }
            file_end = file_start;
        }
    }
}

pub fn part_one(input: &str) -> Option<u64> {
    let mut drive = Drive::from_input(input);
    drive.move_blocks();
    Some(drive.checksum())
}

pub fn part_two(input: &str) -> Option<u64> {
    let mut drive = Drive::from_input(input);
    drive.move_files();
    Some(drive.checksum())
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
        assert_eq!(result, Some(2858));
    }
}
