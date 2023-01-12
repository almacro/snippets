class Demo {
  static void main(String[] args) {
    Person johnDoe = new Person()
    johnDoe.setFirstName("John")
    johnDoe.setLastName("Doe")
    johnDoe.setAge(40)

    assert johnDoe.toString() == "Person(John, Doe, 40, John Doe)"
    assert johnDoe.equals(johnDoe)
    assert !johnDoe.equals(new Person(firstName: "Mary", lastName: "Hill", age: 30))
    assert new Person(firstName: "Mary", lastName: "Hill", age: 30).toString() == "Person(Mary, Hill, 30, Mary Hill)"

    // Create Closure that prints String representation of a person
    Closure personToString = { Person person -> println person.toString() }
    personToString(johnDoe)

    // Pass Closure to a method and execute it
    handlePerson(personToString, johnDoe)

    // Create Closure that prints full name of a person
    Closure personFullName = { Person person -> println person.getFullName() }
    handlePerson(personFullName, johnDoe)


    // Create a new list of perons
    Person maryHill = new Person(firstName: "Mary", lastName: "Hill", age: 30)
    Person thomasMarks = new Person(firstName: "Thomas", lastName: "Marks", age: 21)
    def allPersons = [johnDoe, maryHill, thomasMarks]

    // Querying Collections
    assert allPersons instanceof List
    assert allPersons.size() == 3
    assert allPersons[2] == thomasMarks

    // Iterate over elements
    allPersons.each {
      println it
    }

    // Iterate over elements and using an index
    allPersons.eachWithIndex { Person entry, int i ->
      println i + ": " + entry
    }

    // Filtering a specific element
    println allPersons.find{ it.lastName == "Hill" } == maryHill

    // Transforming elements into something else
    println allPersons.collect { it.age <= 30 } == [false, true, true]

    // Sorting elements based on a criterion
    println allPersons.sort{ it.age } == [thomasMarks, maryHill, johnDoe]


    // Read full contents of file
    johnDoe = new Person()
    File file = new File("resources/john-doe.txt")
    println file.getText("UTF-8")

    file.eachLine { String line, int no ->
      if (no == 1) {
        johnDoe.setFirstName(line)
      } else if (no == 2) { 
        johnDoe.setLastName(line)
      } else if (no == 3) { 
        johnDoe.setAge(line.toInteger())
      } else {
        throw new RuntimeException(" A person text file should only have 3 lines")
      }
    }

    println johnDoe


    // Create a file and populate contents
    File textFile = new File("resources/mary-hill.txt")
    textFile.withWriter("UTF-8") { BufferedWriter writer ->
      writer.writeLine(maryHill.getFirstName())
      writer.writeLine(maryHill.getLastName())
      writer.writeLine(maryHill.getAge().toString())
    }

    // Appending contents to a file
    textFile.append("1")
    textFile << 2

    // Serializing an object to a file
    File binFile = new File("resources/thomas-marks.bin")
    binFile.withObjectOutputStream { ObjectOutputStream out ->
      out.writeObject(thomasMarks)
    }
  }

  static void handlePerson(Closure c, Person p ) {
    if (p == null) {
      throw new RuntimeException("A person instance cannot be null")
    }
    c(p)
  }
}