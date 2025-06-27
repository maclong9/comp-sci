//: [Previous](@previous)
/*:
 # SICP Chapter 2: Building Abstractions with Data
 
 This chapter explores how to build data abstractions that allow us to manipulate compound data objects. We'll translate SICP's data-oriented programming concepts into Swift.
 
 ## 2.1 Introduction to Data Abstraction
 
 **Data abstraction** is a methodology that enables us to isolate how a compound data object is used from the details of how it is constructed.
 
 The basic idea is to structure programs that use compound data objects so that they operate on "abstract data" through:
 - **Constructors**: Create data objects  
 - **Selectors**: Access parts of data objects
 
 ### 2.1.1 Example: Arithmetic Operations for Rational Numbers
 
 Let's implement rational number arithmetic in Swift:
 */

import Foundation

// Basic rational number representation using a struct (constructor)
struct RationalNumber {
    let numerator: Int
    let denominator: Int
    
    // Constructor with automatic reduction
    init(_ n: Int, _ d: Int) {
        let g = gcd(abs(n), abs(d))
        if d < 0 {
            self.numerator = -n / g
            self.denominator = -d / g
        } else {
            self.numerator = n / g
            self.denominator = d / g
        }
    }
}

/// Computes the greatest common divisor of two integers using Euclid's algorithm.
///
/// This implementation uses the recursive form of Euclid's algorithm:
/// gcd(a, b) = gcd(b, a mod b) when b ≠ 0, and gcd(a, 0) = a.
///
/// - Parameters:
///   - a: The first integer.
///   - b: The second integer.
/// - Returns: The greatest common divisor of `a` and `b`.
///
/// - Complexity: O(log min(a, b)) time and space.
func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    } else {
        return gcd(b, a % b)
    }
}

// Selectors (accessing parts of the data)
extension RationalNumber {
    var numer: Int { return numerator }
    var denom: Int { return denominator }
}

// Arithmetic operations using constructors and selectors
extension RationalNumber {
    static func + (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        return RationalNumber(
            lhs.numer * rhs.denom + rhs.numer * lhs.denom,
            lhs.denom * rhs.denom
        )
    }
    
    static func - (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        return RationalNumber(
            lhs.numer * rhs.denom - rhs.numer * lhs.denom,
            lhs.denom * rhs.denom
        )
    }
    
    static func * (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        return RationalNumber(
            lhs.numer * rhs.numer,
            lhs.denom * rhs.denom
        )
    }
    
    static func / (lhs: RationalNumber, rhs: RationalNumber) -> RationalNumber {
        return RationalNumber(
            lhs.numer * rhs.denom,
            lhs.denom * rhs.numer
        )
    }
    
    static func == (lhs: RationalNumber, rhs: RationalNumber) -> Bool {
        return lhs.numer * rhs.denom == rhs.numer * lhs.denom
    }
}

// Make rational numbers printable
extension RationalNumber: CustomStringConvertible {
    var description: String {
        return "\(numerator)/\(denominator)"
    }
}

// Testing rational number operations
let oneHalf = RationalNumber(1, 2)
let oneThird = RationalNumber(1, 3)
let sum = oneHalf + oneThird
print("1/2 + 1/3 = \(sum)")

/*:
 ### 2.1.2 Abstraction Barriers
 
 The rational number implementation creates **abstraction barriers** that separate different levels of the system:
 
 1. **Usage level**: Programs that use rational numbers
 2. **Rational number level**: add-rat, sub-rat, etc.
 3. **Representation level**: numerator, denominator selectors
 4. **Implementation level**: How pairs are actually implemented
 
 ### 2.1.3 What Is Meant by Data?
 
 Data is defined by the **interface** provided by constructors and selectors, not by the specific implementation.
 */

// Alternative implementation using tuples (demonstrates abstraction)
typealias RationalTuple = (Int, Int)

