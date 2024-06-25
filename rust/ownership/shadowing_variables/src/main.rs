fn main() {
    let planet = "Earth";
    //println!("Planet is {planet}");
    //let planet = "Mars";
    //planet = "Mars";
    //let planet = 4;
    //let mut planet = 4;
    {
        println!("Planet is {planet}");
        let mut planet = 4;
        println!("Planet is {planet}");
    }
    println!("Planet is {planet}");    
}
