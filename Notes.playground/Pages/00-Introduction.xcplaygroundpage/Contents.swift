//: [Previous](@previous)
/*:
# CS-00 Computer Science Introduction

 This [course](https://teachyourselfcs.com/#programming) is designed for self-taught engineers who may have missed certain aspects of computer science fundamentals. The below are some simple shorthand notes taken from [Harvard CS50 - Introduction to Computer Science](https://pll.harvard.edu/course/cs50-introduction-computer-science)

 ## What is Computer Science?

 Computer Science is the study of information, focused on solving problems using computational thinking.
 A program can be simplified as:

 **Input** → **Compute** → **Output**

 ## The Binary System

 Computers use binary (0s and 1s) to represent data. Key concepts:

 - A **bit** is a single binary digit (0 or 1)
 - A **byte** is 8 bits (can represent values from 0 to 255)
 - Binary counting:
    - `0000 = 0`
    - `0001 = 1`
    - `0010 = 2`
    - `0011 = 3`
    - `0100 = 4`
    - `0101 = 5`
    - `0110 = 6`
    - `0111 = 7`
    - `1000 = 8`
    - `1001 = 9`
    - `1010 = 10`
 */

/// Importing libraries is a simple way to add previously written code
/// to your program, this allows you to either write your own libraries
/// that you can then use in other locations or utilise libraries
/// written by other pogrammers to save you time working on a
/// full reimplimentation of this process.
import Foundation

// Binary representation
let binaryLiteral = 0b1010  // Binary literal for decimal 10
print("Binary 0b1010 = \(binaryLiteral) in decimal")

// Convert integer to binary string
func basicToBinaryString(_ value: Int, padLength: Int = 8) -> String {
  let binaryString = String(value, radix: 2)
  return String(repeating: "0", count: max(0, padLength - binaryString.count))
    + binaryString
}

/*:
 ## Programming Languages

 Programming languages provide human-readable code that compiles to machine code.

 ### Keywords

 Keywords are special reserved words that have specific meanings in a programming language:
 */

// Swift keywords example
let constantValue = 10  // 'let' for constants
var variableValue = 20  // 'var' for variables
if constantValue < variableValue {  // 'if' for conditions
  print("Variable is larger")
}
for i in 0..<5 {  // 'for' and 'in' for loops
  print("Count: \(i)")
}
func greet(name: String) {  // 'func' for functions
  print("Hello, \(name)!")
}

/*:
 ## Arrays

 Arrays store ordered collections of values of the same type.
 */

// Array operations
var numbers = [1, 2, 3, 4, 5]
numbers.append(6)  // Add element
print(numbers[0])  // Access first element
print(numbers.count)  // Array length

/*:
 ## Algorithms

 Algorithms are step-by-step procedures for solving problems. Key characteristics:

 1. **Correctness**: Solve the problem correctly for all valid inputs
 2. **Efficiency**: Use computational resources efficiently

 ### Searching Algorithms
 */

/// Linear search - examines each element sequentially
/// - Complexity: O(n) - linear time
func linearSearch<T: Equatable>(_ array: [T], _ item: T) -> Int? {
  for (index, element) in array.enumerated() {
    if element == item {
      return index
    }
  }
  return nil
}

/// Binary search - for sorted arrays, divides search space in half each time
/// - Complexity: O(log n) - logarithmic time
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
 */

/// Bubble sort - repeatedly steps through the list, compares and swaps adjacent elements
/// - Complexity: O(n²) - quadratic time
func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
  var result = array
  let n = result.count
  for i in 0..<n {
    for j in 0..<n - i - 1 {
      if result[j] > result[j + 1] {
        result.swapAt(j, j + 1)
      }
    }
  }
  return result
}

/*:
 ## Memory Management

 Swift uses Automatic Reference Counting (ARC) to manage memory.

 ### Value Types vs Reference Types

 - **Value Types** (structs, enums): Each instance keeps a unique copy of its data
 - **Reference Types** (classes): Instances share a single copy of data

 */

