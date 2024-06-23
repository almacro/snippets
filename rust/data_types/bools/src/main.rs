fn main() {
    let a = true;
    let b = false;

    println!("a is {a}, b is {b}");
    println!("NOT a is {}", !a);
    println!("a AND b is {}", a & b);
    println!("a OR b is {}", a | b);
    println!("a XOR b is {}", a ^ b);

    //let c = (a ^ b) | (a & b);
    //let c = (a ^ b) || (a & b);
    //let c = (a ^ b) || panic!();
    let c = (a ^ b) && panic!();
    println!("c is {c}");
}
