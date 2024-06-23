fn main() {
    let celsius_temp = 23.0;
    let fahrenheit_temp = celsius_to_fahrenheit(celsius_temp);

    assert_eq!(fahrenheit_temp, 73.4);
    println!("Test passed!");
}

fn celsius_to_fahrenheit(temp: f64) -> f64 {
    (9.0/5.0) * temp + 32.0
}