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
1000 - 111
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
/// Returns the square of the given value.
///
/// - Parameter x: The value to be squared.
/// - Returns: The result of multiplying `x` by itself.
func square(_ x: Double) -> Double {
    return x * x
}

/// Returns the sum of the squares of the two given integers.
///
/// This function computes the square of each input integer and then
/// returns the sum of those squares.
///
/// - Parameters:
///   - x: The first integer value.
///   - y: The second integer value.
/// - Returns: The sum of the squares of `x` and `y`.
func sumOfSquares(_ x: Double, _ y: Double) -> Double {
    return square(x) + square(y)
}

/// Returns the sum of the squares of two numbers derived from the input.
///
/// Given an integer `a`, this function computes:
/// - the square of `(a + 1)`
/// - the square of `(2 * a)`
/// and returns their sum.
///
/// - Parameter a: An integer value used to compute `(a + 1)` and `(2 * a)`.
/// - Returns: The sum of the squares of `(a + 1)` and `(2 * a)`.
func sumOfSquaresOfAPlus1And2A(_ a: Double) -> Double {
    return sumOfSquares(a + 1, a * 2)
}

// Testing the procedures
square(21)
square(2 + 5)
square(square(3))
sumOfSquares(3, 4)
sumOfSquaresOfAPlus1And2A(5)

