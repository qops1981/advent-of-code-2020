use std::fs::File;
use std::io::{prelude::*, BufReader};
use std::path::Path;

fn input_file(filename: impl AsRef<Path>) -> Vec<u32> {
    let file = File::open(filename).expect("no such file");
    let buf = BufReader::new(file);
    buf.lines()
        .map(|l| l.expect("Could not parse line").parse::<u32>().unwrap())
        .collect()
}

fn repair_report(seek: u32, input: Vec<u32>) -> u32 {
    let mut evaluated: Vec<u32> = Vec::new();
    for value in input {
        let diff: u32 = seek - value;
        if evaluated.contains(&diff) {
            return value * diff
        } else {
            evaluated.push(value)
        }
    }
    0
}

fn main() {
    let input = input_file("../../input/day-01/input");
    println!("{:?}", repair_report(2020, input));
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn test_repair_report() {
        let example_input: [u32; 6] = [ 1721, 979, 366, 299, 675, 1456 ];
        assert_eq!(514579, repair_report(2020, example_input.to_vec()));
    }
}