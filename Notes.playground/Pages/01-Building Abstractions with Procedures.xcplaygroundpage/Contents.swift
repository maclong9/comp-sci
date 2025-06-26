//: [Previous](@previous)
/*:
 # SICP Chapter 1: Building Abstractions with Procedures

 This chapter explores the fundamental elements of programming and how to build computational processes using procedures. We'll translate the core concepts from SICP's Scheme examples into Swift.

 ## 1.1 The Elements of Programming

 Every powerful programming language has three mechanisms:
 - **Primitive expressions**: The simplest entities the language is concerned with
 - **Means of combination**: Build compound elements from simpler ones
 - **Means of abstraction**: Name and manipulate compound elements as units

 ### 1.1.1 Expressions

 In Swift, we work with various types of expressions:
 */

import Foundation

// Primitive expressions
486
137 + 349
1000 - 334
5 * 99
10 / 4
2.7 + 10

// Complex combinations (equivalent to Scheme's prefix notation)
// Scheme: (+ (* 3 5) (- 10 6))
// Swift:
3 * 5 + (10 - 6)

/*:
 ### 1.1.2 Naming and the Environment

 We use names to refer to computational objects. In Swift, we use `let` for constants and `var` for variables.
 */

let size = 2
let pi = 3.14159
let radius = 10.0
let circumference = 2.0 * pi * radius

/*:
 The interpreter maintains an **environment** - a memory that keeps track of name-object pairs.

 ### 1.1.3 Evaluating Combinations

 To evaluate a combination:
 1. Evaluate the subexpressions of the combination
 2. Apply the procedure to the arguments

 This is a **recursive** process that handles nested expressions naturally.
 */

// Complex nested expression
let result = (3 * ((2 * 4) + (3 + 5))) + ((10 - 7) + 6)

/*:
 ### 1.1.4 Compound Procedures

 Procedure definitions are abstractions that give names to patterns of computation.
 */

func square(_ x: Double) -> Double {
    return x * x
}

func sumOfSquares(_ x: Double, _ y: Double) -> Double {
    return square(x) + square(y)
}

func f(_ a: Double) -> Double {
    return sumOfSquares(a + 1, a * 2)
}

// Testing the procedures
square(21)
square(2 + 5)
square(square(3))
sumOfSquares(3, 4)
f(5)

/*:
 ### 1.1.5 The Substitution Model for Procedure Application

 To understand how procedures work, we can use the **substitution model**:
 1. Replace formal parameters with corresponding arguments
 2. Evaluate the resulting expression

 Example: f(5)
 - sumOfSquares(5 + 1, 5 * 2)
 - sumOfSquares(6, 10)
 - square(6) + square(10)
 - 36 + 100
 - 136
 */

/*:
 ### 1.1.6 Conditional Expressions and Predicates

 Swift provides conditional expressions through `if-else` statements and the ternary operator.
 */

func absoluteValue(_ x: Double) -> Double {
    if x < 0 {
        return -x
    } else {
        return x
    }
}

// More concise version using ternary operator
func abs(_ x: Double) -> Double {
    return x >= 0 ? x : -x
}

// Complex conditional logic
func signTest(_ x: Double) -> String {
    if x > 0 {
        return "positive"
    } else if x < 0 {
        return "negative"
    } else {
        return "zero"
    }
}

/*:
 **Logical Operations** in Swift:
 */

func logicalOperations() {
    let x = 5
    let y = 10

    // AND operation
    let andResult = (x > 0) && (y > 0)

    // OR operation
    let orResult = (x > 0) || (y < 0)

    // NOT operation
    let notResult = !(x > y)
}

/*:
 ### 1.1.7 Example: Square Roots by Newton's Method

 This example demonstrates iterative improvement - a powerful computational strategy.
 */

func average(_ x: Double, _ y: Double) -> Double {
    return (x + y) / 2
}

func improve(_ guess: Double, _ x: Double) -> Double {
    return average(guess, x / guess)
}

func isGoodEnough(_ guess: Double, _ x: Double) -> Bool {
    return abs(square(guess) - x) < 0.001
}

func sqrtIterative(_ guess: Double, _ x: Double) -> Double {
    if isGoodEnough(guess, x) {
        return guess
    } else {
        return sqrtIterative(improve(guess, x), x)
    }
}

func sqrt(_ x: Double) -> Double {
    return sqrtIterative(1.0, x)
}

