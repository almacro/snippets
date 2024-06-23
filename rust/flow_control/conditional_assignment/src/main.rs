fn main() {
    let make_x_odd = true;
    //let x;
    //let x = if make_x_odd {1} else {2};
    let x = if make_x_odd {1} else {2.0};

    /*
    if make_x_odd {
        x = 1;
    } else {
        //x = 2;
    }
    */

    println!("x is {x}");
}
