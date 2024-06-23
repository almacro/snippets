fn main() {
    let numbers = [1,9,-2,0,23,20,-7,13,37,20,56,-18,20,3];
    let mut max: i32;
    let mut min: i32;
    let mut mean: f64;
 
    let mut sum: i32;
    let len = numbers.len();

    max = numbers[0];
    min = numbers[0];
    mean = numbers[0].into();

    for index in 1..len {
        let num = numbers[index];
        if num > max {
            max = num;
        } else if num < min {
            min = num;
        }
        mean += num as f64;
    }
    mean /= len as f64;
    
    assert_eq!(max, 56);
    assert_eq!(min, -18);
    assert_eq!(mean, 12.5);
    println!("Test passed!");
}