/*:
 ### 1.1.5 The Substitution Model for Procedure Application

 To understand how procedures work, we can use the **substitution model**:
 1. Replace formal parameters with corresponding arguments
 2. Evaluate the resulting expression

 Example: sumOfSquaresOfAPlus1And2A(5)
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
/// Returns the absolute value of a given number.
///
/// This function computes the absolute value of the input `x`.
/// If `x` is negative, it returns `-x`; otherwise, it returns `x`.
///
/// - Parameter x: The value whose absolute value is to be calculated.
/// - Returns: The absolute value of `x`.
func absoluteValue(_ x: Double) -> Double {
    if x < 0 {
        return -x
    } else {
        return x
    }
}

/// Returns the absolute value of the given number.
///
/// The absolute value of a number is its distance from zero, disregarding its sign.
/// If the input is negative, this function returns its negation; otherwise, it returns the input as is.
///
/// - Parameter x: The number whose absolute value is to be determined.
/// - Returns: The absolute value of `x`.
/// - Note: This version is more concise using a ternary operator
func abs(_ x: Double) -> Double {
    return x >= 0 ? x : -x
}

/// Returns the absolute value of the given number.
///
/// The absolute value of a number is its distance from zero, disregarding its sign.
/// If the input is negative, this function returns its negation; otherwise, it returns the input as is.
///
/// - Parameter x: The number whose absolute value is to be determined.
/// - Returns: The absolute value of `x`.
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

/// Demonstrates logical operations in Swift.
///
/// This function showcases the use of logical AND (&&), OR (||), and NOT (!) operators
/// with boolean expressions involving comparison operations.
///
/// - Note: This function doesn't return a value but demonstrates various logical operations
///   that can be used in conditional statements and boolean expressions.
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
/// Returns the arithmetic mean of two numeric values.
///
/// - Parameters:
///   - x: The first value.
///   - y: The second value.
/// - Returns: The average (arithmetic mean) of `x` and `y`. For numeric types that conform to `BinaryFloatingPoint` or `BinaryInteger`, this is calculated as `(x + y) / 2`.
/// - Note: For integer inputs, the result will use integer division and may drop any fractional part. For floating-point inputs, the result will include the fractional part.
func average(_ x: Double, _ y: Double) -> Double {
    return (x + y) / 2
}

/// Repeatedly improves an initial guess using a specified improvement function.
///
/// - Parameters:
///   - guess: The initial value to start the improvement process.
///   - improvement: A function that takes the current guess and returns an improved guess.
/// - Returns: The result after repeatedly applying the improvement function until a stopping condition is met (such as reaching a desired precision or convergence, depending on the actual implementation).
///
/// Use this function to iteratively refine an approximation, such as in algorithms for computing square roots or other numerical methods.
func improve(_ guess: Double, _ x: Double) -> Double {
    return average(guess, x / guess)
}

/// Determines whether the given guess is "good enough" as an approximation for the square root of a number.
///
/// - Parameters:
///   - guess: The current approximation of the square root.
///   - x: The number for which the square root is being computed.
/// - Returns: A Boolean value indicating whether the guess is sufficiently close to the actual square root.
///
/// This function typically compares the difference between `guess * guess` and `x`
/// to a small tolerance, returning `true` if the difference is within the acceptable range.
/// It is commonly used as a stopping condition in iterative algorithms (such as Newton's method)
/// for computing square roots.
func isGoodEnough(_ guess: Double, _ x: Double) -> Bool {
    return abs(square(guess) - x) < 0.001
}

/// Computes the square root of a given number using an iterative method.
///
/// This function uses an iterative approximation algorithm (typically Newton's method or similar)
/// to calculate the square root of `x`, starting from an initial guess `guess`.
///
/// - Parameters:
///   - guess: The initial guess for the square root. The algorithm will iteratively improve this value.
///   - x: The number whose square root is to be computed. Must be a non-negative value.
///
/// - Returns: The computed approximation of the square root of `x`.
///
/// - Note: If `x` is negative, the behavior is undefined unless otherwise specified in the implementation.
func sqrtIterative(_ guess: Double, _ x: Double) -> Double {
    if isGoodEnough(guess, x) {
        return guess
    } else {
        return sqrtIterative(improve(guess, x), x)
    }
}

/// Returns the square root of the given value.
///
/// - Parameter x: A floating-point value whose square root is to be calculated.
/// - Returns: The nonnegative square root of `x`. If `x` is negative, the result is NaN (not a number).
/// - Note: `sqrt(_:)` is available for floating-point types such as `Double`, `Float`, and `CGFloat`.
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

/// Returns the square of the given value, demonstrating local scope binding.
///
/// This function illustrates how parameters are bound within the local scope of a procedure.
/// The parameter `x` exists only within this function's scope and doesn't interfere with
/// other variables of the same name in different scopes.
///
/// - Parameter x: The value to be squared, bound locally within this function.
/// - Returns: The result of multiplying `x` by itself.
///
/// - Note: Demonstrates local name binding and scope isolation.
func squareLocalScope(_ x: Double) -> Double {
    // x is bound within this scope
    return x * x
}

/// Determines whether the given guess is sufficiently accurate for square root approximation.
///
/// This function demonstrates how parameters are local to each procedure and don't interfere
/// with identically named parameters in other functions. Both `guess` and `x` are bound
/// variables that exist only within this function's scope.
///
/// - Parameters:
///   - guess: The current approximation of the square root, local to this procedure.
///   - x: The number for which the square root is being computed, local to this procedure.
/// - Returns: A Boolean value indicating whether the guess is within acceptable tolerance.
///
/// - Note: These parameters are completely independent of any other variables with the same names.
func goodEnough(_ guess: Double, _ x: Double) -> Bool {
    // These parameters are local to this procedure
    return abs(square(guess) - x) < 0.001
}

/*:
 **Internal definitions and block structure**: We can define helper functions inside main functions for better encapsulation.
 */

/// Computes the square root using Newton's method with internal helper functions.
///
/// This function demonstrates **internal definitions and block structure** - helper functions
/// defined inside the main function that have access to the outer scope's variables.
/// The internal functions can reference `x` from the enclosing scope without it being
/// passed as a parameter, providing better encapsulation and cleaner interfaces.
///
/// - Parameter x: The number whose square root is to be computed.
/// - Returns: An approximation of the square root of `x`.
///
/// - Note: Internal functions (`isGoodEnough`, `improve`, `sqrtIter`) are only accessible
///         within this function's scope and automatically capture `x` from outer scope.
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

/// Computes the factorial of a given integer using recursive process.
///
/// This implementation uses a recursive approach that builds up a chain of deferred operations.
/// Each recursive call multiplies the current number by the factorial of (n-1).
///
/// - Parameter n: A positive integer whose factorial is to be computed.
/// - Returns: The factorial of `n` (n!).
///
/// - Complexity: O(n) time, O(n) space due to recursive call stack.
/// - Note: This creates a recursive process with deferred operations.
func factorial(_ n: Int) -> Int {
    if n == 1 {
        return 1
    } else {
        return n * factorial(n - 1)
    }
}

