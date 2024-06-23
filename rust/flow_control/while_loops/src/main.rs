fn main() {
    let mut count = 0;
    let letters = ['a', 'b', 'c'];

    /* 
    while count < 10 {
        count += 1;
        println!("count is {count}");        
    }
    */

    while count < letters.len() {
        println!("letter is {}", letters[count]);        
        count += 1;
    }
}
