//: [Previous](@previous)

/*:
 # CS-00 Computer Science Introduction

 This [course](https://teachyourselfcs.com/#programming) was designed for those who are self-taught engineers who may have missed some aspects of computer science when learning.

 There are plenty of resources out there for learning computer science and this collection is a designed to give you a world-class CS education without investing years and a small fortune in a degree program.

 The guide answers these questions:
 - Which subjects should you learn, and why?
 - What is the best book or video lecture series for each subject?

 ## Decisions

 I have chosen to follow along this course using a Swift Playground Book, the reasons for this are listed below:

 - Swift is usable as in both compiled and interpreted modes meaning it covers all aspects in this course.
 - It's a language that allows for working in multiple paradigms including functional and object oriented.
 - The eco-system is currently smaller than other languages so a lack of libraries are availible in comparison to other languages, this could inspire new projects I could build throughout the courses.
 - I enjoy working in the language.
 - Playground Books allow live code examples within my note taking, this is incredibly useful when studying.

- Note: These pages are converted to Markdown files to be used with GitHub Pages, the script that performs this transition can be [seen here](../../../process-playground-pages.sh).

 As a brief overview that covers most of the topics in a small amount of detail we will cover [Harvad's CS50-Introduction to Computer Science](https://pll.harvard.edu/course/cs50-introduction-computer-science) this course is designed to cover the basics of each computer science but not delve too deep into these topics, it is highly recommended if you have zero or little experience within this field. That is what the rest of this document contains.

 ## What is Computer Science

 Computer Science is the study of information, it is focused on solving problems utilisign computational thinking.

 A program can simply be thought of as an **input** with a **compute step** resulting in an **output**.

 ## Playground Usage

 If you are viewing this in the browser and would like to see the code in realtime and be able to make edits for learning follow these steps:

 1. Clone the repository to your local machine.
 2. Open the Playground in Xcode or Swift Playgrounds.
 3. Make your edits and save them.
 4. Commit your changes and push them to your repository.
 5. View your changes on GitHub Pages.

 - Attention: Ensure you have `Editor > Show Rendered Markup` enabled in Xcode to preview the rendered notes.

 ### Quick Reference

 **The Binary System**

 Computers count in binary utilising a combination of 0's and 1's to represent numbers. Electricity passing through transistors which can store or allow that electricity to dissipate is how a binary digit or bit determines its value.

 **Counting from 1 to 10 in Binary**

 - `0000 == 0`
 - `0001 == 1`
 - `0010 == 2`
 - `0011 == 3`
 - `0100 == 4`
 - `0101 == 5`
 - `0110 == 6`
 - `0111 == 7`
 - `1000 == 8`
 - `1001 == 9`
 - `1010 == 10`

 In **base 10** the number `123` is seen as a whole number rather than a sequence.

 You can count to higher numbers with more bits. We utilise `bytes` or `B` which are a collection of 8 `bits` or `b`. This is helpful for cleaner equations as it's a power of 2. `00000000` is 0 represented in a `byte` and `11111111` is `255`.


 **Section Contents**
 - [Languages](#programming-languages)
 - [Arrays](#arrays)
 - [Algorithms](#algorithms)
 - [Memory](#memory)
 - [Data Structures](#data-structures)
 - [Using Libraries](#using-libraries)
 - [Artifical Intelligence](#artificial-intelligence)
 - [SQL](#sql)

## Programming Languages

 Source code is what the human writes, it is compiled down to machine code. This is because if we were writing an entire program in 0s and 1s like in the past with punchcards, programming would be very painful.

 ### Compiling

Compiling is the action of taking your source code and converting it into machine code so the computer is able to run it.

// Here's a simple Swift program
let message = "Hello, World!"
print(message)

// The compiler translates this human-readable code into machine code
// that the computer can execute

 ### Keywords

 Source code is full of keywords, these dictate to the compiler that a specific action should happen

// Keywords in Swift
let constantValue = 10      // 'let' is a keyword for declaring constants
var variableValue = 20      // 'var' is a keyword for declaring variables
if constantValue < variableValue {  // 'if' is a conditional keyword
    print("Variable is larger")
}
for i in 0..<5 {            // 'for' and 'in' are keywords for loops
    print("Count: \(i)")
}
func greet(name: String) {  // 'func' is a keyword for declaring functions
    print("Hello, \(name)!")
}
greet(name: "Swift")

 ## The Binary System

 In computing, everything ultimately gets represented as binary. Let's explore how binary works and how Swift handles binary operations:
 */