/// Creates a rational number represented as a tuple with reduced form.
///
/// This constructor automatically reduces the rational number to its simplest form
/// by dividing both numerator and denominator by their greatest common divisor.
///
/// - Parameters:
///   - n: The numerator of the rational number.
///   - d: The denominator of the rational number.
/// - Returns: A tuple representing the rational number in reduced form.
func makeRat(_ n: Int, _ d: Int) -> RationalTuple {
    let g = gcd(abs(n), abs(d))
    return (n / g, d / g)
}

/// Extracts the numerator from a rational number tuple.
///
/// This is a selector function that provides access to the numerator component
/// of a rational number without exposing the underlying representation.
///
/// - Parameter r: The rational number tuple.
/// - Returns: The numerator of the rational number.
func numer(_ r: RationalTuple) -> Int {
    return r.0
}

/// Extracts the denominator from a rational number tuple.
///
/// This is a selector function that provides access to the denominator component
/// of a rational number without exposing the underlying representation.
///
/// - Parameter r: The rational number tuple.
/// - Returns: The denominator of the rational number.
func denom(_ r: RationalTuple) -> Int {
    return r.1
}

/*:
 ### 2.1.4 Extended Exercise: Interval Arithmetic
 
 Implementing interval arithmetic demonstrates data abstraction principles:
 */

struct Interval {
    let lower: Double
    let upper: Double
    
    init(_ a: Double, _ b: Double) {
        self.lower = min(a, b)
        self.upper = max(a, b)
    }
}

extension Interval {
    static func + (lhs: Interval, rhs: Interval) -> Interval {
        return Interval(lhs.lower + rhs.lower, lhs.upper + rhs.upper)
    }
    
    static func * (lhs: Interval, rhs: Interval) -> Interval {
        let p1 = lhs.lower * rhs.lower
        let p2 = lhs.lower * rhs.upper
        let p3 = lhs.upper * rhs.lower
        let p4 = lhs.upper * rhs.upper
        return Interval(min(p1, p2, p3, p4), max(p1, p2, p3, p4))
    }
    
    static func / (lhs: Interval, rhs: Interval) -> Interval {
        return lhs * Interval(1.0 / rhs.upper, 1.0 / rhs.lower)
    }
}

extension Interval: CustomStringConvertible {
    var description: String {
        return "[\(lower), \(upper)]"
    }
}

/*:
 ## 2.2 Hierarchical Data and the Closure Property
 
 The **closure property** means that operations for combining data objects can be used to create hierarchical structures.
 
 ### 2.2.1 Representing Sequences
 
 In Swift, we have native support for sequences through Arrays, but let's implement a linked list to understand the principles:
 */

// Swift enum-based linked list (similar to Scheme's cons cells)
indirect enum List<T> {
    case empty
    case cons(T, List<T>)
    
    // Constructor function
    static func cons(_ head: T, _ tail: List<T>) -> List<T> {
        return .cons(head, tail)
    }
    
    // Selectors
    func car() -> T? {
        switch self {
        case .empty:
            return nil
        case .cons(let head, _):
            return head
        }
    }
    
    func cdr() -> List<T>? {
        switch self {
        case .empty:
            return nil
        case .cons(_, let tail):
            return tail
        }
    }
    
    // Check if list is empty
    func isEmpty() -> Bool {
        switch self {
        case .empty:
            return true
        case .cons:
            return false
        }
    }
}

// List processing functions
extension List {
    func length() -> Int {
        switch self {
        case .empty:
            return 0
        case .cons(_, let tail):
            return 1 + tail.length()
        }
    }
    
    func append(_ other: List<T>) -> List<T> {
        switch self {
        case .empty:
            return other
        case .cons(let head, let tail):
            return List.cons(head, tail.append(other))
        }
    }
    
    // Get element at index
    func listRef(_ n: Int) -> T? {
        switch self {
        case .empty:
            return nil
        case .cons(let head, let tail):
            if n == 0 {
                return head
            } else {
                return tail.listRef(n - 1)
            }
        }
    }
}

