class HelloWorld {
  static void main(String[] args) {
    println "Hello World!"


    // Define a typed variable
    int age = 40

    // Print variable value
    println age

    // Print variable type
    println age.getClass()

    // Define a variable with dynamic typing
    def name = "John"

    // Print variable value
    println name

    // Print variable type
    println name.getClass()


    // Create new Person class and instantiate it
    Person johnDoe = new Person()
    johnDoe.setFirstName("John")
    johnDoe.setLastName("Doe")
    johnDoe.setAge(40)

    // Print the full name and age of the Person instance
    println johnDoe.getFullName()
    println johnDoe.getAge()


    // Identify if Person is middle-aged using a conditional
    if (johnDoe.getAge() >= 45 && johnDoe.getAge() <= 65) {
      println johnDoe.getFullName() " is middle-aged"
    } else {
      println johnDoe.getFullName() + " is " + johnDoe.getAge() + " years old"
    }

    // Define a list of Persons
    def persons = [ johnDoe, new Person(firstName: "Mary", lastName: "Hill", age: 40)]

    // Iterate over Person instances in list
    for (Person p : persons) {
      println p.getFullName()
    }

    // Convert a String into a Long data type
    //johnDoe.getFullName().toLong()

    // Catch unchecked exception and handle it by printing a message
    try {
      johnDoe.getFullName().toLong()
    } catch(NumberFormatException e) {
      assert e instanceof NumberFormatException
      println "Cannot convert a String into a long"
    }

    // Use the dropRight method to remove 2 characters from the end
    johnDoe = new Person()
    johnDoe.setFirstName("Johnny")
    johnDoe.setLastName("Doe")
    johnDoe.setAge(12)
    println johnDoe.getFirstName().dropRight(2)
  }
}