// Binary Representation
let binaryLiteral = 0b1010  // Binary literal for decimal 10
print("Binary 0b1010 = \(binaryLiteral) in decimal")

// Binary Operations
let a = 0b1100  // 12 in decimal
let b = 0b1010  // 10 in decimal
let bitwiseAND = a & b      // Bitwise AND
let bitwiseOR = a | b       // Bitwise OR
let bitwiseXOR = a ^ b      // Bitwise XOR
let bitwiseNOT = ~a         // Bitwise NOT
let leftShift = a << 1      // Left shift
let rightShift = a >> 1     // Right shift

print("Bitwise operations on \(a) and \(b):")
print("AND: \(bitwiseAND), OR: \(bitwiseOR), XOR: \(bitwiseXOR)")
print("NOT a: \(bitwiseNOT), a << 1: \(leftShift), a >> 1: \(rightShift)")

// Convert integer to binary string representation
func toBinaryString(_ value: Int, padLength: Int = 8) -> String {
    let binaryString = String(value, radix: 2)
    return String(repeating: "0", count: max(0, padLength - binaryString.count)) + binaryString
}

print("\nBinary representation of \(a): \(toBinaryString(a))")
print("Binary representation of \(b): \(toBinaryString(b))")
print("AND result: \(toBinaryString(bitwiseAND))")

/*:
 ## Arrays

 Arrays in Swift are ordered collections of values. They are fundamental data structures used in many algorithms.
 */

// Creating arrays
var numbers = [1, 2, 3, 4, 5]
var names = ["Alice", "Bob", "Charlie"]
var emptyArray: [Int] = []

// Accessing elements
print("\nThe first number is: \(numbers[0])")
print("The last name is: \(names[names.count - 1])")

// Adding elements
numbers.append(6)
names += ["Dave", "Eve"]

// Iterating through arrays
print("\nAll numbers:")
for number in numbers {
    print(number, terminator: " ")
}
print()

// Array operations
let sum = numbers.reduce(0, +)
let allNamesString = names.joined(separator: ", ")
print("\nSum of numbers: \(sum)")
print("Names: \(allNamesString)")

// Finding elements
if let index = names.firstIndex(of: "Bob") {
    print("Bob is at position \(index)")
}

// Sorting
let sortedNumbers = numbers.sorted()
let reversedNumbers = numbers.sorted(by: >)
print("\nSorted numbers: \(sortedNumbers)")
print("Reversed numbers: \(reversedNumbers)")

/*:
 ## Algorithms

 Algorithms are step-by-step procedures for calculations. Here are some common algorithms implemented in Swift:
 */

// Linear Search Algorithm
/*:
 ## Algorithms

 Algorithms are step-by-step procedures for solving problems. Two essential characteristics of algorithms are:

 1. **Correctness**: The algorithm must solve the problem correctly for all valid inputs
 2. **Efficiency**: The algorithm should use computational resources efficiently

 ### Searching Algorithms
 */

/// Performs a linear search through an array
/// - Parameters:
///   - array: The array to search through
///   - item: The item to find
/// - Returns: The index of the item if found, nil otherwise
/// - Complexity: O(n) - linear time complexity
func linearSearch<T: Equatable>(_ array: [T], _ item: T) -> Int? {
    for (index, element) in array.enumerated() {
        if element == item {
            return index
        }
    }
    return nil
}