// Create a list: (1 2 3 4)
let oneToFour = List.cons(1, List.cons(2, List.cons(3, List.cons(4, List.empty))))

/*:
 ### 2.2.2 Hierarchical Structures
 
 Trees can be represented as lists of lists:
 */

// Binary tree structure
indirect enum BinaryTree<T> {
    case leaf(T)
    case node(BinaryTree<T>, BinaryTree<T>)
    
    // Count leaves in the tree
    func countLeaves() -> Int {
        switch self {
        case .leaf:
            return 1
        case .node(let left, let right):
            return left.countLeaves() + right.countLeaves()
        }
    }
    
    // Scale all leaf values by a factor
    func scaleTree<U: Numeric>(_ factor: U) -> BinaryTree<U> where T == U {
        switch self {
        case .leaf(let value):
            return .leaf(value * factor)
        case .node(let left, let right):
            return .node(left.scaleTree(factor), right.scaleTree(factor))
        }
    }
}

// Example tree: ((1 2) (3 4))
let exampleTree = BinaryTree.node(
    BinaryTree.node(BinaryTree.leaf(1), BinaryTree.leaf(2)),
    BinaryTree.node(BinaryTree.leaf(3), BinaryTree.leaf(4))
)

print("Tree has \(exampleTree.countLeaves()) leaves")

/*:
 ### 2.2.3 Sequences as Conventional Interfaces
 
 The key to organizing programs is to use **conventional interfaces** that allow us to combine modules in mix-and-match ways.
 
 #### Sequence Operations
 
 Swift's functional programming features align well with SICP's sequence operations:
 */

// Generic sequence operations
extension Array {
    // Map operation (transform each element)
    func mapSICP<U>(_ transform: (Element) -> U) -> [U] {
        return self.map(transform)
    }
    
    // Filter operation (select elements matching predicate)
    func filterSICP(_ predicate: (Element) -> Bool) -> [Element] {
        return self.filter(predicate)
    }
    
    // Accumulate operation (fold/reduce)
    func accumulate<Result>(_ initial: Result, _ combine: (Element, Result) -> Result) -> Result {
        return self.reduce(initial) { result, element in
            combine(element, result)
        }
    }
}

/// Computes the sum of squares of odd numbers in a sequence.
///
/// This function demonstrates the power of sequence operations by chaining
/// filter, map, and reduce operations to solve a complex problem elegantly.
///
/// - Parameter sequence: An array of integers to process.
/// - Returns: The sum of squares of all odd numbers in the sequence.
///
/// - Example: `sumOddSquares([1, 2, 3, 4, 5])` returns `1² + 3² + 5² = 35`
func sumOddSquares(_ sequence: [Int]) -> Int {
    return sequence
        .filterSICP { $0 % 2 == 1 }  // Filter odd numbers
        .mapSICP { $0 * $0 }         // Square them
        .accumulate(0, +)            // Sum the results
}

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print("Sum of odd squares: \(sumOddSquares(numbers))")

/// Generates all even Fibonacci numbers less than a given limit.
///
/// This function combines Fibonacci sequence generation with filtering
/// to extract only the even values below the specified threshold.
///
/// - Parameter n: The upper limit (exclusive) for Fibonacci numbers.
/// - Returns: An array containing all even Fibonacci numbers less than `n`.
///
/// - Example: `evenFibs(100)` returns `[0, 2, 8, 34]`
func evenFibs(_ n: Int) -> [Int] {
    func fibSequence(_ max: Int) -> [Int] {
        var fibs = [0, 1]
        while true {
            let next = fibs[fibs.count - 1] + fibs[fibs.count - 2]
            if next >= max { break }
            fibs.append(next)
        }
        return fibs
    }
    
    return fibSequence(n)
        .filterSICP { $0 % 2 == 0 }
}