/// Computes the factorial of a given integer using iterative process.
///
/// This implementation uses an iterative approach with fixed amount of state information.
/// It maintains a running product and counter, avoiding the recursive call stack.
///
/// - Parameter n: A positive integer whose factorial is to be computed.
/// - Returns: The factorial of `n` (n!).
///
/// - Complexity: O(n) time, O(1) space (tail-recursive optimization).
/// - Note: This generates an iterative process despite using recursive syntax.
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

/// Computes the nth Fibonacci number using tree recursion (inefficient).
///
/// This implementation recomputes the same Fibonacci numbers multiple times,
/// leading to an exponential number of calls. Each call splits into two more calls,
/// creating a large tree of repeated work.
///
/// - Parameter n: The position in the Fibonacci sequence (0-based).
/// - Returns: The nth Fibonacci number.
///
/// - Complexity: O(2^n) time, O(n) space.
/// - Warning: Extremely slow for large n due to exponential time complexity.
func fibonacci(_ n: Int) -> Int {
    if n == 0 {
        return 0
    } else if n == 1 {
        return 1
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2)
    }
}

/// Computes the nth Fibonacci number using linear iteration (efficient).
///
/// This implementation uses an iterative process that only requires tracking the last two values.
/// No repeated computation occurs—each step simply advances the sequence.
///
/// - Parameter n: The position in the Fibonacci sequence (0-based).
/// - Returns: The nth Fibonacci number.
///
/// - Complexity: O(n) time, O(1) space.
/// - Note: Much more efficient than tree-recursive approach for large n.
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
 - **Θ(1)**: _Constant time_ - An operation takes the same amount of time regardless of the input size—for example, accessing an element in an array by its index.
 - **Θ(log n)**: _Logarithmic time_ - The time grows logarithmically as the input size increases; a classic example is binary search, which repeatedly halves the input set.
 - **Θ(n)**: _Linear time_ - The time taken increases directly in proportion to the input size, such as iterating through all elements in an array once.
 - **Θ(n²)**: _Quadratic time_ - Time grows with the square of the input size, typical of algorithms with nested loops over the data, like bubble sort.
 - **Θ(2ⁿ)**: _Exponential time_ - Time doubles with each additional input unit, seen in algorithms that solve problems by exploring all possible combinations, such as the recursive solution to the traveling salesman problem.

 ### 1.2.4 Exponentiation

 Different approaches to computing powers:
 */

/// Computes b raised to the power of n using linear recursion.
///
/// Each recursive call multiplies the base until n reaches zero.
///
/// - Parameters:
///   - b: The base.
///   - n: The exponent.
/// - Returns: The result of b ** n.
///
/// - Complexity: Θ(n) time, Θ(n) space.
func expt(_ b: Double, _ n: Int) -> Double {
    if n == 0 {
        return 1
    }
    return b * expt(b, n - 1)
}

/// Computes b raised to the power of n using an iterative process.
///
/// Uses tail-recursion to multiply the base while minimizing stack usage.
///
/// - Parameters:
///   - b: The base.
///   - n: The exponent.
/// - Returns: The result of b ** n.
///
/// - Complexity: Θ(n) time, Θ(1) space.
func exptIterative(_ b: Double, _ n: Int) -> Double {
    var result = 1.0
    var base = b
    var exponent = n

    while exponent > 0 {
        result *= base
        exponent -= 1
    }
    return result
}

/// Computes b raised to the power of n using fast exponentiation (exponentiation by squaring).
///
/// This algorithm reduces the number of multiplications by recursively squaring the base for even exponents.
///
/// - Parameters:
///   - b: The base.
///   - n: The exponent.
/// - Returns: The result of b ** n.
///
/// - Complexity: Θ(log n) time, Θ(log n) space.
func fastExpt(_ b: Double, _ n: Int) -> Double {
    if n == 0 {
        return 1
    } else if n % 2 == 0 {
        let half = fastExpt(b, n / 2)
        return half * half
    } else {
        return b * fastExpt(b, n - 1)
    }
}

/*:
 ### 1.2.5 Greatest Common Divisors

 Euclid's Algorithm demonstrates an efficient recursive approach:
 */

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

// Testing GCD
gcd(206, 40)  // Should return 2

/*:
 ### 1.2.6 Example: Testing for Primality

 Two approaches with different time complexities:
 */