/// Performs a binary search through a sorted array
/// - Parameters:
///   - array: The sorted array to search through
///   - item: The item to find
/// - Returns: The index of the item if found, nil otherwise
/// - Complexity: O(log n) - logarithmic time complexity
func binarySearch<T: Comparable>(_ array: [T], _ item: T) -> Int? {
    var low = 0
    var high = array.count - 1

    while low <= high {
        let mid = (low + high) / 2
        if array[mid] == item {
            return mid
        } else if array[mid] < item {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return nil
}

/*:
 ### Sorting Algorithms

 Sorting is a fundamental operation in computer science. Below is an implementation of the bubble sort algorithm.
 */

/// Sorts an array using the bubble sort algorithm
/// - Parameter array: The array to sort
/// - Returns: A sorted copy of the array
/// - Complexity: O(n²) - quadratic time complexity
func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
    var result = array
    let n = result.count
    for i in 0..<n {
        for j in 0..<n-i-1 {
            if result[j] > result[j+1] {
                result.swapAt(j, j+1)
            }
        }
    }
    return result
}

// Testing the algorithms
let testArray = [5, 2, 9, 1, 7, 4, 6, 3, 8]
print("\nOriginal array: \(testArray)")
let sorted = bubbleSort(testArray)
print("Sorted array: \(sorted)")

let searchItem = 7
if let linearIndex = linearSearch(testArray, searchItem) {
    print("Linear search: \(searchItem) found at index \(linearIndex)")
}
if let binaryIndex = binarySearch(sorted, searchItem) {
    printinaryIndex) in sorted array")
}

/*:
 ## Memory Management

 Swift uses Automatic Reference Counting (ARC) to manage memory. Understanding how memory works is essential for writing efficient code.
 */

// Value Types vs Reference Types
struct Point {
    var x: Int
    var y: Int
}

class Rectangle {
    var origin: Point
    var width: Int
    var height: Int

    init(origin: Point, width: Int, height: Int) {
        self.origin = origin
        self.width = width
        self.height = height
    }

    func area() -> Int {
        return width * height
    }
}

// Value type demonstration
var point1 = Point(x: 10, y: 20)
var point2 = point1  // Creates a copy
point2.x = 15

print("\nValue types demonstration:")
print("point1: (\(point1.x), \(point1.y))")
print("point2: (\(point2.x), \(point2.y))")

// Reference type demonstration
let rect1 = Rectangle(origin: Point(x: 0, y: 0), width: 10, height: 5)
let rect2 = rect1  // Both variables reference the same instance
rect2.width = 20

print("\nReference types demonstration:")
print("rect1: width = \(rect1.width), height = \(rect1.height), area = \(rect1.area())")
print("rect2: width = \(rect2.width), height = \(rect2.height), area = \(rect2.area())")

/*:
 ## Data Structures

 Data structures organize and store data. Swift provides several built-in data structures, and you can create custom ones.
 */

// Dictionary
var studentScores: [String: Int] = [
    "Alice": 95,
    "Bob": 82,
    "Charlie": 88
]

print("\nStudent scores:")
for (name, score) in studentScores {
    print("\(name): \(score)")
}

// Adding and modifying dictionary entries
studentScores["Dave"] = 91
studentScores["Bob"] = 85

// Sets
var fruitsSet: Set<String> = ["Apple", "Banana", "Orange"]
var vegetablesSet: Set<String> = ["Carrot", "Broccoli", "Banana"]

print("\nFruits set: \(fruitsSet)")
print("Vegetables set: \(vegetablesSet)")

// Set operations
let intersection = fruitsSet.intersection(vegetablesSet)
let union = fruitsSet.union(vegetablesSet)
let difference = fruitsSet.subtracting(vegetablesSet)

print("Intersection: \(intersection)")
print("Union: \(union)")
print("Difference (fruits - vegetables): \(difference)")

// Custom data structure: Linked List
/*:
 ## Data Structures

 Data structures are specific ways to organize and store data. They offer different ways to modify, access, and search through data.

 ### Linked Lists

 A linked list is a linear data structure where elements are stored in nodes. Each node contains data and a reference to the next node.
 */

/// A node in a linked list
class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode<T>?

    init(value: T) {
        self.value = value
    }
}

/// A singly linked list implementation
class LinkedList<T> {
    var head: LinkedListNode<T>?

    /// Adds a new value to the end of the list
    /// - Parameter value: The value to append
    func append(_ value: T) {
        let newNode = LinkedListNode(value: value)

        if head == nil {
            head = newNode
            return
        }

        var current = head
        while current?.next != nil {
            current = current?.next
        }

        current?.next = newNode
    }

    /// Prints the entire linked list
    func printList() {
        var current = head
        while current != nil {
            print(current?.value ?? "nil", terminator: " -> ")
            current = current?.next
        }
        print("nil")
    }
}

