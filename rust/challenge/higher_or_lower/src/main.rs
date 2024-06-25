use std::io;
use rand::prelude::*;

fn main() {
    let mut buffer = String::new();
    let number = thread_rng().gen_range(1..100);
    println!("I am thinking of a number between 1 and 100...");
    loop {
        println!("Guess my number:");
        io::stdin().read_line(&mut buffer);
        let guess: i8 = buffer.trim().parse().unwrap();
        if guess > number {
            println!("That guess was too high, try again");
        } else if guess < number {
            println!("That guess was too low, try again");
        } else {
            break;
        }
        buffer.clear();
    }
    println!("You guessed my number!");
}