/// Finds the smallest divisor of a given integer.
///
/// This function finds the smallest divisor of `n` greater than 1.
/// If no such divisor exists, it returns `n` itself (indicating `n` is prime).
///
/// - Parameter n: The integer whose smallest divisor is to be found.
/// - Returns: The smallest divisor of `n` greater than 1, or `n` if it's prime.
///
/// - Complexity: O(√n) time.
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

/// Determines whether a given integer is prime.
///
/// A number is prime if its smallest divisor is itself.
///
/// - Parameter n: The integer to test for primality.
/// - Returns: `true` if `n` is prime, `false` otherwise.
///
/// - Complexity: O(√n) time.
func isPrime(_ n: Int) -> Bool {
    return n == smallestDivisor(n)
}

/// Computes (base^exp) mod m efficiently using fast exponentiation.
///
/// This function implements modular exponentiation using the square-and-multiply method,
/// which is essential for cryptographic applications and probabilistic primality testing.
///
/// - Parameters:
///   - base: The base number.
///   - exp: The exponent.
///   - m: The modulus.
/// - Returns: The result of (base^exp) mod m.
///
/// - Complexity: O(log exp) time.
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

/// Performs Fermat's primality test on a given integer.
///
/// This probabilistic test is based on Fermat's Little Theorem:
/// if n is prime and a < n, then a^n ≡ a (mod n).
///
/// - Parameter n: The integer to test for primality.
/// - Returns: `true` if `n` passes the test (possibly prime), `false` if composite.
///
/// - Complexity: O(log n) time.
/// - Note: This is a probabilistic test that can have false positives (Carmichael numbers).
func fermatTest(_ n: Int) -> Bool {
    func tryIt(_ a: Int) -> Bool {
        return expmod(a, n, n) == a
    }
    let testValue = Int.random(in: 1..<n)
    return tryIt(testValue)
}

/// Tests primality using repeated Fermat tests.
///
/// Performs the Fermat test multiple times to increase confidence in the result.
/// The more tests performed, the higher the probability of correct identification.
///
/// - Parameters:
///   - n: The integer to test for primality.
///   - times: The number of Fermat tests to perform.
/// - Returns: `true` if `n` passes all tests (likely prime), `false` if any test fails.
///
/// - Complexity: O(times × log n) time.
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

/// Computes the sum of terms in a sequence using higher-order functions.
///
/// This generic summation procedure takes a term function and applies it to each value
/// from `a` to `b`, using the `next` function to generate successive values.
///
/// - Parameters:
///   - term: A function that computes the term for each value.
///   - a: The starting value of the sequence.
///   - next: A function that generates the next value in the sequence.
///   - b: The ending value of the sequence.
/// - Returns: The sum of all terms in the sequence.
///
/// - Complexity: O(n) time where n is the number of terms.
func sum<T: Numeric & Comparable>(_ term: (T) -> T, _ a: T, _ next: (T) -> T, _ b: T) -> T {
    if a > b {
        return T.zero
    } else {
        return term(a) + sum(term, next(a), next, b)
    }
}

/// Computes the sum of integers from a to b inclusive.
///
/// Uses the generic `sum` function with identity term function and increment next function.
///
/// - Parameters:
///   - a: The starting integer.
///   - b: The ending integer.
/// - Returns: The sum of integers from `a` to `b`.
func sumIntegers(_ a: Int, _ b: Int) -> Int {
    func identity(_ x: Int) -> Int { return x }
    func inc(_ n: Int) -> Int { return n + 1 }
    return sum(identity, a, inc, b)
}

/// Computes the sum of cubes of integers from a to b inclusive.
///
/// Uses the generic `sum` function with cube term function and increment next function.
///
/// - Parameters:
///   - a: The starting integer.
///   - b: The ending integer.
/// - Returns: The sum of cubes from `a³` to `b³`.
func sumCubes(_ a: Int, _ b: Int) -> Int {
    func cube(_ x: Int) -> Int { return x * x * x }
    func inc(_ n: Int) -> Int { return n + 1 }
    return sum(cube, a, inc, b)
}

/// Computes an approximation of π/8 using a mathematical series.
///
/// Uses the series: π/8 = 1/(1×3) + 1/(5×7) + 1/(9×11) + ...
/// Each term has the form 1/(x×(x+2)) where x takes values 1, 5, 9, 13, ...
///
/// - Parameters:
///   - a: The starting value for the series.
///   - b: The ending value for the series.
/// - Returns: An approximation of π/8 based on the specified range.
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

