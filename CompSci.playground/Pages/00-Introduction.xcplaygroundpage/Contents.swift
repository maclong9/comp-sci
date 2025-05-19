//: [Previous](@previous)
/*:
# CS-00 Computer Science Introduction

 This [course](https://teachyourselfcs.com/#programming) is designed for self-taught engineers who may have missed certain aspects of computer science fundamentals.

 ## What is Computer Science?

 Computer Science is the study of information, focused on solving problems using computational thinking. Computer Science helps us understand how to represent, process, and transform information in systematic ways.

 At its core, any computer program can be simplified as:

 **Input** → **Compute** → **Output**

 This model applies whether you're developing a simple calculator or complex artificial intelligence systems. The essence of computer science is understanding how to effectively move from input to output through efficient computation.

 ## The Binary System

 Computers use binary (0s and 1s) to represent data at the most fundamental level. This system forms the foundation of all computing.

 ### Key Binary Concepts:

 - A **bit** is a single binary digit (0 or 1) - the smallest unit of information
 - A **byte** is 8 bits (can represent values from 0 to 255)
 - In physical terms, 0s and 1s represent the states of electronic components (on/off)
 - Each position in a binary number represents a power of 2 (from right to left: 2⁰, 2¹, 2², etc.)

 ### Binary Counting:
   - `0000 = 0`  (0×2³ + 0×2² + 0×2¹ + 0×2⁰)
   - `0001 = 1`  (0×2³ + 0×2² + 0×2¹ + 1×2⁰)
   - `0010 = 2`  (0×2³ + 0×2² + 1×2¹ + 0×2⁰)
   - `0011 = 3`  (0×2³ + 0×2² + 1×2¹ + 1×2⁰)
   - `0100 = 4`  (0×2³ + 1×2² + 0×2¹ + 0×2⁰)
   - `0101 = 5`  (0×2³ + 1×2² + 0×2¹ + 1×2⁰)
   - `0110 = 6`  (0×2³ + 1×2² + 1×2¹ + 0×2⁰)
   - `0111 = 7`  (0×2³ + 1×2² + 1×2¹ + 1×2⁰)
   - `1000 = 8`  (1×2³ + 0×2² + 0×2¹ + 0×2⁰)
   - `1001 = 9`  (1×2³ + 0×2² + 0×2¹ + 1×2⁰)
   - `1010 = 10` (1×2³ + 0×2² + 1×2¹ + 0×2⁰)

 ### Character Representation:
 - Text characters are represented by numeric codes (e.g., ASCII represents 'A' as 65 or 01000001 in binary)
 - Unicode expands this to represent characters from all world languages using 1-4 bytes per character

 */

// Binary representation
let binaryLiteral = 0b1010  // Binary literal for decimal 10
print("Binary 0b1010 = \(binaryLiteral) in decimal")

// Binary operations
let a = 0b1100  // 12 in decimal
let b = 0b1010  // 10 in decimal
let bitwiseAND = a & b  // Bitwise AND
let bitwiseOR = a | b  // Bitwise OR
let bitwiseXOR = a ^ b  // Bitwise XOR
let bitwiseNOT = ~a  // Bitwise NOT
let leftShift = a << 1  // Left shift
let rightShift = a >> 1  // Right shift

// Convert integer to binary string
func basicToBinaryString(_ value: Int, padLength: Int = 8) -> String {
  let binaryString = String(value, radix: 2)
  return String(repeating: "0", count: max(0, padLength - binaryString.count)) + binaryString
}

/*:
 ## Programming Languages

 Programming languages provide human-readable code that ultimately translates to machine code (binary instructions).

 ### Language Levels

 - **Low-level languages** (like Assembly) provide minimal abstraction from machine code
 - **High-level languages** (like Swift, Python, C) offer greater abstraction and productivity
 - The **compilation process** typically involves preprocessing, compiling, assembling, and linking

 ### Keywords

 Keywords are special reserved words that have specific meanings in a programming language. They form the core vocabulary that structures the language:
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

 Arrays store ordered collections of values of the same type. They provide a way to group related data under a single variable name with indexed access.

 ### Key Characteristics:
 - Elements are stored in contiguous memory locations
 - Access to any element is O(1) (constant time) using its index
 - In many languages, arrays have fixed size once created
 - Index-based access typically starts at 0 (zero-indexed)
 */

// Array operations
var numbers = [1, 2, 3, 4, 5]
numbers.append(6)  // Add element
print(numbers[0])  // Access first element
print(numbers.count)  // Array length