// Value type example
struct Point {
  var x: Int
  var y: Int
}

// Reference type example
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
    width * height
  }
}

/*:

 ### Computer Memory Systems

 Computer memory is organized in a hierarchical structure:

 - **RAM (Random Access Memory)**: Temporary, fast storage while programs run
 - **ROM (Read-Only Memory)**: Permanent, non-volatile storage for essential instructions
 - **Cache**: Ultra-fast memory that stores frequently accessed data
 - **Registers**: Extremely fast memory inside the CPU

 #### Memory Addressing

 - Every byte in memory has a unique **address** (often written in hexadecimal)
 - A **pointer** is a variable that stores a memory address
 - Memory is typically addressed sequentially (e.g., address 0x123 is followed by 0x124)

 #### Memory Allocation

 Memory is divided into different regions:

 - **Stack**: Fast, automatically managed memory for local variables and function calls
 - **Heap**: Dynamically allocated memory managed by the programmer (in languages without garbage collection)
 - **Static/Global**: Memory for global variables and static data

 #### Common Memory Issues

 - **Memory Leak**: Memory that's allocated but never freed
 - **Buffer Overflow**: Writing beyond the allocated memory bounds
 - **Segmentation Fault**: Attempting to access memory the program doesn't have permission to use
 - **Dangling Pointer**: Pointer that references memory that has been freed

 #### Color Representation in Memory

 - Colors on screens are represented using pixels
 - Common color models include:
 - **RGB**: Values from 0-255 for Red, Green, and Blue components
 - **Hexadecimal**: Values like #FF0000 (red) where each pair represents R, G, B

 ## Low-Level Memory in Swift

 Swift lets us work close to the metal with `UnsafePointer` types and bitwise operations.
 */

/// Binary operations
///
/// Binary is represented with `0b****` in Swift.
/// You can use the bitwise AND, OR, XOR, and NOT operations
/// to manipulate individual bits of binary numbers. These are
/// used for low-level control and performance optimization.
///
/// Common applications include:
///   - Bit manipulation
///   - Flags and permissions
///   - Cryptography
///   - Graphics & networking
let a = 0b1100  // 12 in decimal
let b = 0b1010  // 10 in decimal

/// These operations step through each individual bit of a binary digit
/// So in a bitwise & if both a[1] and b[1] are not both `1` then the result is `c[1] = 0`
///
/// `&` performs a bitwise AND (1 if both bits are 1)
let bitwiseAND = a & b

/// `|` performs a bitwise OR (1 if either bit is 1)
let bitwiseOR = a | b

/// `^` performs a bitwise XOR (1 if bits are different)
let bitwiseXOR = a ^ b

/// `~` inverts each bit (bitwise NOT)
let bitwiseNOT = ~a

/// `<<` shifts bits to the left (multiplies by 2 per shift)
let leftShift = a << 1

/// `>>` shifts bits to the right (divides by 2 per shift)
let rightShift = a >> 1

/// Unsafe Pointer Example
///
/// Unsafe pointers allow direct access to memory locations.
/// This bypasses Swift's memory safety system and ARC.
/// Useful for interop with C or for performance-critical code.

// Allocate memory for one integer
let pointer = UnsafeMutablePointer<Int>.allocate(capacity: 1)

// Write a value to the allocated memory
pointer.pointee = 42

// Read the value from memory
print("Value at pointer: \(pointer.pointee)")

// Print the memory address (pointer itself)
print("Pointer address: \(pointer)")

// Free the allocated memory (you must do this manually)
pointer.deallocate()

/// Mixing Bitwise and Unsafe Operations
///
/// This demonstrates how to allocate a buffer in memory,
/// fill it using bitwise shifts, and then read it out.
/// It combines low-level memory and binary manipulation.

// Allocate a buffer for 4 bytes
let size = 4
let buffer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: size)

// Fill the buffer with values using a bitwise left shift
// i << 2 means: multiply i by 4 (2^2)
for i in 0..<size {
  buffer[i] = UInt8(i << 2)
}

