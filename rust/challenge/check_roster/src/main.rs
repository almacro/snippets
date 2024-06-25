use std::env;
use std::fs;

fn main() {
    if env::args().len() <= 2 {
        println!("need args: <roster> <name>");
        return;
    }

    let roster_file = env::args().nth(1).unwrap();
    let name = env::args().nth(2).unwrap();

    let names = fs::read_to_string(roster_file).unwrap();
    for line in names.lines() {
        if name == line.trim() {
            println!("Found {name} in the roster file");
            return;
        }
    }
    println!("{name} not found in the roster file");
}
