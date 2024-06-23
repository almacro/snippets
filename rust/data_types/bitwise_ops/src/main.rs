fn main() {
    //let value = 0b11110101;
    //let value = 0b1111_0101;
    //let value = 0b1111_0101u8;
    let mut value = 0b1111_0101u8;
    println!("value is {value}");
    println!("value is {value:08b}");

    value = !value;
    println!("value is {value:08b}");

    value = value & 0b1111_0111u8;
    println!("value is {value:08b}");
    println!("bit 6 is {}", value & 0b0100_0000);

    value = value | 0b0100_0000;
    println!("value is {value:08b}");

    value = value ^ 0b0101_0101;
    println!("value is {value:08b}");

    value = value << 4;
    println!("value is {value:08b}");
    value = value >> 2;
    println!("value is {value:08b}");
}