// Test the square root function
sqrt(9.0)
sqrt(100.0 + 44.0)
sqrt(sqrt(2.0) + sqrt(3.0))
square(sqrt(1000.0))

/*:
 ### 1.1.8 Procedures as Black-Box Abstractions

 **Local names** don't interfere with other procedures. Parameters are **bound variables** within the procedure scope.
 */

func squareLocalScope(_ x: Double) -> Double {
    // x is bound within this scope
    return x * x
}

func goodEnough(_ guess: Double, _ x: Double) -> Bool {
    // These parameters are local to this procedure
    return abs(square(guess) - x) < 0.001
}

/*:
 **Internal definitions and block structure**: We can define helper functions inside main functions for better encapsulation.
 */

func sqrtWithInternalDefinitions(_ x: Double) -> Double {
    func isGoodEnough(_ guess: Double) -> Bool {
        return abs(square(guess) - x) < 0.001  // x is available from outer scope
    }

    func improve(_ guess: Double) -> Double {
        return average(guess, x / guess)  // x is available from outer scope
    }

    func sqrtIter(_ guess: Double) -> Double {
        if isGoodEnough(guess) {
            return guess
        } else {
            return sqrtIter(improve(guess))
        }
    }

    return sqrtIter(1.0)
}

/*:
 ## 1.2 Procedures and the Processes They Generate

 Understanding the **computational process** generated by a procedure is crucial for analyzing space and time complexity.

 ### 1.2.1 Linear Recursion and Iteration

 Two different computational processes for computing factorials:
 */

// Recursive process (builds up chain of deferred operations)
func factorial(_ n: Int) -> Int {
    if n == 1 {
        return 1
    } else {
        return n * factorial(n - 1)
    }
}

// Iterative process (fixed amount of state information)
func factorialIterative(_ n: Int) -> Int {
    func factIter(_ product: Int, _ counter: Int, _ maxCount: Int) -> Int {
        if counter > maxCount {
            return product
        } else {
            return factIter(counter * product, counter + 1, maxCount)
        }
    }
    return factIter(1, 1, n)
}

/*:
 **Key Insight**: A recursive *procedure* doesn't necessarily generate a recursive *process*.

 ### 1.2.2 Tree Recursion

 Computing Fibonacci numbers demonstrates tree recursion:
 */

// Tree-recursive process (inefficient)
func fibonacci(_ n: Int) -> Int {
    if n == 0 {
        return 0
    } else if n == 1 {
        return 1
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
}

// Linear iterative process (efficient)
func fibonacciIterative(_ n: Int) -> Int {
    func fibIter(_ a: Int, _ b: Int, _ count: Int) -> Int {
        if count == 0 {
            return b
        } else {
            return fibIter(a + b, a, count - 1)
        }
    }
    return fibIter(1, 0, n)
}

/*:
 ### 1.2.3 Orders of Growth

 We characterize computational complexity using **Big-O notation**:
 - **Θ(1)**: Constant time
 - **Θ(log n)**: Logarithmic time
 - **Θ(n)**: Linear time
 - **Θ(n²)**: Quadratic time
 - **Θ(2ⁿ)**: Exponential time

 ### 1.2.4 Exponentiation

 Different approaches to computing powers:
 */

// Linear recursive process - Θ(n) time, Θ(n) space
func expt(_ b: Double, _ n: Int) -> Double {
    if n == 0 {
        return 1
    } else {
        return b * expt(b, n - 1)
    }
}

// Linear iterative process - Θ(n) time, Θ(1) space
func exptIterative(_ b: Double, _ n: Int) -> Double {
    func exptIter(_ b: Double, _ counter: Int, _ product: Double) -> Double {
        if counter == 0 {
            return product
        } else {
            return exptIter(b, counter - 1, b * product)
        }
    }
    return exptIter(b, n, 1)
}

// Fast exponentiation - Θ(log n) time and space
func fastExpt(_ b: Double, _ n: Int) -> Double {
    if n == 0 {
        return 1
    } else if n % 2 == 0 {
        return square(fastExpt(b, n / 2))
    } else {
        return b * fastExpt(b, n - 1)
    }
}

/*:
 ### 1.2.5 Greatest Common Divisors

 Euclid's Algorithm demonstrates an efficient recursive approach:
 */

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    } else {
        return gcd(b, a % b)
    }
}

// Testing GCD
gcd(206, 40)  // Should return 2

/*:
 ### 1.2.6 Example: Testing for Primality

 Two approaches with different time complexities:
 */

