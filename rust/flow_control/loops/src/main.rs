fn main() {
    let mut count = 0;

    //loop {
    let result = loop {
        if count == 10 {
            //break;
            break count * 10;
        }
        count += 1;
        println!("count is {count}");        
    //}
    };
    println!("After the loop!");        
    println!("result is {result}");        
}