print("Even Fibonacci numbers less than 100: \(evenFibs(100))")

/*:
 #### Signal-Flow Diagrams
 
 We can think of sequence processing as signal flow through a series of transformations:
 */

/// Demonstrates nested mappings to find pairs where sum is prime.
///
/// This function generates all pairs (i, j) where 1 ≤ j < i ≤ 5
/// and i + j is prime, illustrating the power of nested sequence operations.
///
/// - Returns: An array of pairs [i, j] where i + j is prime.
func nestedMappings() -> [[Int]] {
    let n = 5
    return (1...n).flatMap { i in
        (1..<i).compactMap { j in
            if isPrime(i + j) {
                return [i, j]
            }
            return nil
        }
    }
}

/// Determines whether a given integer is prime.
///
/// Uses trial division up to the square root of n for efficiency.
/// Handles edge cases for numbers less than 2 and even numbers.
///
/// - Parameter n: The integer to test for primality.
/// - Returns: `true` if `n` is prime, `false` otherwise.
///
/// - Complexity: O(√n) time.
func isPrime(_ n: Int) -> Bool {
    if n < 2 { return false }
    if n == 2 { return true }
    if n % 2 == 0 { return false }
    
    let limit = Int(sqrt(Double(n)))
    for i in stride(from: 3, through: limit, by: 2) {
        if n % i == 0 { return false }
    }
    return true
}

/*:
 ### 2.2.4 Example: A Picture Language
 
 The picture language demonstrates how to build a complex system using data abstraction. In Swift, we can represent this using graphics frameworks:
 */

// Abstract representation of a painter
protocol Painter {
    func paint(in frame: CGRect)
}

// Frame transformation
struct FrameTransform {
    let origin: CGPoint
    let edge1: CGVector
    let edge2: CGVector
    
    func transform(_ point: CGPoint) -> CGPoint {
        return CGPoint(
            x: origin.x + point.x * edge1.dx + point.y * edge2.dx,
            y: origin.y + point.x * edge1.dy + point.y * edge2.dy
        )
    }
}

// Painter combinators
/// Combines two painters side by side horizontally.
///
/// Creates a new painter that draws the first painter in the left half
/// of the frame and the second painter in the right half.
///
/// - Parameters:
///   - painter1: The painter to draw on the left side.
///   - painter2: The painter to draw on the right side.
/// - Returns: A new painter that combines both input painters horizontally.
func beside(_ painter1: Painter, _ painter2: Painter) -> Painter {
    return CompositePainter { frame in
        let leftFrame = CGRect(x: frame.minX, y: frame.minY, 
                              width: frame.width / 2, height: frame.height)
        let rightFrame = CGRect(x: frame.midX, y: frame.minY, 
                               width: frame.width / 2, height: frame.height)
        painter1.paint(in: leftFrame)
        painter2.paint(in: rightFrame)
    }
}

/// Combines two painters vertically, one above the other.
///
/// Creates a new painter that draws the first painter in the top half
/// of the frame and the second painter in the bottom half.
///
/// - Parameters:
///   - painter1: The painter to draw on the top.
///   - painter2: The painter to draw on the bottom.
/// - Returns: A new painter that combines both input painters vertically.
func above(_ painter1: Painter, _ painter2: Painter) -> Painter {
    return CompositePainter { frame in
        let topFrame = CGRect(x: frame.minX, y: frame.midY, 
                             width: frame.width, height: frame.height / 2)
        let bottomFrame = CGRect(x: frame.minX, y: frame.minY, 
                                width: frame.width, height: frame.height / 2)
        painter1.paint(in: topFrame)
        painter2.paint(in: bottomFrame)
    }
}

struct CompositePainter: Painter {
    let paintFunction: (CGRect) -> Void
    
    func paint(in frame: CGRect) {
        paintFunction(frame)
    }
}

