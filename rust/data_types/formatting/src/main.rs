fn main() {
    let a = 10.0;
    let b = 3.0;
    let c = a / b;
    //println!("c is {}", c);
    //println!("c is {:.3}", c);
    //println!("c is {:8.3}", c);
    //println!("c is {:08.3}", c);
    //println!("c is {:08.3}\na is {}", c, a);
    //print!("c is {:08.3}\na is {}", c, a);
    //println!("c is {0:08.3}\na is {1}", c, a);
    //println!("c is {0:08.3}\na is {1}\nonce again c is {0}", c, a);
    // since rust v1.58:
    println!("c is {c:08.3}\na is {a}\nonce again c is {c}");
     
}