/*:
 ## Algorithms

 Algorithms are step-by-step procedures for solving problems - the logical recipes that power computation. 

 ### Key Characteristics:

 1. **Correctness**: Solve the problem correctly for all valid inputs
 2. **Efficiency**: Use computational resources (time and space) efficiently
 3. **Finiteness**: Must terminate after a finite number of steps
 4. **Determinism**: Given the same input, should always produce the same output
 5. **Generality**: Should work for a class of problems, not just a specific instance

 ### Algorithm Design Techniques:
 - **Divide and Conquer**: Break problem into smaller sub-problems (binary search, merge sort)
 - **Greedy Algorithms**: Make locally optimal choices at each step
 - **Dynamic Programming**: Break down problems into overlapping subproblems
 - **Recursion**: Solve problems by solving smaller instances of the same problem

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

 Sorting algorithms arrange elements in a specific order (usually ascending or descending). Different algorithms offer different trade-offs in terms of efficiency, memory usage, and stability.
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

 Memory management involves allocating, using, and freeing computer memory resources.

 ### Memory Management Approaches:

 - **Manual Memory Management**: Programmers explicitly allocate and free memory (e.g., C's malloc/free)
 - **Automatic Reference Counting (ARC)**: Used by Swift, counts references to objects and deallocates when count reaches zero
 - **Garbage Collection**: Used by languages like Java, periodically identifies and frees unreferenced memory

 ### Value Types vs Reference Types

 - **Value Types** (structs, enums): Each instance keeps a unique copy of its data; copied when assigned to a new variable
 - **Reference Types** (classes): Instances share a single copy of data; references to the same instance are copied, not the data itself
 - **Memory Stack vs Heap**: Value types typically live on the stack (faster, automatically managed); reference types live on the heap (more flexible, requires management)
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
    return width * height
  }
}

/*:
 ## Data Structures

 Data structures organize and store data efficiently to facilitate various operations. The choice of data structure significantly impacts program performance.

 ### Built-in Data Structures

 - **Arrays**: Ordered collections with O(1) access by index, O(n) for insertions/deletions
 - **Dictionaries/Hash Tables**: Key-value pairs with O(1) average access, insertion, and deletion
 - **Sets**: Unordered collections of unique elements with efficient membership testing
 - **Stacks**: LIFO (Last In, First Out) collections suitable for tracking state
 - **Queues**: FIFO (First In, First Out) collections ideal for processing tasks in order

 ### Linked Lists

 A linear data structure where elements are stored in nodes containing data and a reference to the next node.
 
 #### Advantages:
 - Dynamic size (no need to pre-allocate memory)
 - Efficient insertions and deletions (O(1) if position is known)
 
 #### Disadvantages:
 - No random access (O(n) time to find arbitrary elements)
 - Extra memory for pointer storage
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

 Recursion is a technique where a function calls itself to solve smaller instances of the same problem. It provides an elegant solution for problems that can be broken down into similar sub-problems.

 ### Key Components of Recursive Solutions:
 
 1. **Base Case**: Condition where the function returns a value without making further recursive calls
 2. **Recursive Case**: Condition where the function calls itself with a simpler version of the problem
 
 ### Recursion vs. Iteration:
 
 - Recursion can lead to cleaner, more intuitive code for certain problems
 - Recursion may be less efficient due to function call overhead
 - Deep recursion can cause stack overflow errors
 - Any recursive solution can be rewritten iteratively (and vice versa)
 */

// Factorial using recursion
func recursiveFactorial(_ n: Int) -> Int {
  if n <= 1 {
    return 1
  }
  return n * recursiveFactorial(n - 1)
}

// Basic Fibonacci - inefficient recursive approach
func naiveRecursiveFibonacci(_ n: Int) -> Int {
  if n <= 1 {
    return n
  }
  return naiveRecursiveFibonacci(n - 1) + naiveRecursiveFibonacci(n - 2)
}

