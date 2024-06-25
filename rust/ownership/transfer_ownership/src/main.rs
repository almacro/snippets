fn main() {
    //let rocket_fuel = 1;
    let rocket_fuel = String::from("RP-1");
    //process_fuel(rocket_fuel.clone());
    let rocket_fuel = process_fuel(rocket_fuel);
    println!("rocket_fuel is {rocket_fuel}");
}

//fn process_fuel(mut propellant: i32) {
fn process_fuel(propellant: String) -> String {
    //propellant += 1;
    println!("processing propellant {propellant}...");
    //propellant
    let new_fuel = String::from("LNG");
    new_fuel
}