/// Computes an approximation of π/8 using closures instead of named functions.
///
/// This is equivalent to `piSum` but demonstrates the use of Swift closures
/// as anonymous functions passed directly to the `sum` function.
///
/// - Parameters:
///   - a: The starting value for the series.
///   - b: The ending value for the series.
/// - Returns: An approximation of π/8 based on the specified range.
func piSumWithClosures(_ a: Double, _ b: Double) -> Double {
    return sum({ x in 1.0 / (x * (x + 2)) }, a, { x in x + 4 }, b)
}

/// Computes a mathematical expression involving local variables.
///
/// Computes: x × a² + y × b + a × b where a = 1 + xy and b = 1 - y.
///
/// - Parameters:
///   - x: The first input value.
///   - y: The second input value.
/// - Returns: The computed result of the mathematical expression.
func f2(_ x: Double, _ y: Double) -> Double {
    let a = 1 + x * y
    let b = 1 - y
    return x * square(a) + y * b + a * b
}

/// Computes the same expression as f2 but using closure for local variable binding.
///
/// Demonstrates how closures can be used to create local scope and bind variables,
/// equivalent to let-expressions in functional programming languages.
///
/// - Parameters:
///   - x: The first input value.
///   - y: The second input value.
/// - Returns: The same result as `f2`, computed using closure-based local binding.
func f2WithClosure(_ x: Double, _ y: Double) -> Double {
    return { (a: Double, b: Double) in
        x * square(a) + y * b + a * b
    }(1 + x * y, 1 - y)
}

/*:
 ### 1.3.3 Procedures as General Methods

 **Finding roots by the half-interval method**:
 */

/// Searches for a root of a function using the bisection method.
///
/// Assumes that the function has opposite signs at the two endpoints,
/// guaranteeing the existence of a root by the Intermediate Value Theorem.
///
/// - Parameters:
///   - f: The function whose root is being sought.
///   - negPoint: The point where the function is negative.
///   - posPoint: The point where the function is positive.
/// - Returns: An approximation of the root within the specified tolerance.
///
/// - Complexity: O(log((b-a)/tolerance)) iterations.
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

/// Finds a root of a continuous function using the half-interval method.
///
/// This method uses the bisection algorithm to find a root of the function `f`
/// in the interval [a, b], provided that f(a) and f(b) have opposite signs.
///
/// - Parameters:
///   - f: The continuous function whose root is being sought.
///   - a: The left endpoint of the interval.
///   - b: The right endpoint of the interval.
/// - Returns: A root of the function if one exists in the interval, or `nil` if no root is guaranteed.
///
/// - Precondition: f(a) and f(b) must have opposite signs for a root to be guaranteed.
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

/// Finds a fixed point of a function using successive approximations.
///
/// A fixed point of a function f is a value x such that f(x) = x.
/// This function iteratively applies f starting from an initial guess until
/// successive values are close enough (within tolerance).
///
/// - Parameters:
///   - f: The function whose fixed point is being sought.
///   - firstGuess: The initial guess for the fixed point.
/// - Returns: An approximation of the fixed point.
///
/// - Note: Convergence is not guaranteed for all functions and starting points.
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

// Find the fixed point of cosine function (approximately 0.739)
let cosineFixedPoint = fixedPoint(cos, 1.0)

/// Attempts to compute square root as a fixed point (unstable without damping).
///
/// This approach tries to find the square root of x by finding the fixed point
/// of the function y ↦ x/y. However, this approach doesn't converge without
/// average damping due to oscillation.
///
/// - Parameter x: The number whose square root is desired.
/// - Returns: Attempts to return the square root, but may not converge.
///
/// - Warning: This implementation may not converge due to lack of damping.
func sqrtAsFixedPoint(_ x: Double) -> Double {
    return fixedPoint({ y in x / y }, 1.0)  // This won't converge without damping
}

/*:
 ### 1.3.4 Procedures as Returned Values

 **Average damping** to improve convergence:
 */

