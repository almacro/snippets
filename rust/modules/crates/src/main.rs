//use rand;
//use rand::random;
use rand::prelude::*;

fn main() {
    //let number = rand::random::<f64>();
    let number = random::<f64>();
    println!("number is {number})");
    
    let number = thread_rng().gen_range(1..11);
    println!("number is {number}");
}
