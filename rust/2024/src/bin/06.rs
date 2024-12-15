advent_of_code::solution!(6);


enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Clone)]
#[derive(Copy)]
#[derive(PartialEq)]
enum Cell {
    Empty,
    Visited,
    Impassable,
}

struct Lab {
    guard_coords: (i32, i32),
    guard_direction: Direction,
    n_rows: i32,
    n_cols: i32,
    grid: Vec<Cell>,
}

impl Lab {

    fn from_input(input: &str) -> Lab {
        let n_cols = input.chars().position(|c| c == '\n').unwrap();
        let mut n_rows = 0;
        let mut grid = Vec::new();
        let mut guard_coords = (0, 0);
        for c in input.chars() {
            match c {
                '\n' => n_rows += 1,
                '.'  => grid.push(Cell::Empty),
                '#'  => grid.push(Cell::Impassable),
                '^'  => {
                    let guard_row = (grid.len() / n_cols) as i32;
                    let guard_col = (grid.len() % n_cols) as i32;
                    guard_coords = (guard_row, guard_col);
                    grid.push(Cell::Visited);
                },
                _    => panic!(),
            }
        };
        Lab {
            guard_coords,
            guard_direction: Direction::North,
            n_rows: n_rows as i32,
            n_cols: n_cols as i32,
            grid,
        }
    }

    fn grid_get(&self, row: i32, col: i32) -> Option<Cell> {
        if row < 0 || row >= self.n_rows || col < 0 || col >= self.n_cols {
            None
        } else {
            Some(self.grid[(row * self.n_rows + col) as usize])
        }
    }

    fn grid_set(&mut self, row: i32, col: i32, val: Cell) {
        if row >= 0 && row < self.n_rows && col >= 0 && col < self.n_cols {
            self.grid[(row * self.n_rows + col) as usize] = val;
        }
    }

    fn turn_right(&mut self) {
        self.guard_direction = match &self.guard_direction {
            Direction::North => Direction::East,
            Direction::East  => Direction::South,
            Direction::South => Direction::West,
            Direction::West  => Direction::North,
        }
    }

    fn coords_in_front_of_guard(&self) -> (i32, i32) {
        let (guard_row, guard_col) = self.guard_coords;
        match self.guard_direction {
            Direction::North => (guard_row - 1, guard_col),
            Direction::East  => (guard_row, guard_col + 1),
            Direction::South => (guard_row + 1, guard_col),
            Direction::West  => (guard_row, guard_col - 1),
        }
    }

    fn in_front_of_guard(&mut self) -> Cell {
        let (row_in_front, col_in_front) = self.coords_in_front_of_guard();
        self.grid_get(row_in_front, col_in_front).unwrap_or(Cell::Empty)
    }

    fn step_forward(&mut self) {
        let (row_in_front, col_in_front) = self.coords_in_front_of_guard();
        self.grid_set(row_in_front, col_in_front, Cell::Visited);
        self.guard_coords = (row_in_front, col_in_front);
    }

    fn step(self: &mut Lab) {
        if self.in_front_of_guard() == Cell::Impassable {
            self.turn_right();
        } else {
            self.step_forward();
        }
    }

    fn is_complete(&self) -> bool {
        let (row, col) = self.guard_coords;
        row < 0 || row >= self.n_rows || col < 0 || col >= self.n_cols
    }

    fn simulate(&mut self) -> i32 {
        while !self.is_complete() {
            self.step();
        }
        self.grid.iter().filter(|cell| **cell == Cell::Visited).count().try_into().unwrap()
    }

}


pub fn part_one(input: &str) -> Option<u64> {
    let mut lab: Lab = Lab::from_input(input);
    Some(lab.simulate().try_into().unwrap())
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
        assert_eq!(result, None);
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, None);
    }
}