/*:
 Example usage of a linked list:
 ```swift
 let list = LinkedList<Int>()
 list.append(1)
 list.append(2)
 list.append(3)
 list.printList()  // Output: 1 -> 2 -> 3 -> nil
 ```
 */

// Using the linked list
let linkedList = LinkedList<Int>()
linkedList.append(1)
linkedList.append(2)
linkedList.append(3)
linkedList.append(4)
linkedList.printList()

/*:
 ## Recursion

 Recursion is a technique where a function calls itself. It's useful for solving problems that can be broken down into simpler versions of the same problem.
 */

// Factorial using recursion
func factorial(_ n: Int) -> Int {
    if n <= 1 {
        return 1
    }
    return n * factorial(n - 1)
}

// Fibonacci sequence using recursion
func fibonacci(_ n: Int) -> Int {
    if n <= 1 {
        return n
    }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

print("\nRecursion examples:")
print("Factorial of 5: \(factorial(5))")
print("Fibonacci number at position 7: \(fibonacci(7))")

// More efficient Fibonacci using memoization
func efficientFibonacci(_ n: Int) -> Int {
    var memo: [Int: Int] = [0: 0, 1: 1]

    func fib(_ n: Int) -> Int {
        if let result = memo[n] {
            return result
        }

        memo[n] = fib(n - 1) + fib(n - 2)
        return memo[n]!
    }

    return fib(n)
}

print("Efficient Fibonacci number at position 20: \(efficientFibonacci(20))")

/*:
 ## Object-Oriented Programming

 Swift supports object-oriented programming with classes, inheritance, and polymorphism.
 */

// Base class
/*:
 ## Object-Oriented Programming

 Object-Oriented Programming (OOP) is a programming paradigm based on the concept of "objects" which contain data and code. Swift supports OOP principles.

 ### Classes and Inheritance

 Swift supports classes with single inheritance, where subclasses inherit properties and methods from their parent class.
 */

/// A base shape class
class Shape {
    var name: String

    init(name: String) {
        self.name = name
    }

    /// Calculates the area of the shape
    /// - Returns: The area as a Double
    func area() -> Double {
        return 0.0
    }

    /// Returns a description of the shape
    /// - Returns: A string describing the shape
    func description() -> String {
        return "A shape named \(name)"
    }
}

/// A circle shape class that inherits from Shape
class Circle: Shape {
    var radius: Double

    init(radius: Double) {
        self.radius = radius
        super.init(name: "Circle")
    }

    override func area() -> Double {
        return Double.pi * radius * radius
    }

    override func description() -> String {
        return "A circle with radius \(radius)"
    }
}

/// A square shape class that inherits from Shape
class Square: Shape {
    var side: Double

    init(side: Double) {
        self.side = side
        super.init(name: "Square")
    }

    override func area() -> Double {
        return side * side
    }

    override func description() -> String {
        return "A square with side \(side)"
    }
}

/*:
 Example usage of shapes:
 ```swift
 let circle = Circle(radius: 5)
 print(circle.description())  // Output: A circle with radius 5.0
 print("Area: \(circle.area())")  // Output: Area: 78.53981633974483

 let square = Square(side: 4)
 print(square.description())  // Output: A square with side 4.0
 print("Area: \(square.area())")  // Output: Area: 16.0
 ```
 */

// Using the OOP classes
let circle = Circle(radius: 5)
let square = Square(side: 4)

print("\nObject-Oriented Programming:")
print(circle.description())
print(square.description())

// Polymorphism
let shapes: [Shape] = [circle, square]
for shape in shapes {
    print(shape.description())
}

/*:
 ## Error Handling

 Swift provides robust error handling capabilities.
 */

// Define custom error type
/*:
 ## Error Handling

 Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.
 */

/// Custom errors for mathematical operations
enum MathError: Error {
    case divisionByZero
    case negativeNumber(value: Int)
}

/// Calculates the square root of a number
/// - Parameter number: The number to find the square root of
/// - Returns: The square root as a Double
/// - Throws: MathError.negativeNumber if the input is negative
func squareRoot(of number: Int) throws -> Double {
    if number < 0 {
        throw MathError.negativeNumber(value: number)
    }
    return sqrt(Double(number))
}

/// Divides two integers
/// - Parameters:
///   - a: The numerator
///   - b: The denominator
/// - Returns: The result of the division
/// - Throws: MathError.divisionByZero if the denominator is zero
func divide(_ a: Int, by b: Int) throws -> Int {
    if b == 0 {
        throw MathError.divisionByZero
    }
    return a / b
}

/*:
 Example of error handling:
 ```swift
 do {
     let result = try squareRoot(of: -1)
     print(result)
 } catch MathError.negativeNumber(let value) {
     print("Cannot calculate square root of a negative number: \(value)")
 } catch {
     print("An unexpected error occurred: \(error)")
 }

 do {
     let result = try divide(10, by: 0)
     print(result)
 } catch MathError.divisionByZero {
     print("Cannot divide by zero")
 } catch {
     print("An unexpected error occurred: \(error)")
 }
 ```
 */

// Using error handling
print("\nError handling examples:")

/*:
 ## Binary System

 Computers store all data in binary (0s and 1s). This is the foundation of computing. In binary:

 - Each digit is called a **bit**
 - 8 bits make a **byte**
 - Binary digits are powers of 2 (1, 2, 4, 8, 16, 32, 64, 128...)

 ### Binary Representation

 | Decimal | Binary |
 |---------|--------|
 | 0       | 0000   |
 | 1       | 0001   |
 | 2       | 0010   |
 | 3       | 0011   |
 | 4       | 0100   |
 | 5       | 0101   |
 | ...     | ...    |

 Converting between decimal and binary is a fundamental computing operation.
 */

/// Converts a decimal integer to its binary string representation
/// - Parameters:
///   - value: The decimal integer to convert
///   - padLength: The minimum length of the result (will be padded with leading zeros)
/// - Returns: A string representing the binary value
func toBinaryString(_ value: Int, padLength: Int = 8) -> String {
    return String(value, radix: 2).padLeft(toLength: padLength, withPad: "0")
}

// Extension to support string padding
extension String {
    func padLeft(toLength length: Int, withPad character: Character) -> String {
        let paddingLength = length - self.count
        if paddingLength <= 0 {
            return self
        }
        return String(repeating: character, count: paddingLength) + self
    }
}

/*:
 Example binary conversions:
 ```swift
 print(toBinaryString(5))     // Output: 00000101
 print(toBinaryString(10))    // Output: 00001010
 print(toBinaryString(255))   // Output: 11111111
 ```

 ### Characters in Binary

 Characters are represented using ASCII or Unicode encoding:

 - ASCII uses 7 bits (128 possible characters)
 - Extended ASCII uses 8 bits (256 possible characters)
 - Unicode (UTF-8, UTF-16) can use multiple bytes to represent characters from all languages

 For example, the letter 'A' is represented as 65 in decimal or 01000001 in binary.
 */

// Binary representation examples
print("\nBinary representation examples:")
print("5 in binary: \(toBinaryString(5))")
print("10 in binary: \(toBinaryString(10))")
print("255 in binary: \(toBinaryString(255))")
print("'A' character code: \(Int(Character("A").asciiValue ?? 0))")
print("'A' in binary: \(toBinaryString(Int(Character("A").asciiValue ?? 0)))")

/*:
 ## Algorithmic Efficiency

 Understanding the efficiency of algorithms is crucial for writing performant software.

 ### Big O Notation

 Big O notation describes the performance or complexity of an algorithm:

 - **O(1)** - Constant time: The operation takes the same amount of time regardless of input size
 - **O(log n)** - Logarithmic time: The operation's time increases logarithmically with input size (example: binary search)
 - **O(n)** - Linear time: The operation's time increases linearly with input size (example: linear search)
 - **O(n log n)** - Linearithmic time: Common in efficient sorting algorithms (example: merge sort)
 - **O(n²)** - Quadratic time: The operation's time increases quadratically with input size (example: bubble sort)
 - **O(2^n)** - Exponential time: The operation's time doubles with each addition to the input (example: recursive Fibonacci)

 ### Common Algorithm Complexities

 | Algorithm       | Time Complexity (Average) | Time Complexity (Worst) | Space Complexity |
 |-----------------|---------------------------|-------------------------|------------------|
 | Linear Search   | O(n)                     | O(n)                    | O(1)             |
 | Binary Search   | O(log n)                 | O(log n)                | O(1)             |
 | Bubble Sort     | O(n²)                    | O(n²)                   | O(1)             |
 | Merge Sort      | O(n log n)               | O(n log n)              | O(n)             |
 | Quick Sort      | O(n log n)               | O(n²)                   | O(log n)         |
 */

do {
    let result1 = try squareRoot(of: 16)
    print("\nSquare root of 16 is \(result1)")

    let result2 = try divide(10, by: 2)
    print("10 divided by 2 is \(result2)")

    // This will throw an error
    // let result3 = try squareRoot(of: -4)
    // let result4 = try divide(10, by: 0)
} catch MathError.negativeNumber(let value) {
    print("Cannot calculate square root of negative number: \(value)")
} catch MathError.divisionByZero {
    print("Cannot divide by zero")
} catch {
    print("Unknown error occurred: \(error)")
}

/*:
 ## Functional Programming

 Swift supports functional programming concepts like map, filter, and reduce.
 */

let numbers2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Map: Transform each element
let squared = numbers2.map { $0 * $0 }

// Filter: Keep elements that satisfy a condition
let evenNumbers = numbers2.filter { $0 % 2 == 0 }

// Reduce: Combine all elements into a single value
let sum2 = numbers2.reduce(0, +)
let product = numbers2.reduce(1, *)

print("\nFunctional programming examples:")
print("Original numbers: \(numbers2)")
print("Squared: \(squared)")
print("Even numbers: \(evenNumbers)")
print("Sum: \(sum2)")
print("Product: \(product)")

// Combining functional operations
let sumOfSquaresOfEvenNumbers = numbers2
    .filter { $0 % 2 == 0 }  // Keep even numbers
    .map { $0 * $0 }         // Square each number
    .reduce(0, +)            // Sum them up

/*:
 ## Recursion

 Recursion is when a function calls itself to solve a problem. It requires:

 1. A **base case** that prevents infinite recursion
 2. A **recursive case** where the function calls itself with a modified input

 Recursion is often elegant for problems that can be broken down into smaller, similar subproblems.
 */

/// Calculates the factorial of a number using recursion
/// - Parameter n: The number to calculate factorial for
/// - Returns: The factorial of n (n!)
/// - Complexity: O(n) time, O(n) space due to call stack
func factorial(_ n: Int) -> Int {
    // Base case
    if n <= 1 {
        return 1
    }
    // Recursive case
    return n * factorial(n - 1)
}

/// Calculates the nth Fibonacci number using recursion
/// - Parameter n: The position in the Fibonacci sequence
/// - Returns: The nth Fibonacci number
/// - Complexity: O(2^n) time due to exponential growth of calls
func fibonacci(_ n: Int) -> Int {
    // Base cases
    if n <= 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    // Recursive case
    return fibonacci(n - 1) + fibonacci(n - 2)
}

/// Calculates the nth Fibonacci number using dynamic programming
/// - Parameter n: The position in the Fibonacci sequence
/// - Returns: The nth Fibonacci number
/// - Complexity: O(n) time, O(1) space
func efficientFibonacci(_ n: Int) -> Int {
    // Helper function using memoization
    func fib(_ n: Int) -> Int {
        var memo = [0, 1]
        if n <= 1 {
            return n
        }
        for i in 2...n {
            memo.append(memo[i-1] + memo[i-2])
        }
        return memo[n]
    }

    return fib(n)
}

print("\nRecursion examples:")
print("Factorial of 5: \(factorial(5))")
print("Fibonacci (8): \(fibonacci(8))")
print("Efficient Fibonacci (30): \(efficientFibonacci(30))")

/*:
 Notice the difference in performance between regular recursive Fibonacci and the optimized version:

 - Regular recursive Fibonacci has O(2^n) time complexity, which becomes impractical for larger inputs
 - The efficient version using dynamic programming has O(n) time complexity

 This demonstrates a key computer science principle: there are often multiple ways to solve a problem,
 with dramatically different performance characteristics.
 */

/*:
 ## Artificial Intelligence

 Artificial Intelligence (AI) involves creating systems that can perform tasks normally requiring human intelligence.

 ### Basic Concepts

 - **Machine Learning**: Systems that learn from data rather than being explicitly programmed
 - **Neural Networks**: Computing systems inspired by biological neural networks
 - **Natural Language Processing**: Enabling computers to understand and generate human language

 ### Neural Network Example

 Below is a simple implementation of a single neuron in a neural network:
 */

/// Simulates a single neuron in a neural network
/// - Parameters:
///   - inputs: Array of input values
///   - weights: Array of weights for each input
///   - bias: The bias value for the neuron
/// - Returns: The output of the neuron after activation
func neuralNetworkSimulation(inputs: [Double], weights: [Double], bias: Double) -> Double {
    // Calculate the weighted sum
    var weightedSum = bias
    for i in 0..<min(inputs.count, weights.count) {
        weightedSum += inputs[i] * weights[i]
    }

    // Apply activation function (sigmoid)
    return 1.0 / (1.0 + exp(-weightedSum))
}

// Example of a simple neural network neuron
let inputs = [0.5, 0.3, 0.2]
let weights = [0.4, 0.7, 0.2]
let bias = -0.5

let output = neuralNetworkSimulation(inputs: inputs, weights: weights, bias: bias)
print("\nNeural network example:")
print("Inputs: \(inputs)")
print("Weights: \(weights)")
print("Bias: \(bias)")
print("Output: \(output)")

/*:
 This simple neuron demonstrates the fundamental building block of neural networks. Real AI systems
 consist of many such neurons arranged in layers, forming deep neural networks capable of complex tasks.

 ### Decision-Making System Example

 Another aspect of AI is rule-based systems for decision making:
 */

/// Classifies an animal based on its characteristics
/// - Parameters:
///   - hasFur: Whether the animal has fur
///   - numberOfLegs: How many legs the animal has
///   - canFly: Whether the animal can fly
/// - Returns: A string describing the animal classification
func classifyAnimal(hasFur: Bool, numberOfLegs: Int, canFly: Bool) -> String {
    if hasFur {
        if numberOfLegs == 4 {
            return "Mammal (likely a cat, dog, or similar quadruped)"
        } else if numberOfLegs == 2 {
            return "Possibly a primate"
        } else {
            return "Unusual mammal"
        }
    } else {
        if canFly {
            if numberOfLegs == 2 {
                return "Bird"
            } else {
                return "Flying insect or bat"
            }
        } else {
            if numberOfLegs == 0 {
                return "Fish or reptile"
            } else if numberOfLegs == 2 {
                return "Possibly a reptile"
            } else if numberOfLegs == 4 {
                return "Reptile or amphibian"
            } else if numberOfLegs == 6 {
                return "Insect"
            } else if numberOfLegs == 8 {
                return "Arachnid"
            } else {
                return "Unknown classification"
            }
        }
    }
}

// Test the classification system
print("\nDecision-making system example:")
print("Classify(hasFur: true, numberOfLegs: 4, canFly: false): \(classifyAnimal(hasFur: true, numberOfLegs: 4, canFly: false))")
print("Classify(hasFur: false, numberOfLegs: 2, canFly: true): \(classifyAnimal(hasFur: false, numberOfLegs: 2, canFly: true))")
print("Classify(hasFur: false, numberOfLegs: 8, canFly: false): \(classifyAnimal(hasFur: false, numberOfLegs: 8, canFly: false))")

/*:
 ## Conclusion

 This playground covers the fundamental concepts of computer science based on Harvard's CS50 curriculum:

 1. **Binary System**: The foundation of computing, representing data as 0s and 1s
 2. **Data Structures**: Ways to organize and store data (arrays, linked lists, etc.)
 3. **Algorithms**: Step-by-step procedures for solving problems (searching, sorting)
 4. **Algorithmic Efficiency**: Understanding the performance of algorithms using Big O notation
 5. **Object-Oriented Programming**: Organizing code around objects with data and behavior
 6. **Error Handling**: Managing and responding to exceptional conditions
 7. **Functional Programming**: Using functions as first-class citizens
 8. **Recursion**: Functions that call themselves to solve problems
 9. **Artificial Intelligence**: Systems that mimic human intelligence

 These concepts form the foundation of computer science and software development. By understanding these principles, you'll be better equipped to design efficient solutions to complex problems.

 ### References

 - Harvard CS50's Introduction to Computer Science: [https://www.edx.org/learn/computer-science/harvard-university-cs50-s-introduction-to-computer-science](https://www.edx.org/learn/computer-science/harvard-university-cs50-s-introduction-to-computer-science)
 - Swift Programming Language: [https://swift.org](https://swift.org)
 - Apple Developer Documentation: [https://developer.apple.com/documentation](https://developer.apple.com/documentation)
 */

 While implementing full AI systems is beyond this playground, we can demonstrate basic concepts used in AI.
 */

// Simple decision tree for classification
func classifyAnimal(hasFur: Bool, numberOfLegs: Int, canFly: Bool) -> String {
    if canFly {
        if hasFur {
            return "Bat"
        } else {
            return "Bird"
        }
    } else {
        if hasFur {
            if numberOfLegs == 4 {
                return "Dog/Cat"
            } else if numberOfLegs == 2 {
                return "Human"
            } else {
                return "Unknown Mammal"
            }
        } else {
            if numberOfLegs > 4 {
                return "Insect/Arthropod"
            } else if numberOfLegs == 4 {
                return "Reptile/Amphibian"
            } else if numberOfLegs == 0 {
                return "Snake/Fish"
            } else {
                return "Unknown Animal"
            }
        }
    }
}

print("\nSimple AI classification:")
print("Animal with fur, 4 legs, can't fly: \(classifyAnimal(hasFur: true, numberOfLegs: 4, canFly: false))")
print("Animal without fur, 2 legs, can fly: \(classifyAnimal(hasFur: false, numberOfLegs: 2, canFly: true))")
print("Animal with fur, 2 legs, can't fly: \(classifyAnimal(hasFur: true, numberOfLegs: 2, canFly: false))")

// Let's test the neural network function with different values
let testInputs = [0.5, 0.8, 0.2]
let testWeights = [0.4, -0.2, 0.6]
let testBias = -0.3

let testOutput = neuralNetworkSimulation(inputs: testInputs, weights: testWeights, bias: testBias)
print("\nNeural network simulation with different values: \(testOutput)")

/*:
 ## Concurrency

 Swift offers powerful concurrency features using GCD (Grand Central Dispatch) and the newer async/await pattern.
 */

import Foundation

print("\nConcurrency examples:")

// Using GCD (Grand Central Dispatch)
DispatchQueue.global().async {
    // Simulate a long-running task
    for i in 1...3 {
        Thread.sleep(forTimeInterval: 0.1)
        print("Background task: \(i)")
    }
}

// Main queue (UI updates would happen here)
for i in 1...3 {
    print("Main thread: \(i)")
}

// Wait a bit to see the results
Thread.sleep(forTimeInterval: 0.5)

// The playground environment makes it challenging to demonstrate async/await properly,
// but here's the syntax (requires Swift 5.5+):

// Uncomment if running Swift 5.5 or later
/*
func fetchData() async throws -> String {
    // Simulate network request
    try await Task.sleep(nanoseconds: 1_000_000_000)
    return "Fetched data"
}

func processResult() async {
    do {
        let result = try await fetchData()
        print("Result: \(result)")
    } catch {
        print("Error: \(error)")
    }
}

// This would be used to call the async function
Task {
    await processResult()
}
*/

print("This covers many foundational computer science concepts implemented in Swift.")

/*:
 ## Summary

 In this playground, we've explored many fundamental Computer Science concepts:

 - Binary representation and manipulation
 - Algorithms and their efficiency (O notation)
 - Data structures (arrays, linked lists, stacks, queues)
 - Sorting algorithms (bubble sort, selection sort, quick sort)
 - Memory management
 - Object-oriented programming principles
 - Recursion and dynamic programming
 - Database concepts
 - Basic artificial intelligence approaches

 These concepts form the foundation of computer science and software development, regardless of which programming language you use. Swift's modern syntax and features make it an excellent language for both learning these concepts and applying them in real-world applications.
 */

//: [Next](@next)
