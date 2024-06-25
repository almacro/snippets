fn main() {
    //let letters = ['a', 'b', 'c'];
    let mut letters = ['a', 'b', 'c'];
    letters[0] = 'x';
    let first_letter = letters[0];
    println!("first_letter is {first_letter}");

    let numbers: [i32; 5];
    //numbers = [0, 0, 0, 0, 0];
    numbers = [0; 5];
    //let index = numbers.len();
    //let index: usize = numbers.len();
    let index: usize = numbers.len() - 1;
    //println!("last number is {}", numbers[4]);
    //println!("last number is {}", numbers[5]);
    println!("last number is {}", numbers[index]);
}