/// Creates a function that applies average damping to another function.
///
/// Average damping transforms a function f into a new function that returns
/// the average of x and f(x). This technique is used to improve convergence
/// in fixed-point computations.
///
/// - Parameter f: The function to be damped.
/// - Returns: A new function that computes (x + f(x))/2.
func averageDamp(_ f: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in average(x, f(x)) }
}

/// Computes the square root using fixed-point method with average damping.
///
/// This approach finds the square root of x by finding the fixed point of
/// the average-damped function y ↦ (y + x/y)/2, which converges reliably.
///
/// - Parameter x: The number whose square root is desired.
/// - Returns: The square root of x.
func sqrtWithAverageDamp(_ x: Double) -> Double {
    return fixedPoint(averageDamp({ y in x / y }), 1.0)
}

/// Computes the cube root using fixed-point method with average damping.
///
/// Finds the cube root of x by finding the fixed point of the average-damped
/// function y ↦ (y + x/y²)/2.
///
/// - Parameter x: The number whose cube root is desired.
/// - Returns: The cube root of x.
func cubeRoot(_ x: Double) -> Double {
    return fixedPoint(averageDamp({ y in x / (y * y) }), 1.0)
}

/*:
 **Newton's method** for finding roots:
 */

let dx = 0.00001

/// Computes the numerical derivative of a function.
///
/// Uses the definition of derivative as the limit of difference quotients:
/// f'(x) ≈ (f(x + dx) - f(x))/dx for small dx.
///
/// - Parameter g: The function whose derivative is to be computed.
/// - Returns: A function that approximates the derivative of g.
///
/// - Note: Uses a small value dx for the difference quotient approximation.
func derivative(_ g: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in (g(x + dx) - g(x)) / dx }
}

/// Creates the Newton's method transformation for a function.
///
/// The Newton transformation of a function g is: x ↦ x - g(x)/g'(x)
/// This transformation is used to find roots of g (zeros of the function).
///
/// - Parameter g: The function whose roots are being sought.
/// - Returns: The Newton transformation function.
func newtonTransform(_ g: @escaping (Double) -> Double) -> (Double) -> Double {
    return { x in x - g(x) / derivative(g)(x) }
}

/// Finds a root of a function using Newton's method.
///
/// Newton's method finds roots by repeatedly applying the Newton transformation
/// until convergence. It typically converges faster than bisection method.
///
/// - Parameters:
///   - g: The function whose root is being sought.
///   - guess: The initial guess for the root.
/// - Returns: An approximation of the root.
///
/// - Note: Convergence depends on the initial guess and function properties.
func newtonsMethod(_ g: @escaping (Double) -> Double, _ guess: Double) -> Double {
    return fixedPoint(newtonTransform(g), guess)
}

/// Computes the square root using Newton's method.
///
/// Finds the square root of x by finding the root of the function y ↦ y² - x
/// using Newton's method.
///
/// - Parameter x: The number whose square root is desired.
/// - Returns: The square root of x.
func sqrtNewton(_ x: Double) -> Double {
    return newtonsMethod({ y in square(y) - x }, 1.0)
}

/*:
 **Abstractions and first-class procedures**:
 */

/// Finds a fixed point of a transformed function.
///
/// This higher-order function abstracts the pattern of applying a transformation
/// to a function and then finding the fixed point of the result.
///
/// - Parameters:
///   - g: The original function.
///   - transform: The transformation to apply to g.
///   - guess: The initial guess for the fixed point.
/// - Returns: The fixed point of the transformed function.
func fixedPointOfTransform(
    _ g: @escaping (Double) -> Double,
    _ transform: @escaping (@escaping (Double) -> Double) -> (Double) -> Double,
    _ guess: Double
) -> Double {
    return fixedPoint(transform(g), guess)
}

/// Computes square root using fixed-point method with average damping transformation.
///
/// Demonstrates the abstraction of fixed-point computation with transformations.
///
/// - Parameter x: The number whose square root is desired.
/// - Returns: The square root of x.
func sqrtUsingFixedPointTransform(_ x: Double) -> Double {
    return fixedPointOfTransform({ y in x / y }, averageDamp, 1.0)
}

/// Computes square root using fixed-point method with Newton transformation.
///
/// Demonstrates the abstraction of fixed-point computation with transformations.
///
/// - Parameter x: The number whose square root is desired.
/// - Returns: The square root of x.
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