/*:
 ## 2.3 Symbolic Data
 
 Working with symbolic expressions requires the ability to manipulate symbols as data.
 
 ### 2.3.1 Quotation
 
 In Swift, we can represent symbolic data using enums or strings:
 */

// Symbolic expression representation
indirect enum SymbolicExpression {
    case symbol(String)
    case number(Double)
    case list([SymbolicExpression])
    
    // Check if two expressions are equal
    static func == (lhs: SymbolicExpression, rhs: SymbolicExpression) -> Bool {
        switch (lhs, rhs) {
        case (.symbol(let a), .symbol(let b)):
            return a == b
        case (.number(let a), .number(let b)):
            return a == b
        case (.list(let a), .list(let b)):
            return a.count == b.count && zip(a, b).allSatisfy(==)
        default:
            return false
        }
    }
}

/*:
 ### 2.3.2 Example: Symbolic Differentiation
 
 Implementing symbolic differentiation demonstrates how to work with symbolic data:
 */

// Algebraic expression representation
indirect enum AlgebraicExpression {
    case variable(String)
    case constant(Double)
    case sum(AlgebraicExpression, AlgebraicExpression)
    case product(AlgebraicExpression, AlgebraicExpression)
    case power(AlgebraicExpression, Int)
    
    // Symbolic differentiation
    func derivative(with respect: String) -> AlgebraicExpression {
        switch self {
        case .variable(let name):
            return name == respect ? .constant(1) : .constant(0)
        case .constant:
            return .constant(0)
        case .sum(let u, let v):
            return .sum(u.derivative(with: respect), v.derivative(with: respect))
        case .product(let u, let v):
            // Product rule: d(uv) = u'v + uv'
            return .sum(
                .product(u.derivative(with: respect), v),
                .product(u, v.derivative(with: respect))
            )
        case .power(let base, let exp):
            // Power rule: d(u^n) = n * u^(n-1) * u'
            return .product(
                .product(.constant(Double(exp)), .power(base, exp - 1)),
                base.derivative(with: respect)
            )
        }
    }
    
    // Simplification
    func simplified() -> AlgebraicExpression {
        switch self {
        case .sum(let a, let b):
            let simpleA = a.simplified()
            let simpleB = b.simplified()
            
            // 0 + x = x, x + 0 = x
            if case .constant(0) = simpleA { return simpleB }
            if case .constant(0) = simpleB { return simpleA }
            
            // Combine constants
            if case .constant(let valA) = simpleA,
               case .constant(let valB) = simpleB {
                return .constant(valA + valB)
            }
            
            return .sum(simpleA, simpleB)
            
        case .product(let a, let b):
            let simpleA = a.simplified()
            let simpleB = b.simplified()
            
            // 0 * x = 0, x * 0 = 0
            if case .constant(0) = simpleA { return .constant(0) }
            if case .constant(0) = simpleB { return .constant(0) }
            
            // 1 * x = x, x * 1 = x
            if case .constant(1) = simpleA { return simpleB }
            if case .constant(1) = simpleB { return simpleA }
            
            // Combine constants
            if case .constant(let valA) = simpleA,
               case .constant(let valB) = simpleB {
                return .constant(valA * valB)
            }
            
            return .product(simpleA, simpleB)
            
        default:
            return self
        }
    }
}

// Example: differentiate x^2 + 3x + 5
let expression = AlgebraicExpression.sum(
    .sum(.power(.variable("x"), 2), .product(.constant(3), .variable("x"))),
    .constant(5)
)

let derivative = expression.derivative(with: "x").simplified()

/*:
 ### 2.3.3 Example: Representing Sets
 
 Different representations of sets illustrate design tradeoffs:
 */

// Set as unordered list
struct ListSet<T: Equatable> {
    private var elements: [T]
    
    init(_ elements: [T] = []) {
        self.elements = elements
    }
    
