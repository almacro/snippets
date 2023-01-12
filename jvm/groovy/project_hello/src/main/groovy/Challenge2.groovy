class Challenge2 {
  static void main(String[] args) {
    // Read all lines of every [text] file in the "resources" directory
    // Capture all numbers in a list; omit other entries
    def numberList = []
    File resourceDir = new File("resources")
    resourceDir.eachFile{ File file ->
      if(file.getName().endsWith(".txt")) {
        file.eachLine { String line ->
          line.eachMatch("\\d+", { String d -> numberList.add(d.toInteger()) })
        }
      }
    }
    println(numberList)
    
    // Determine highest number in list and print it
    println "max: " + numberList.max()

    // Add all numbers in list and print sum
    println "sum: " + numberList.sum()
  }
}