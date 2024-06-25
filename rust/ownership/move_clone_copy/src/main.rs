fn main() {
    //let outer_planet: String;
    let outer_planet: i32;
    {
        //let mut inner_planet = String::from("Mercury");
        let mut inner_planet = 1;
        //println!("inner_planet is {inner_planet}");
        //outer_planet = inner_planet;
        //outer_planet = inner_planet.clone();
        outer_planet = inner_planet;
        //inner_planet.clear();
        inner_planet += 1;
        println!("inner_planet is {inner_planet}");

    }
    println!("outer_planet is {outer_planet}");
}