// Read and print each byte in binary form
print("Buffer contents:")
for byte in buffer {
  print(String(byte, radix: 2))  // Print as binary string
}

/// Deallocate the memory buffer
buffer.deallocate()

/*:
 ## Data Structures

 Data structures organize and store data efficiently.

 ### Built-in Data Structures

 - **Arrays**: Ordered collections
 - **Dictionaries**: Key-value pairs
 - **Sets**: Unordered collections of unique element, faster than arrays
*/

let array = [0, 1, 2, 3]
let dict: [String: Any] = ["Name": "Mac", "Age": 29]
let set: Set<Int> = [0, 1, 2, 3]

/*:
 ### Linked Lists

 A linear data structure where elements are stored in nodes containing data and a reference to the next node.
 */

/// Node in a linked list
class LinkedListNode<T> {
  var value: T
  var next: LinkedListNode<T>?

  init(value: T) {
    self.value = value
  }
}

/// Singly linked list implementation
class LinkedList<T> {
  var head: LinkedListNode<T>?

  /// Adds a new value to the end of the list
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
 ## Recursion

 Recursion is a technique where a function calls itself to solve smaller instances of the same problem.
 */

// Factorial using recursion
func recursiveFactorial(_ n: Int) -> Int {
  if n <= 1 {
    return 1
  }
  return n * recursiveFactorial(n - 1)
}

/// Basic Fibonacci - inefficient recursive approach
///
/// - Complexity: O(2^n)
func naiveRecursiveFibonacci(_ n: Int) -> Int {
  if n <= 1 {
    return n
  }
  return naiveRecursiveFibonacci(n - 1) + naiveRecursiveFibonacci(n - 2)
}

/// Memoized Fibonacci - improved with caching
///
/// **Memoization** is a technique used to speed up recursive functions
/// it works by caching previously computed results.
/// Instead of recalculating a value each time it's needed.
///
/// - Complexity: O(n)
func memoizedFibonacci(_ n: Int) -> Int {
  var memo: [Int: Int] = [0: 0, 1: 1]

  func fib(_ n: Int) -> Int {
    if let result = memo[n] {  // If already calculated return
      return result
    }

    // Otherwise calculate and store
    memo[n] = fib(n - 1) + fib(n - 2)
    return memo[n]!
  }

  return fib(n)  // Recurse
}

let _ = memoizedFibonacci(16)

/*:
 ## Object-Oriented Programming

 OOP is based on the concept of objects that contain data and code. Swift supports OOP principles with classes, inheritance, and polymorphism.
 */

/// Base shape class
class Shape {
  var name: String

  init(name: String) {
    self.name = name
  }

  func area() -> Double {
    0.0
  }

  func description() -> String {
    "A shape named \(name)"
  }
}

/// Circle inherits from Shape
class Circle: Shape {
  var radius: Double

  init(radius: Double) {
    self.radius = radius
    super.init(name: "Circle")
  }

  override func area() -> Double {
    Double.pi * radius * radius
  }

  override func description() -> String {
    "A circle with radius \(radius)"
  }
}

/// Square inherits from Shape
class Square: Shape {
  var side: Double

  init(side: Double) {
    self.side = side
    super.init(name: "Square")
  }

  override func area() -> Double {
    side * side
  }

  override func description() -> String {
    "A square with side \(side)"
  }
}

/*:
 ## Error Handling

 Swift provides first-class support for throwing, catching, and manipulating recoverable errors.
 */

/// Custom error types
enum MathError: LocalizedError {
  case divisionByZero
  case negativeNumber(value: Int)

