fn main() {
    let message = String::from("Greetings from Earth!");
    let first_word = get_first_word(&message);
    //let first_word = get_first_word(&message[10..]);
    println!("first word is {first_word}");
}

//fn get_first_word(s: &String) -> &str {
fn get_first_word(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (index, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[..index];  // found a space!
        }
    }

    &s  // no spaces found; input is a single word
}