// Finding the smallest divisor - Θ(√n)
func smallestDivisor(_ n: Int) -> Int {
    func findDivisor(_ n: Int, _ testDivisor: Int) -> Int {
        if square(Double(testDivisor)) > Double(n) {
            return n
        } else if n % testDivisor == 0 {
            return testDivisor
        } else {
            return findDivisor(n, testDivisor + 1)
        }
    }
    return findDivisor(n, 2)
}

func isPrime(_ n: Int) -> Bool {
    return n == smallestDivisor(n)
}

// The Fermat test - Θ(log n) probabilistic algorithm
func expmod(_ base: Int, _ exp: Int, _ m: Int) -> Int {
    if exp == 0 {
        return 1
    } else if exp % 2 == 0 {
        let half = expmod(base, exp / 2, m)
        return (half * half) % m
    } else {
        return (base * expmod(base, exp - 1, m)) % m
    }
}

func fermatTest(_ n: Int) -> Bool {
    func tryIt(_ a: Int) -> Bool {
        return expmod(a, n, n) == a
    }
    let testValue = Int.random(in: 1..<n)
    return tryIt(testValue)
}

func fastPrime(_ n: Int, _ times: Int) -> Bool {
    if times == 0 {
        return true
    } else if fermatTest(n) {
        return fastPrime(n, times - 1)
    } else {
        return false
    }
}

/*:
 ## 1.3 Formulating Abstractions with Higher-Order Procedures

 **Higher-order procedures** can take procedures as arguments or return procedures as values.

 ### 1.3.1 Procedures as Arguments

 Generic summation procedure:
 */

func sum<T: Numeric & Comparable>(_ term: (T) -> T, _ a: T, _ next: (T) -> T, _ b: T) -> T {
    if a > b {
        return T.zero
    } else {
        return term(a) + sum(term, next(a), next, b)
    }
}

// Sum of integers from a to b
func sumIntegers(_ a: Int, _ b: Int) -> Int {
    func identity(_ x: Int) -> Int { return x }
    func inc(_ n: Int) -> Int { return n + 1 }
    return sum(identity, a, inc, b)
}

// Sum of cubes
func sumCubes(_ a: Int, _ b: Int) -> Int {
    func cube(_ x: Int) -> Int { return x * x * x }
    func inc(_ n: Int) -> Int { return n + 1 }
    return sum(cube, a, inc, b)
}

// Pi series
func piSum(_ a: Double, _ b: Double) -> Double {
    func piTerm(_ x: Double) -> Double {
        return 1.0 / (x * (x + 2))
    }
    func piNext(_ x: Double) -> Double {
        return x + 4
    }
    return sum(piTerm, a, piNext, b)
}

/*:
 ### 1.3.2 Constructing Procedures Using Closures

 Swift's closures are equivalent to Scheme's lambda expressions:
 */

func piSumWithClosures(_ a: Double, _ b: Double) -> Double {
    return sum({ x in 1.0 / (x * (x + 2)) }, a, { x in x + 4 }, b)
}

// Local variables using closures
func f2(_ x: Double, _ y: Double) -> Double {
    let a = 1 + x * y
    let b = 1 - y
    return x * square(a) + y * b + a * b
}

// Equivalent using closure for local binding
func f2WithClosure(_ x: Double, _ y: Double) -> Double {
    return { (a: Double, b: Double) in
        x * square(a) + y * b + a * b
    }(1 + x * y, 1 - y)
}

/*:
 ### 1.3.3 Procedures as General Methods

 **Finding roots by the half-interval method**:
 */

func search(_ f: (Double) -> Double, _ negPoint: Double, _ posPoint: Double) -> Double {
    let midpoint = (negPoint + posPoint) / 2
    if abs(negPoint - posPoint) < 0.001 {
        return midpoint
    }
    let testValue = f(midpoint)
    if testValue > 0 {
        return search(f, negPoint, midpoint)
    } else if testValue < 0 {
        return search(f, midpoint, posPoint)
    } else {
        return midpoint
    }
}

func halfIntervalMethod(_ f: (Double) -> Double, _ a: Double, _ b: Double) -> Double? {
    let aValue = f(a)
    let bValue = f(b)
    if aValue < 0 && bValue > 0 {
        return search(f, a, b)
    } else if bValue < 0 && aValue > 0 {
        return search(f, b, a)
    } else {
        return nil  // No root found
    }
}