  var errorDescription: String? {
    switch self {
    case .divisionByZero:
      return "Cannot divide by zero"
    case .negativeNumber(let value):
      return "Cannot take the square root of a negative number: \(value)"
    }
  }
}

/// Square root function that throws an error for negative inputs
func squareRoot(of number: Int) throws -> Double {
  if number < 0 {
    throw MathError.negativeNumber(value: number)
  }
  return sqrt(Double(number))
}

// Succsessful
let _ = try squareRoot(of: 16)

// Negative Number Error
do {
  let _ = try squareRoot(of: -4)
} catch {
  print(error.localizedDescription)
}

/// Division function that throws an error for zero denominator
func divide(_ a: Int, by b: Int) throws -> Int {
  if b == 0 {
    throw MathError.divisionByZero
  }
  return a / b
}

// Divide by Zero Error
do {
  let _ = try divide(5, by: 0)
} catch {
  print(error.localizedDescription)
}

/*:
 ## Binary System Enhancements
 */

/// Enhanced binary string conversion with padding
func enhancedToBinaryString(_ value: Int, padLength: Int = 8) -> String {
  String(value, radix: 2).padLeft(toLength: padLength, withPad: "0")
}

// String extension for padding
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
 ## Algorithmic Efficiency

 ### Big O Notation

 Describes the performance of an algorithm:

 - **O(1)** - Constant time: Performance is independent of input size
 - **O(log n)** - Logarithmic time: Performance increases logarithmically (binary search)
 - **O(n)** - Linear time: Performance increases linearly (linear search)
 - **O(n log n)** - Linearithmic time: Common in efficient sorting algorithms (merge sort, quick sort)
 - **O(n²)** - Quadratic time: Performance increases quadratically (bubble sort)
 - **O(2^n)** - Exponential time: Performance doubles with each addition to input (naive Fibonacci)
 */

// Iterative factorial implementation
func iterativeFactorial(_ n: Int) -> Int {
  if n <= 1 { return 1 }
  return n * iterativeFactorial(n - 1)
}

// Improved recursive Fibonacci implementation
func recursiveFibonacci(_ n: Int) -> Int {
  if n <= 0 { return 0 }
  if n == 1 { return 1 }
  return recursiveFibonacci(n - 1) + recursiveFibonacci(n - 2)
}

// Iterative Fibonacci using dynamic programming
func iterativeFibonacci(_ n: Int) -> Int {
  func fib(_ n: Int) -> Int {
    var memo = [0, 1]
    if n <= 1 { return n }
    for i in 2...n {
      memo.append(memo[i - 1] + memo[i - 2])
    }
    return memo[n]
  }
  return fib(n)
}

/*:
 ## Artificial Intelligence

 AI systems perform tasks that typically require human intelligence. Key concepts:

 - **Machine Learning**: Systems that learn from data rather than being explicitly programmed
 - **Neural Networks**: Computing systems inspired by biological neural networks
 - **Natural Language Processing**: Enabling computers to understand human language
 */

/// Simulates a single neuron in a neural network
func neuralNetworkSimulation(
  inputs: [Double],
  weights: [Double],
  bias: Double
)
  -> Double
{
  // Calculate weighted sum
  var weightedSum = bias
  for i in 0..<min(inputs.count, weights.count) {
    weightedSum += inputs[i] * weights[i]
  }

  // Apply sigmoid activation function
  return 1.0 / (1.0 + exp(-weightedSum))
}

/// Rule-based classification system
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
        return "Flying insect"
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

let _ = classifyAnimal(hasFur: true, numberOfLegs: 2, canFly: false)

/*:
 ## Key Concepts Summary

 1. **Binary System**: The foundation of computing, representing data as 0s and 1s
 2. **Data Structures**: Ways to organize and store data (arrays, linked lists, dictionaries, sets)
 3. **Algorithms**: Procedures for solving problems (searching, sorting)
 4. **Algorithmic Efficiency**: Measuring performance using Big O notation
 5. **Object-Oriented Programming**: Organizing code around objects with data and behavior
 6. **Error Handling**: Managing exceptional conditions
 7. **Functional Programming**: Using functions as first-class citizens
 8. **Recursion**: Functions that call themselves to solve problems
 9. **Artificial Intelligence**: Systems that mimic human intelligence

 Understanding these concepts provides a foundation for solving complex problems efficiently.
 */
//: [Next](@next)
