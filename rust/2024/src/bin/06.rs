advent_of_code::solution!(6);


#[derive(Copy)]
#[derive(Clone)]
enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(Clone)]
enum Cell {
    Empty,
    Visited([bool; 4]),
    Impassable,
}

#[derive(Clone)]
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
                    grid.push(Cell::Visited([true, false, false, false]));
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

    fn grid_get(&mut self, row: i32, col: i32) -> Option<&mut Cell> {
        if row < 0 || row >= self.n_rows || col < 0 || col >= self.n_cols {
            None
        } else {
            Some(&mut self.grid[(row * self.n_rows + col) as usize])
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

    fn in_front_of_guard(&mut self) -> Option<&mut Cell> {
        let (row_in_front, col_in_front) = self.coords_in_front_of_guard();
        self.grid_get(row_in_front, col_in_front)
    }

    fn step_forward(&mut self) {
        let (row_in_front, col_in_front) = self.coords_in_front_of_guard();
        let guard_dir = self.guard_direction;
        match self.grid_get(row_in_front, col_in_front) {
            Some(Cell::Empty) => {
                let directions = match guard_dir {
                    Direction::North => [true, false, false, false],
                    Direction::East  => [false, true, false, false],
                    Direction::South => [false, false, true, false],
                    Direction::West  => [false, false, false, true],
                };
                self.grid_set(row_in_front, col_in_front, Cell::Visited(directions))
            },
            Some(Cell::Visited(directions)) => {
                match guard_dir {
                    Direction::North => directions[0] = true,
                    Direction::East  => directions[1] = true,
                    Direction::South => directions[2] = true,
                    Direction::West  => directions[3] = true,
                }
            }
            Some(Cell::Impassable) => panic!(),
            None => {},
        }
        self.guard_coords = (row_in_front, col_in_front);
    }

    fn step(self: &mut Lab) {
        match self.in_front_of_guard() {
            Some(Cell::Impassable) => { self.turn_right() },
            _ => { self.step_forward() },
        }
    }

    fn is_complete(&self) -> bool {
        let (row, col) = self.guard_coords;
        row < 0 || row >= self.n_rows || col < 0 || col >= self.n_cols
    }

    fn is_loop(&mut self) -> bool {
        let guard_dir = self.guard_direction;
        match self.in_front_of_guard() {
            Some(Cell::Visited(directions)) => {
                match guard_dir {
                    Direction::North => directions[0],
                    Direction::East  => directions[1],
                    Direction::South => directions[2],
                    Direction::West  => directions[3],
                }
            },
            _ => { false },
        }
    }

    fn simulate(&mut self) {
        while !self.is_complete() && !self.is_loop() {
            self.step();
        }
    }

    fn n_visited(&self) -> i32 {
        self.grid.iter()
            .filter(|cell|
                match **cell {
                    Cell::Visited(_) => true,
                    _ => false,
            })
            .count()
            .try_into()
            .unwrap()
    }

}


pub fn part_one(input: &str) -> Option<u64> {
    let mut lab: Lab = Lab::from_input(input);
    lab.simulate();
    Some(lab.n_visited().try_into().unwrap())
}

pub fn part_two(input: &str) -> Option<u64> {
    let original_lab: Lab = Lab::from_input(input);
    let mut result = 0;
    for row in 0..original_lab.n_rows {
        for col in 0..original_lab.n_cols {
            let mut lab = original_lab.clone();
            match lab.grid_get(row, col) {
                Some(Cell::Empty) => {
                    lab.grid_set(row, col, Cell::Impassable);
                    lab.simulate();
                    if lab.is_loop() {
                        result += 1;
                    };
                }
                _ => {}
            }
        }
    }
    Some(result)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(41));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(6));
    }
}