// Finding roots of sin(x) = 0
if let root = halfIntervalMethod(sin, 2.0, 4.0) {
    print("Root of sin(x) between 2 and 4: \(root)")
}

/*:
 **Finding fixed points**:
 */

let tolerance = 0.00001

func fixedPoint(_ f: (Double) -> Double, _ firstGuess: Double) -> Double {
    func closeEnough(_ v1: Double, _ v2: Double) -> Bool {
        return abs(v1 - v2) < tolerance
    }

    func tryGuess(_ guess: Double) -> Double {
        let next = f(guess)
        if closeEnough(guess, next) {
            return next
        } else {
            return tryGuess(next)
        }
    }

    return tryGuess(firstGuess)
}

// Fixed point of cosine
let cosineFixedPoint = fixedPoint(cos, 1.0)

// Square root as fixed point
func sqrtAsFixedPoint(_ x: Double) -> Double {
    return fixedPoint({ y in x / y }, 1.0)  // This won't converge without damping
}

/*:
 ### 1.3.4 Procedures as Returned Values

 **Average damping** to improve convergence:
 */

func averageDamp(_ f: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in average(x, f(x)) }
}

func sqrtWithAverageDamp(_ x: Double) -> Double {
    return fixedPoint(averageDamp({ y in x / y }), 1.0)
}

// Cube root using average damping
func cubeRoot(_ x: Double) -> Double {
    return fixedPoint(averageDamp({ y in x / (y * y) }), 1.0)
}

/*:
 **Newton's method** for finding roots:
 */

let dx = 0.00001

func derivative(_ g: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in (g(x + dx) - g(x)) / dx }
}

func newtonTransform(_ g: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in x - g(x) / derivative(g)(x) }
}

func newtonsMethod(_ g: @escaping (Double) -> Double, _ guess: Double) -> Double {
    return fixedPoint(newtonTransform(g), guess)
}

func sqrtNewton(_ x: Double) -> Double {
    return newtonsMethod({ y in square(y) - x }, 1.0)
}

/*:
 **Abstractions and first-class procedures**:
 */

func fixedPointOfTransform(
    _ g: @escaping (Double) -> Double,
    _ transform: @escaping (@escaping (Double) -> Double) -> (Double) -> Double,
    _ guess: Double
) -> Double {
    return fixedPoint(transform(g), guess)
}

func sqrtUsingFixedPointTransform(_ x: Double) -> Double {
    return fixedPointOfTransform({ y in x / y }, averageDamp, 1.0)
}

func sqrtUsingNewtonTransform(_ x: Double) -> Double {
    return fixedPointOfTransform({ y in square(y) - x }, newtonTransform, 1.0)
}

/*:
 ## Exercises (Implementation Required)

 ### 1.1 Exercises
 - **Exercise 1.3**: Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
 - **Exercise 1.8**: Implement cube root calculation using Newton's method.

 ### 1.2 Exercises
 - **Exercise 1.9**: Determine whether recursive or iterative process for addition procedures.
 - **Exercise 1.11**: Implement function f(n) both recursively and iteratively.
 - **Exercise 1.12**: Compute elements of Pascal's triangle recursively.
 - **Exercise 1.19**: Design logarithmic Fibonacci computation using transformation method.

 ### 1.3 Exercises
 - **Exercise 1.29**: Implement Simpson's Rule for numerical integration.
 - **Exercise 1.30**: Rewrite sum procedure to be iterative.
 - **Exercise 1.31**: Define product procedure analogous to sum.
 - **Exercise 1.32**: Show that sum and product are special cases of accumulate.
 - **Exercise 1.33**: Define filtered-accumulate procedure.
 - **Exercise 1.35**: Show that golden ratio φ is a fixed point of x ↦ 1 + 1/x.
 - **Exercise 1.36**: Modify fixed-point to print approximation sequence.
 - **Exercise 1.37**: Implement continued fraction computation.
 - **Exercise 1.38**: Use continued fractions to approximate e - 2.
 - **Exercise 1.39**: Compute tangent function using Lambert's continued fraction.
 - **Exercise 1.40-1.46**: Various applications of Newton's method and higher-order procedures.

 ## Key Takeaways

 1. **Procedural abstraction** allows us to suppress detail and focus on function.
 2. **Recursive vs iterative processes** have different space and time characteristics.
 3. **Higher-order procedures** dramatically increase expressive power.
 4. **First-class procedures** enable powerful programming techniques.
 5. **Computational thinking** involves understanding processes, not just syntax.
 */

//: [Next](@next)