    func contains(_ element: T) -> Bool {
        return elements.contains(element)
    }
    
    func insert(_ element: T) -> ListSet<T> {
        if contains(element) {
            return self
        } else {
            return ListSet(elements + [element])
        }
    }
    
    func union(_ other: ListSet<T>) -> ListSet<T> {
        return other.elements.reduce(self) { set, element in
            set.insert(element)
        }
    }
    
    func intersection(_ other: ListSet<T>) -> ListSet<T> {
        return ListSet(elements.filter { other.contains($0) })
    }
}

// Set as ordered list (more efficient for large sets)
struct OrderedSet<T: Comparable> {
    private var elements: [T]
    
    init(_ elements: [T] = []) {
        self.elements = elements.sorted()
    }
    
    func contains(_ element: T) -> Bool {
        return binarySearch(element) != nil
    }
    
    private func binarySearch(_ element: T) -> Int? {
        var left = 0
        var right = elements.count - 1
        
        while left <= right {
            let mid = (left + right) / 2
            let midElement = elements[mid]
            
            if midElement == element {
                return mid
            } else if midElement < element {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
}

/*:
 ## 2.4 Multiple Representations for Abstract Data
 
 When designing large systems, we need to consider multiple representations for data objects.
 
 ### 2.4.1 Representations for Complex Numbers
 
 Complex numbers can be represented in rectangular or polar form:
 */

protocol ComplexNumber {
    var realPart: Double { get }
    var imagPart: Double { get }
    var magnitude: Double { get }
    var angle: Double { get }
}

// Rectangular representation
struct RectangularComplex: ComplexNumber {
    let real: Double
    let imag: Double
    
    var realPart: Double { return real }
    var imagPart: Double { return imag }
    var magnitude: Double { return sqrt(real * real + imag * imag) }
    var angle: Double { return atan2(imag, real) }
}

// Polar representation
struct PolarComplex: ComplexNumber {
    let mag: Double
    let ang: Double
    
    var realPart: Double { return mag * cos(ang) }
    var imagPart: Double { return mag * sin(ang) }
    var magnitude: Double { return mag }
    var angle: Double { return ang }
}

// Generic operations
extension ComplexNumber {
    static func add(_ z1: ComplexNumber, _ z2: ComplexNumber) -> RectangularComplex {
        return RectangularComplex(
            real: z1.realPart + z2.realPart,
            imag: z1.imagPart + z2.imagPart
        )
    }
    
    static func multiply(_ z1: ComplexNumber, _ z2: ComplexNumber) -> PolarComplex {
        return PolarComplex(
            mag: z1.magnitude * z2.magnitude,
            ang: z1.angle + z2.angle
        )
    }
}

/*:
 ### 2.4.2 Tagged Data
 
 We can use type tags to distinguish between different representations:
 */

enum TaggedComplex {
    case rectangular(Double, Double)
    case polar(Double, Double)
    
    var realPart: Double {
        switch self {
        case .rectangular(let real, _):
            return real
        case .polar(let mag, let ang):
            return mag * cos(ang)
        }
    }
    
    var imagPart: Double {
        switch self {
        case .rectangular(_, let imag):
            return imag
        case .polar(let mag, let ang):
            return mag * sin(ang)
        }
    }
}

/*:
 ## 2.5 Systems with Generic Operations
 
 Generic operations work on different types of data through a common interface.
 
 ### 2.5.1 Generic Arithmetic Operations
 
 Swift's protocol system provides excellent support for generic operations:
 */

protocol ArithmeticType {
    static func + (lhs: Self, rhs: Self) -> Self
    static func * (lhs: Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func / (lhs: Self, rhs: Self) -> Self
    static var zero: Self { get }
    static var one: Self { get }
}

extension Int: ArithmeticType {
    static var zero: Int { return 0 }
    static var one: Int { return 1 }
}

extension Double: ArithmeticType {
    static var zero: Double { return 0.0 }
    static var one: Double { return 1.0 }
}

extension RationalNumber: ArithmeticType {
    static var zero: RationalNumber { return RationalNumber(0, 1) }
    static var one: RationalNumber { return RationalNumber(1, 1) }
}

// Generic operations that work with any arithmetic type
/// Computes the square of a value using generic arithmetic operations.
///
/// This function works with any type that conforms to ArithmeticType,
/// demonstrating the power of generic programming.
///
/// - Parameter x: The value to be squared.
/// - Returns: The result of multiplying `x` by itself.
func square<T: ArithmeticType>(_ x: T) -> T {
    return x * x
}

/// Computes base raised to the power of exp using fast exponentiation.
///
/// Uses the square-and-multiply algorithm for efficient computation,
/// working with any arithmetic type.
///
/// - Parameters:
///   - base: The base value.
///   - exp: The exponent (must be non-negative).
/// - Returns: The result of base^exp.
///
/// - Complexity: O(log exp) time.
func power<T: ArithmeticType>(_ base: T, _ exp: Int) -> T {
    if exp == 0 {
        return T.one
    } else if exp % 2 == 0 {
        return square(power(base, exp / 2))
    } else {
        return base * power(base, exp - 1)
    }
}

/*:
 ### 2.5.2 Combining Data of Different Types
 
 Type coercion allows operations between different numeric types:
 */

enum NumericValue {
    case integer(Int)
    case rational(RationalNumber)
    case real(Double)
    
    // Type hierarchy: Int -> Rational -> Double
    func coerceTo(_ targetType: NumericValue) -> NumericValue {
        switch (self, targetType) {
        case (.integer(let i), .rational):
            return .rational(RationalNumber(i, 1))
        case (.integer(let i), .real):
            return .real(Double(i))
        case (.rational(let r), .real):
            return .real(Double(r.numer) / Double(r.denom))
        default:
            return self
        }
    }
}

/*:
 ## Exercises (Implementation Required)
 
 ### 2.1 Exercises
 - **Exercise 2.1**: Define make-rat with proper sign handling
 - **Exercise 2.2**: Implement point and segment abstraction
 - **Exercise 2.3**: Implement rectangle representation  
 - **Exercise 2.4-2.16**: Various interval arithmetic extensions
 
 ### 2.2 Exercises
 - **Exercise 2.17**: Implement last-pair procedure
 - **Exercise 2.18**: Implement reverse procedure
 - **Exercise 2.19**: Implement coin change counting
 - **Exercise 2.20**: Implement same-parity procedure
 - **Exercise 2.21-2.23**: Various list mapping exercises
 - **Exercise 2.24-2.32**: Tree structure exercises
 - **Exercise 2.33-2.39**: Sequence operation exercises
 - **Exercise 2.40-2.43**: Nested mapping exercises
 
 ### 2.3 Exercises  
 - **Exercise 2.44-2.52**: Picture language exercises
 - **Exercise 2.53-2.58**: Symbolic data exercises
 - **Exercise 2.59-2.66**: Set representation exercises
 - **Exercise 2.67-2.72**: Huffman encoding tree exercises
 
 ### 2.4 Exercises
 - **Exercise 2.73-2.76**: Data-directed programming exercises
 - **Exercise 2.77-2.80**: Generic operations exercises
 
 ### 2.5 Exercises
 - **Exercise 2.81-2.97**: Advanced generic operations and type coercion
 
 ## Key Takeaways
 
 1. **Data abstraction** separates representation from use
 2. **Closure property** enables hierarchical data structures  
 3. **Conventional interfaces** provide modularity and composability
 4. **Generic operations** enable code reuse across different data types
 5. **Multiple representations** allow flexibility in system design
 6. **Symbolic processing** enables manipulation of expressions as data
 7. **Type systems** help organize and ensure consistency in complex programs
 */

//: [Next](@next)
