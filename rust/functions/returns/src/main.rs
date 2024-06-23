fn main() {
    let result = square(13);
    //println!("result = {result}");
    println!("result = {:?}", result);
}

//fn square(x: i32) -> i32 {
fn square(x: i32) -> (i32, i32) {
        println!("squaring {x}");
    //x * x
    return (x, x * x);
    //println!("End of function");    
}