/*:
 # Higher Level Languages
 
 Languages like Swift are designed to keep your code concise and easy to work with, they achieve this by abstracting a lot of the common functionality that you will find yourself using across various projects such as strings and various data manipulation functions.
 
 > It is recommended to enable `Editor > Show Rendered Markup` so you can see this markup text with proper formatting and also to enable `Automatically Run` by force clicking the play bottom in the bottom left of the Xcode Playground window.
 
 You can view a higher level language to contain the CS50 Header library we worked with in C earlier in this course and much more to make your life easier. They are also commonly written more concisely for example in Swift you are able to omit semicolons and the `\n` escape sequence as you can see in the `print` statement below. You can also label parameters so the code becomes easier to read and for functions with a single return statement you can omit the `return` keyword.
 */
 
print("Hello, World!")
 
/*:
 ## Language Interpreter
 Swift has something known as an interpreter, this means that even though it is a compiled language you can quickly run code from the command line without needing to compile it every single time with the simple command `swift file.swift` this can save you a lot of time when iterating through versions of a project.
 
 This is the main benefit of working with higher level languages, **getting work done quicker**.

 * Callout(Tip):
 You can compile Swift code into a binary to ensure peak efficiency when running performance-critical tasks.

 ## Memory Management
 
 If you define a variable you don't need to worry about specifying memory to allocate to it and then unallocating it once the variable is no longer in use as in higher level languages memory management is done automatically.
 */

var name = "World"
let a = 64 * 2
print("Hello, \(name)")
name = "Mac"
print("Hello, \(name)")
print("a is equal to \(a)")

/*:
 ## Blurring an Image
 
 Here is an example of the libraries you need already existing to save you the time of coding them all over again.
 
 > Sometimes it is worth coding a library that already exists, either to make it better, to include a feature that isn't within that library or to further your own personal programming knowledge.
 */

import SwiftUI
import PlaygroundSupport

struct ContentView: View {
  var body: some View {
    VStack {
      Text("Blurring an Image!").font(.title)
      Image(
        nsImage: #imageLiteral(resourceName: "sampleImage.jpg")
      ).blur(radius: 5.0)
    }
  }
}

PlaygroundPage.current.setLiveView(ContentView())

/*:
 ## Functions
 
 Below is an example of defining and using a simple function in Swift. You can also see an example of string interpolation being used in Swift, you don't need to tell the compiler or interpreter that it is a formatted string with `f` like in C or Python, you can just interpolate the values within `\(value)`.
 
 One useful feature of Swift is the ability to *label* parameters, this means when you call the function you can use a different word rather than the name of the parameter which makes reading the code more like reading an English sentence. You can also use an `_` to omit a label altogether.
*/

func Greet(_ name: String) {
  print("Hello, \(name)")
}
Greet("Mac")

func testFunction() -> String {"Mac"}
print(testFunction())

func checkNumber(_ x: Int, against y: Int) -> Bool {
  if(x == y) {
    return true
  } else {
    return false
  }
}
checkNumber(5, against: 8)
checkNumber(5, against: 5)

/*:
 ## Types
 
 In Swift type is inferred if there is a value assigned, however if there is no value assigned you can initialise the variable or constant with a type.
 
 > If you change the assignment of `explicitType` below to an integer, you will receive an error.
 
  There are a good variety of types in swift including, Integers, Strings, Arrays, Dictionaries and more. You can read the full list of [types here](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/types/).
*/

let inferredType = "This has a type of string"
let explicitType: String
explicitType = "Hello, World"

/*:
 ## Flow Control
 
 You can do basic flow control like loops and if, else statements using the following examples.
 */

if "a" == "b" {
  print("Hello, world!")
} else if "a" == "a" {
  print("Well, done!")
} else {
 print("Oh, no")
}

for _ in 1...5 {
  print("Hello")
}

for num in 1...5 {
  print ("This is number \(num)")
}

var b = 0
while b < 5 {
  print(b)
  b += 1
}

var c = 5
repeat {
  print(c)
  c -= 1
} while c > 0

/*:
 ## String Comparison
 
 You can very simply comapre strings directly in Swift with no need to iterate through each individual character like in C. There are also lots of methods included within the String class such as checking to see if a string contains a substring, or for getting the number of characters within the string. Other convenient functions include string manipulation such as changing the case.
 */

print("hello" == "hello")
print("hello" == "not hello")
print("hello there".contains("hello"))
print("hello there".count)
print("hello there".uppercased())
print("HELLO THERE".lowercased())

/*:
 ## Arrays and Dictionaries
 
 Swift has native array and dictionary types, this saves you from coding them yourself and also means that they will function the same way across various projects. As I stated earlier because of memory management there is no need to worry about linking the lists together via memory addresses because Swift conveniently handles that for you.
 
 Similar to strings you can conveniently manipulate and work with the data within the array, for example using the `reduce` method to add the values together and just like with the strings you can use the `count` method to check the length of the array. This makes small tasks such as finding the average of an array of numbers require just one line of code rather than a variety of loops.
*/

var scores = [72, 73, 33]
scores.append(64)
print(scores.reduce(0, +) / scores.count)

/*:
  ## Dictionaries
 
 Dictionaries are defined in a similar manner to arrays, except with colons seperating the key and value pairs. You can maniuplate dictionaries in a very similar way to arrays using methods. 
 
 To access properties within a dictionary you use a square bracket syntax such as `people[0]["name"]`, you must either force unwrap `!` or provide a default value in case the compiler cannot find the value.
 
 You can also use arrays to define an array of dictionaries, this can help to create complex data structures with little effort.
*/

var person = ["name": "Carter", "number": "1234"]
var people = [
  person,
  ["name": "David", "number": "5678"],
  ["name": "Harvard", "number": "9012"]
]

people.append(["name": "Mac", "number": "0000"])
print(people[3]["name"]!)
print(people[0]["name"] ?? "No Person Found at index 0")
people.remove(at: 0)
print(people[0]["name"]!)

//: [Next](@next)