// Memoized Fibonacci - improved with caching
func memoizedFibonacci(_ n: Int) -> Int {
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

/*:
 ## Object-Oriented Programming

 Object-Oriented Programming (OOP) is a paradigm based on the concept of "objects" that contain data (attributes) and code (methods). It models real-world entities and their relationships.

 ### Core Principles of OOP:

 1. **Encapsulation**: Bundling data and methods that operate on that data into single units (objects)
 2. **Inheritance**: Creating new classes that inherit attributes and methods from existing classes
 3. **Polymorphism**: The ability to present the same interface for different underlying forms or data types
 4. **Abstraction**: Hiding complex implementation details and showing only the necessary features

 Swift supports these OOP principles through classes, protocols, inheritance, and extensions, while also embracing functional programming concepts.
 */

/// Base shape class
class Shape {
  var name: String

  init(name: String) {
    self.name = name
  }

  func area() -> Double {
    return 0.0
  }

  func description() -> String {
    return "A shape named \(name)"
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
    return Double.pi * radius * radius
  }

  override func description() -> String {
    return "A circle with radius \(radius)"
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
    return side * side
  }

  override func description() -> String {
    return "A square with side \(side)"
  }
}

/*:
 ## Error Handling

 Error handling provides mechanisms to detect, communicate, and recover from abnormal conditions in program execution.

 ### Common Error Handling Approaches:

 1. **Return Codes**: Functions return values indicating success/failure
 2. **Exceptions/Try-Catch**: Structured approach to separate normal code from error handling
 3. **Optionals**: Used in Swift to handle the absence of a value
 
 Swift provides first-class support for throwing, catching, and manipulating recoverable errors through:
 - `throws` keyword to mark functions that can throw errors
 - `do-catch` blocks to handle errors
 - `try`, `try?`, and `try!` expressions to handle potentially throwing code
 */

/// Custom error types
enum MathError: Error {
  case divisionByZero
  case negativeNumber(value: Int)
}

/// Square root function that throws an error for negative inputs
func squareRoot(of number: Int) throws -> Double {
  if number < 0 {
    throw MathError.negativeNumber(value: number)
  }
  return sqrt(Double(number))
}

/// Division function that throws an error for zero denominator
func divide(_ a: Int, by b: Int) throws -> Int {
  if b == 0 {
    throw MathError.divisionByZero
  }
  return a / b
}

/*:
 ## Binary System Enhancements
 */

/// Enhanced binary string conversion with padding
func enhancedToBinaryString(_ value: Int, padLength: Int = 8) -> String {
  return String(value, radix: 2).padLeft(toLength: padLength, withPad: "0")
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

 Big O notation describes the upper bound of an algorithm's time or space requirements as input size grows. It helps us compare algorithms independent of hardware or implementation details.

 #### Common Time Complexities (from fastest to slowest):

 - **O(1)** - Constant time: Performance is independent of input size
   - Examples: Array access by index, hash table insertions/lookups (average case)
 
 - **O(log n)** - Logarithmic time: Performance increases logarithmically
   - Examples: Binary search, balanced tree operations
   - Highly efficient for large datasets - doubling input size adds just one more step
 
 - **O(n)** - Linear time: Performance increases linearly with input size
   - Examples: Linear search, traversing an array once
 
 - **O(n log n)** - Linearithmic time: Combination of linear and logarithmic behaviors
   - Examples: Efficient sorting algorithms (merge sort, quick sort, heap sort)
   - Practically the best possible complexity for comparison-based sorting
 
 - **O(n²)** - Quadratic time: Performance increases quadratically
   - Examples: Bubble sort, insertion sort, nested loops iterating over the same collection
 
 - **O(2^n)** - Exponential time: Performance doubles with each addition to input
   - Examples: Naive recursive Fibonacci, trying all subsets, brute-force solutions
   - Generally impractical for inputs larger than ~20-30 elements

 ### Other Asymptotic Notations:
 - **Ω (Omega)**: Lower bound - best case scenario
 - **Θ (Theta)**: Tight bound - when upper and lower bounds match
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

 AI systems perform tasks that typically require human intelligence. It's a broad field encompassing many approaches and techniques.

 ### Key AI Concepts:

 - **Machine Learning**: Systems that learn patterns from data rather than being explicitly programmed
   - **Supervised Learning**: Training on labeled data (classification, regression)
   - **Unsupervised Learning**: Finding patterns in unlabeled data (clustering, dimensionality reduction)
   - **Reinforcement Learning**: Learning through trial and error with rewards/penalties

 - **Neural Networks**: Computing systems inspired by biological neural networks
   - Building blocks of deep learning
   - Composed of layers of interconnected nodes (neurons)
   - Can learn complex patterns from large amounts of data

 - **Natural Language Processing**: Enabling computers to understand and generate human language
   - Applications: translation, sentiment analysis, chatbots, text summarization

 - **Computer Vision**: Systems that can interpret and analyze visual information
   - Image classification, object detection, facial recognition

 - **Prompt Engineering**: Designing effective inputs to guide AI models toward desired outputs
   - Especially important for large language models
 */

/// Simulates a single neuron in a neural network
func neuralNetworkSimulation(inputs: [Double], weights: [Double], bias: Double) -> Double {
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

/*:
 ## Key Concepts Summary

 1. **Binary System**: The foundation of computing, representing data as 0s and 1s
 2. **Data Structures**: Ways to organize and store data (arrays, linked lists, dictionaries, trees, graphs)
 3. **Algorithms**: Procedures for solving problems (searching, sorting, graph algorithms)
 4. **Algorithmic Efficiency**: Measuring performance using Big O notation and understanding trade-offs
 5. **Memory Management**: Allocating and freeing resources efficiently (stack vs heap, reference counting)
 6. **Object-Oriented Programming**: Organizing code around objects with data and behavior
 7. **Error Handling**: Managing exceptional conditions through various mechanisms
 8. **Functional Programming**: Using functions as first-class citizens, avoiding state and mutable data
 9. **Recursion**: Functions that call themselves to solve problems by breaking them down
 10. **Artificial Intelligence**: Systems that mimic human intelligence through various approaches

 ### Additional Important Concepts:
 
 - **Compiling & Interpreting**: Translating human-readable code to machine instructions
 - **Concurrency & Parallelism**: Handling multiple tasks simultaneously
 - **Database Systems**: Storing and retrieving data efficiently
 - **Networking**: Communication between computer systems
 - **Security**: Protecting data and systems from unauthorized access

 Understanding these concepts provides a foundation for solving complex problems efficiently and building robust software systems.
 */
//: [Next](@next)
