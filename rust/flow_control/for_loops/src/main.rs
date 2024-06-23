fn main() {
    let message = ['h', 'e', 'l', 'l', 'o'];

    //for item in message {
    //for (index, item) in message.iter().enumerate() {
    for (index, &item) in message.iter().enumerate() {
                println!("item {index} is {item}");

        //if *item == 'e' {
        if item == 'e' {
            break;
        }
    }

    for number in 0..5 {
        println!("number is {number}")
    }
}
