<details id=contents>
<summary><strong>Table of Contents</strong></summary><ol>

<li><a href="./index.md">Introduction</a></li>
<li><a href="./01-Programming.md">Programming</a></li>
<li><a href="./02-Computer Architecture.md">Computer Architecture</a></li>
<li><a href="./03-Algorithms and Data Structures.md">Algorithms and Data Structures</a></li>
<li><a href="./04-Math for CS.md">Math for CS</a></li>
<li><a href="./05-Operating Systems.md">Operating Systems</a></li>
<li><a href="./06-Computer Networking.md">Computer Networking</a></li>
<li><a href="./07-Databases.md">Databases</a></li>
<li><a href="./08-Languages and Compilers.md">Languages and Compilers</a></li>
<li><a href="./09-Distributed Systems.md">Distributed Systems</a></li>
<li><a href="./10-Bonus Recap Lessons.md">Bonus Recap Lessons</a></li>

</ol></details>

---
# CS-00 Computer Science Introduction

This [course](https://teachyourselfcs.com/#programming) is designed for self-taught engineers who may have missed certain aspects of computer science fundamentals.

## What is Computer Science?

Computer Science is the study of information, focused on solving problems using computational thinking. A program can be simplified as:

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


```swift
// Binary representation
let binaryLiteral = 0b1010  // Binary literal for decimal 10
print("Binary 0b1010 = \(binaryLiteral) in decimal")

// Binary operations
let a = 0b1100  // 12 in decimal
let b = 0b1010  // 10 in decimal
let bitwiseAND = a & b      // Bitwise AND
let bitwiseOR = a | b       // Bitwise OR
let bitwiseXOR = a ^ b      // Bitwise XOR
let bitwiseNOT = ~a         // Bitwise NOT
let leftShift = a << 1      // Left shift
let rightShift = a >> 1     // Right shift

// Convert integer to binary string
func basicToBinaryString(_ value: Int, padLength: Int = 8) -> String {
   let binaryString = String(value, radix: 2)
   return String(repeating: "0", count: max(0, padLength - binaryString.count)) + binaryString
}
```

## Programming Languages

Programming languages provide human-readable code that compiles to machine code.

### Keywords

Keywords are special reserved words that have specific meanings in a programming language:

```swift
// Swift keywords example
let constantValue = 10      // 'let' for constants
var variableValue = 20      // 'var' for variables
if constantValue < variableValue {  // 'if' for conditions
   print("Variable is larger")
}
for i in 0..<5 {            // 'for' and 'in' for loops
   print("Count: \(i)")
}
func greet(name: String) {  // 'func' for functions
   print("Hello, \(name)!")
}
```

## Arrays

Arrays store ordered collections of values of the same type.

```swift
// Array operations
var numbers = [1, 2, 3, 4, 5]
numbers.append(6)           // Add element
print(numbers[0])           // Access first element
print(numbers.count)        // Array length
```

## Algorithms

Algorithms are step-by-step procedures for solving problems. Key characteristics:

1. **Correctness**: Solve the problem correctly for all valid inputs
2. **Efficiency**: Use computational resources efficiently

### Searching Algorithms

```swift
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
```

### Sorting Algorithms

```swift
/// Bubble sort - repeatedly steps through the list, compares and swaps adjacent elements
/// - Complexity: O(n²) - quadratic time
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
```

## Memory Management

Swift uses Automatic Reference Counting (ARC) to manage memory.

### Value Types vs Reference Types

- **Value Types** (structs, enums): Each instance keeps a unique copy of its data
- **Reference Types** (classes): Instances share a single copy of data

```swift
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
```

## Data Structures

Data structures organize and store data efficiently.

### Built-in Data Structures

- **Arrays**: Ordered collections
- **Dictionaries**: Key-value pairs
- **Sets**: Unordered collections of unique elements

### Linked Lists

A linear data structure where elements are stored in nodes containing data and a reference to the next node.

```swift
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
```

## Recursion

Recursion is a technique where a function calls itself to solve smaller instances of the same problem.

```swift
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
```

## Object-Oriented Programming

OOP is based on the concept of objects that contain data and code. Swift supports OOP principles with classes, inheritance, and polymorphism.

```swift
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
```

## Error Handling

Swift provides first-class support for throwing, catching, and manipulating recoverable errors.

```swift
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
```

## Binary System Enhancements

```swift
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
```

## Algorithmic Efficiency

### Big O Notation

Describes the performance of an algorithm:

- **O(1)** - Constant time: Performance is independent of input size
- **O(log n)** - Logarithmic time: Performance increases logarithmically (binary search)
- **O(n)** - Linear time: Performance increases linearly (linear search)
- **O(n log n)** - Linearithmic time: Common in efficient sorting algorithms (merge sort, quick sort)
- **O(n²)** - Quadratic time: Performance increases quadratically (bubble sort)
- **O(2^n)** - Exponential time: Performance doubles with each addition to input (naive Fibonacci)

```swift
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
           memo.append(memo[i-1] + memo[i-2])
       }
       return memo[n]
   }
   return fib(n)
}
```

## Artificial Intelligence

AI systems perform tasks that typically require human intelligence. Key concepts:

- **Machine Learning**: Systems that learn from data rather than being explicitly programmed
- **Neural Networks**: Computing systems inspired by biological neural networks
- **Natural Language Processing**: Enabling computers to understand human language

```swift
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
```

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

```swift

```

