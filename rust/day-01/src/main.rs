use std::fs::File;
use std::io::{prelude::*, BufReader};
use std::path::Path;
use combinations::Combinations;

fn input_file(filename: impl AsRef<Path>) -> Vec<u32> {
    let file = File::open(filename).expect("no such file");
    let buf = BufReader::new(file);
    buf.lines()
        .map(|l| l.expect("Could not parse line").parse::<u32>().unwrap())
        .collect()
}

fn repair_report(seek: u32, input: &Vec<u32>) -> u32 {
    let mut evaluated: Vec<u32> = Vec::new();
    for value in input {
        let diff: u32 = seek - value;
        if evaluated.contains(&diff) {
            return value * diff
        } else {
            evaluated.push(*value)
        }
    }
    0
}

fn repair_report_cubed(seek: u32, input: &Vec<u32>) -> u32 {
    let mut unique_input = input.clone();
    unique_input.sort();
    unique_input.dedup();
    let combinations: Vec<_> = Combinations::new(unique_input, 3).collect();
    for comb in combinations {
        let sum: u32 = comb.iter().sum();
        if sum == seek {
            return comb[0] * comb[1] * comb[2]
        }
    }
    0
}

fn main() {
    let input = input_file("../../input/day-01/input");
    println!("Repair Report: {:?}", repair_report(2020, &input));
    println!("Cubed  Report: {:?}", repair_report_cubed(2020, &input));
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    const EXAMPLE_INPUT: [u32; 6] = [ 1721, 979, 366, 299, 675, 1456 ];

    #[test]
    fn test_repair_report() {
        assert_eq!(514579, repair_report(2020, &EXAMPLE_INPUT.to_vec()));
    }

    #[test]
    fn test_repair_report_cubed() {
        assert_eq!(241861950, repair_report_cubed(2020, &EXAMPLE_INPUT.to_vec()));
    }
}