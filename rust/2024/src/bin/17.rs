advent_of_code::solution!(17);

use itertools::Itertools;
use regex::Regex;

#[derive(Clone)]
struct Computer {
    ip: usize,
    reg_a: u64,
    reg_b: u64,
    reg_c: u64,
    program: Vec<u64>,
    output: Vec<u64>,
}

impl Computer {
    fn from_input(input: &str) -> Computer {
        let mut lines = input.lines();
        let digits_pattern = Regex::new(r"\d+").unwrap();
        let reg_a: u64 = digits_pattern
            .find(lines.next().unwrap())
            .unwrap()
            .as_str()
            .parse()
            .unwrap();
        let reg_b: u64 = digits_pattern
            .find(lines.next().unwrap())
            .unwrap()
            .as_str()
            .parse()
            .unwrap();
        let reg_c: u64 = digits_pattern
            .find(lines.next().unwrap())
            .unwrap()
            .as_str()
            .parse()
            .unwrap();
        lines.next();
        let program = digits_pattern
            .find_iter(lines.next().unwrap())
            .map(|m| m.as_str().parse::<u64>().unwrap())
            .collect();
        Computer {
            ip: 0,
            reg_a,
            reg_b,
            reg_c,
            program,
            output: Vec::new(),
        }
    }

    fn is_halted(&self) -> bool {
        self.ip >= self.program.len()
    }

    fn run(&mut self) {
        while !self.is_halted() {
            match (self.program[self.ip], self.program[self.ip + 1]) {
                (0, operand) => self.adv(operand),
                (1, operand) => self.bxl(operand),
                (2, operand) => self.bst(operand),
                (3, operand) => self.jnz(operand),
                (4, operand) => self.bxc(operand),
                (5, operand) => self.out(operand),
                (6, operand) => self.bdv(operand),
                (7, operand) => self.cdv(operand),
                _ => panic!(),
            }
        }
    }

    fn combo_op(&self, operand: u64) -> u64 {
        match operand {
            0..=3 => operand,
            4 => self.reg_a,
            5 => self.reg_b,
            6 => self.reg_c,
            _ => panic!(),
        }
    }

    fn adv(&mut self, combo_operand: u64) {
        let operand = self.combo_op(combo_operand);
        self.reg_a = self.reg_a / (1 << operand);
        self.ip += 2;
    }

    fn bxl(&mut self, literal_operand: u64) {
        self.reg_b = self.reg_b ^ literal_operand;
        self.ip += 2;
    }

    fn bst(&mut self, combo_operand: u64) {
        let operand = self.combo_op(combo_operand);
        self.reg_b = operand & 0b111;
        self.ip += 2;
    }

    fn jnz(&mut self, literal_operand: u64) {
        if self.reg_a != 0 {
            self.ip = literal_operand.try_into().unwrap();
        } else {
            self.ip += 2;
        }
    }

    fn bxc(&mut self, _: u64) {
        self.reg_b = self.reg_b ^ self.reg_c;
        self.ip += 2;
    }

    fn out(&mut self, combo_operand: u64) {
        let operand = self.combo_op(combo_operand);
        self.output.push(operand & 0b111);
        self.ip += 2;
    }

    fn bdv(&mut self, combo_operand: u64) {
        let operand = self.combo_op(combo_operand);
        self.reg_b = self.reg_a / (1 << operand);
        self.ip += 2;
    }

    fn cdv(&mut self, combo_operand: u64) {
        let operand = self.combo_op(combo_operand);
        self.reg_c = self.reg_a / (1 << operand);
        self.ip += 2;
    }

    fn vec2num(vec: &Vec<u64>) -> u64 {
        let mut result = 0;
        for n in vec.iter() {
            result *= 10;
            result += *n;
        }
        result
    }

    fn collect_output(&self) -> u64 {
        Computer::vec2num(&self.output)
    }

}

pub fn part_one(input: &str) -> Option<u64> {
    let mut computer = Computer::from_input(input);
    computer.run();
    Some(computer.collect_output())
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
        assert_eq!(result, Some(4635635210));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(117440));
    }
}
