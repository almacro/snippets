fn main() {
    /*
    // ints
    let a = 10;
    let b = 3;
    //let c = a + b;
    //let c = a - b;
    //let c = a * b;
    //let c = a / b;
    let c = a % b;
    */

    /*
    // floats
    let a = 10.0;
    let b = 3.0;
    let c = a / b;
    */

    // mixed types
    let a = 10;
    let b = 3.0;
    //let c = a / b;
    //let c = a as f64 / b;
    //let c = a as f64 / b + 1;
    //let c = a as f64 / b + 1.0;
    let c = a as f64 / (b + 1.0);
    println!("c is {c}");
}
