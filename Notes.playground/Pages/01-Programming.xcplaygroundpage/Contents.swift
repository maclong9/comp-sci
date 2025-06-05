//: [Previous](@previous)
/*:
 # CS-01: Computer Programming

 Most undergraduate CS programs begin with an introduction to computer programming. The best versions of these courses support both novices and those looking to solidify their foundations.

 Recommended materials:
 - [_Structure and Interpretation of Computer Programs_](https://sarabander.github.io/sicp/html/index.xhtml)
 - [Brian Harvey's SICP lectures (61A, Berkeley)](https://archive.org/details/ucberkeley-webcast-PL3E89002AA9B9879E?sort=titleSorter)

 Completing the book and exercises is encouraged. Follow up with practice at [exercism.io](http://exercism.io/).

 ## Structure and Interpretation of Computer Programs

 > The programmer must seek both perfection of part and adequacy of collection.

 Though SICP uses Lisp, we'll use Swift. As the book states, the choice of language affects notation, not expressiveness.

 Every program models some process—real or imagined. These processes are numerous, subtle, and often incompletely understood. Programs evolve as our understanding deepens. Precise and correct program descriptions are essential.

 Large systems emerge from small ones. Thus, we must create standard structures that are known to be correct.

 ### 1.0 Building Abstractions with Procedures

 The mind manipulates simple ideas in three ways:
 1. Combine ideas into compound ones.
 2. Juxtapose ideas without uniting them.
 3. Abstract them from surrounding detail.

 **Computational processes** are abstract, like spirits in a machine—untouchable but capable of intellectual work. When a computer works correctly, it performs operations exactly. Small bugs can have unexpected consequences.

 > Real-world programming demands __care__, __expertise__, and __wisdom__.

 Good programmers organize code so that behavior is reliable and comprehensible.

 **Programming in Swift**

 Programming languages are to computational processes what natural language is to communication, or math to quantity. Swift was introduced in 2014 by Apple. It is safe, expressive, modern, and versatile:
 - Strong type safety
 - Optionals for nullability
 - Closures and value semantics
 - Functional, OOP, and protocol-oriented support

 Swift is suited for expressing ideas cleanly and safely—from iOS apps to backend systems. And, it’s fun to write.

 #### 1.1 The Elements of Programming

 A programming language must do more than tell a computer what to do. It helps us think clearly. Every powerful language provides:
 - **Primitive expressions** for basic entities
 - **Means of combination** to build complex entities
 - **Means of abstraction** to name and reuse compound entities

 Programming involves:
 - _Data_: the stuff
 - _Procedures_: rules for manipulating the stuff

 > A good language allows description, combination, and abstraction of both data and procedures.

 We'll begin with simple numeric data to focus on the rules of procedure construction.

 #### 1.1.1 Expressions

 When you type an expression, Swift evaluates and prints the result:
 */

print(486)

/*:
 Expressions can combine primitives with arithmetic:
 */

print(137 + 349)
print(1000 - 335)
print(5 * 99)
print(10 / 5)

print([56, 645, 23].reduce(0, +))
print([56, 645, 23].reduce(1, *))
print([56, 645, 23].reduce(1.0, /))
print([56, 645, 23].reduce(0, -))

/*:
 The interpreter runs in a **read-eval-print loop** (_REPL_). Start Swift REPL with `swift repl` in a terminal.

 #### 1.1.2 Naming and the Environment

 A language lets us name things:
 */

let size = 2

print(size)
print(5 * size)

/*:
 `let` creates a constant, `var` a mutable variable.
 */

let pi = 3.14159
let radius = 10.0

print(pi * (radius * radius))

let circumference = 2 * pi * radius
print(circumference)

/*:
 Naming simplifies reuse and clarifies meaning. It abstracts away detail. This is essential for building programs step-by-step and storing values in memory—called the **environment**, or more specifically, the **global environment**.

 #### 1.1.3 Evaluating Combinations

 To evaluate a function call:
 1. Evaluate all arguments.
 2. Apply the function to them.
 */

func multiply(_ x: Int, _ y: Int) -> Int {
    x * y
}

func add(_ x: Int, _ y: Int) -> Int {
    x + y
}

let result = multiply(
    add(2, multiply(4, 6)),
    add(add(3, 5), 7)
)

print("Result of nested combination: \(result)")  // 26 * 15 = 390

/*:
 #### 1.1.4 Compound Procedures

 Functions let us name and reuse compound logic:
 */

func square(_ x: Int) -> Int {
    x * x
}

print("square(21) =", square(21))
print("square(square(3)) =", square(square(3)))

func sumOfSquares(_ x: Int, _ y: Int) -> Int {
    square(x) + square(y)
}

print("sumOfSquares(3, 4) =", sumOfSquares(3, 4))

func f(_ a: Int) -> Int {
    sumOfSquares(a + 1, a * 2)
}

print("f(5) =", f(5))  // → 136

/*:
 #### 1.1.5 The Substitution Model for Procedure Application

 The substitution model:
 - Replace parameters with arguments
 - Evaluate the resulting expression

 Example:
 f(5)
 → sumOfSquares(6, 10)
 → square(6) + square(10)
 → 36 + 100 = 136

 This helps reason about programs. In practice, interpreters use environments—not direct substitution.


 **Applicative order versus normal order**

 In Section 1.1.3, we described Swift's evaluation strategy:

 - First, evaluate the **operator** and its **operands**.
 - Then apply the operator to the evaluated operands.

 This is called **applicative-order evaluation**.

 But it's not the only way.

 An alternative model, known as **normal-order evaluation**, delays the evaluation of operands until their values are actually needed. Instead of evaluating arguments up front, it expands the function body by **substituting expressions for parameters**—repeating this until only primitive operations remain, and then reducing.

**Example**

 Consider this function application:

 ```swift
 f(5)
 ```

 Under **normal-order**, it would expand as:

 ```swift
 sumOfSquares(5 + 1, 5 * 2)

 → add(square(5 + 1), square(5 * 2))

 → add(multiply(5 + 1, 5 + 1), multiply(5 * 2, 5 * 2))
 ```

 Then reduce:

 ```swift
 → add(multiply(6, 6), multiply(10, 10))

 → add(36, 100)

 → 136
 ```

 This result matches the applicative-order result, but the **process** differs.

 In **normal-order**, the expressions `5 + 1` and `5 * 2` are evaluated **twice**—once per use. By contrast, **applicative-order** evaluates each argument **once**, up front, and reuses the result.
 */

/*:
**Why Swift Uses Applicative Order**

Swift, like most modern languages, uses **applicative-order evaluation**. There are good reasons:

- **Efficiency**: Avoids redundant work—`(+ 5 1)` is evaluated once, not twice.
- **Practicality**: Normal-order evaluation gets complex quickly, especially for side effects or shared mutable state.
- **Predictability**: Most developers expect left-to-right evaluation and eager application of arguments.

Still, **normal-order evaluation** is powerful. It underlies **lazy evaluation** in functional languages like Haskell, and is key to understanding deferred computation, short-circuit logic, and macros.

We'll explore some of its deeper consequences in Chapter 3 and Chapter 4.16.

 #### 1.1.6 Conditional Expressions and Predicates

With the current tools we have at our disposal there are some more complex tests we cannot perform, such as checking if a numerical value is positive, negative, or zero.

 ```
       ⎧ x   if x > 0
 |x| = ⎨ 0   if x = 0
       ⎩ −x  if x < 0
```

This construct is called case analysis, and in most programming languages — Swift included, there is a specific syntax for notating case analysis.
*/

let value = 0

_ = switch true {
    case value > 0: value
    case value < 0: -value
    default: value
}

/*:
Within a case analysis we start by initialising the `switch` case and passing an expression whose value is interpreted, in the above example the switch case is evaluating the result of the stored variable `value`.

Each `case` marks a possible result, in the example above we are checking to see if the numerical value stored in `value` is positive, negative, or zero. It will step through each case and if the result is true it will end the switch case and return the value within the case section.

In most programming languages, the order of switch case statements does not affect performance because the compiler often optimises them internally, using techniques like jump tables or binary search trees.

An operation whose result is always either `true` or `false` is called a `predicate` also known as a boolean. The term "predicate" is borrowed from logic, where it refers to a statement that expresses a property or relation about one or more variables, e.g. _"x is an even number"_.

There is another, slightly simpler way, to write predicates which is
*/

_ = if value < 0 {
    -value
} else {
    value
}

/*:

The above will check if the result of value is below zero and if it is append a negative sign, else it will return the value as is.

- Note: Swift has a feature called implicit returns, which allows the omission of the `return` keyword if that's the only statement in a block as you can see above it just says `value` instead of `return value`

The above example could be expressed in English as _"If `x` is less than zero return `-x`; otherwise return `x`."_. Else is a special symbol that can be used in place of the final predicate clause.


The final way to write predicate expressions, this version requires there be only two possible outcomes, is known as a _ternary_ statement and looks as follows
*/

_ = value < 0 ? -value : value

/*:
As you can see this is a very concise way of writing predicate statements and is useful for inline contexts, be careful as excessive nesting of ternary statements can become quite hard to read.

In addition to primitive predicates such as `<`, `==`, and `>`, there are logical composition operations, these allow us to construct compound predicates The three most frequently used are `&&`, `||`, and `!` which can be read as `and`, `or` and `not`.

- `and - &&`: The interpreter evaluates the expressions one at a time, left to right order and if any of the expressions are evaluated to false then the rest are not evaluated and the predicate is considered false.
- `or - ||`: The interpreter evaluates the expressions in left to right order and if any of the expressions are true, the entire predicate is considered true.
- `not - !`: The value of a not expression is considered true when the value of the attached predicate evaluates to false.
*/

/// Let's create some values and loop through them
let values = [0, 4, 8, -1, 3, -16, 9]

for value in values {
    // And - &&
    // This statement checks if a number is positive and even
    if value > 0 && value % 2 == 0 {
        print("\(value): value is positive and even") // 4, 8
    }

    // Or - ||
    // This statement checks if either the number is above zero or even
    if value > 0 || value % 2 == 0 {
        print("\(value): value is either positive or even") // 0, 4, 8, 3, -16, 9
    }

    // Not - !
    // This statement checks if the value is below zero
    if !(value > 0) {
        print("\(value): value is under zero") // 0, -1, -16
    }
}


/// **Exercise 1.1*
/// Write the evaluations of the below expressions

// Direct expressions
print(10)  // 10
print(5 + 3 + 4)  // 12
print(9 - 1)  // 8
print(6 / 2)  // 3
print((2 * 4) + (4 - 6))  // 6 - is adding a negative number

// Variable definitions
let a = 3
let b = a + 1

// More complex expressions
print(a + b * (a * b))  // 16
print(a == b)  // false

// Conditional expression (if-then-else)
let result1 = (b > a && b < (a * b)) ? b : a
print(result1)  // 3

// Conditional expression
let result2: Int
switch true {
    case a == 4:
        result2 = 6
    case b == 4:
        result2 = 6 + 7 + a
    default:
        result2 = 25
}
print(result2)  // 16

// Another conditional expression
print(2 + (b > a ? b : a))  // 6

/*:
**Exercise 1.2*

Translate the following expression to Swift
![Exercise 1.2](../Resources/exc-12.svg)
*/

let exprOne = 5 + 4 + (2 - (3 - (6 + 4 / 5)))
let exprTwo = 3 * (6 - 2) * (2 - 7)
let exprResult = exprOne / exprTwo

/*:
**Exercise 1.2**
Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two largest numbers

*/

func sumOfLargestSquaresOriginal(x: Int, y: Int, z: Int) -> Int {
    if x > y && y > z {
       return (x * x) + (y * y)
    }
    if x > y && y < z {
 return       (x * x) + (z * z)
    }
    return (y * y) + (z * z)
}

_ = sumOfLargestSquaresOriginal(x: 8, y: 4, z: 6)

func sumOfLargestSquares(x: Int, y: Int, z: Int) -> Int {
    if x <= y && x <= z {
        return (y * y) + (z * z)  // x is smallest
    } else if y <= x && y <= z {
        return (x * x) + (z * z)  // y is smallest
    } else {
        return (x * x) + (y * y)  // z is smallest
    }
}

_ = sumOfLargestSquares(x: 4, y: 8, z: 4)

func sumOfLargestSquaresStreamlined(x: Int, y: Int, z: Int) -> Int {
    if x > y && y > z {
        return (x * x) + (y * y)
    }
    if x > y && y < z {
        return (x * x) + (z * z)
    }
    return (y * y) + (z * z)
}

_ = sumOfLargestSquaresStreamlined(x: 4, y: 8, z: 6)

/// **Exercise 1.4**
/// Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:
func aPlusAbsB(_ a: Int, _ b: Int) -> Int {
            let operation: (Int, Int) -> Int = b > 0 ? (+) : (-)
    return operation(a, b)
}

/*:
**Exercise 1.5**
## Evaluation: Applicative Order vs Normal Order 

**The Core Problem**
Ben defines two functions:
 - `p()` - an infinitely recursive function
 - `test(x:y:)` - returns 0 if x equals 0, otherwise returns y

The test expression is `test(x: 0, y: p())`

### Applicative Order Evaluation (Eager Evaluation)

Swift uses applicative order evaluation, this means _"evaluate arguments first, then apply the function."_

When Swift encounters `test(x: 0, y: p())`:

1. **Evaluate arguments first:**
  - `x: 0` ✓ (evaluates to 0)
  - `y: p()` ✖️ (begins infinite recursion) 
2. **Result**: Stack Overflow! The program crashes before `test` ever gets called.

**Implementation**
*/ 

func p() -> Never {
    return p()  // Infinite recursion
}

func test(x: Int, y: Int) -> Int {
    x == 0 ? 0 : y
}

// This will crash with Stack Overflow:
// let result = test(x: 0, y: p())

/*:
### Normal Order Evaluation (Lazy Evaluation)

Normal Order evaluation means _"substitute arguments into the function body without evaluating them first, then evaluate only when needed."_

The evaluation would proceed as:

1. **Substitute arguments into function body:**
    - Replace `x` with `0` and `y` with `p()` in the function body.
    - This gives us `if 0 == 0 { return 0 } else { return p() }`
2. **Evaluate this condition:**
    - `0 == 0` is `true`
3. **Take the true branch:**
    - Return `0` immediately
    - **Never evaluate `p()` because it's in the false branch
4. **Result:** `0` returns successfully.

### Simulating Normal Order in Swift

We can simulate lazy evaluation in Swift using closures:
*/

func testLazy(x: Int, y: @autoclosure () -> Int) -> Int {
    x == 0 ? 0 : y() // Only evaluates y if needed
}

// This works fine - returns 0 without calling `p()`
_ = testLazy(x: 0, y: p()) // Diagnostic because `p` isn't type Int, this is okay for demonstration purposes

/*:
**Applicative-Order (Swift's Approach)**

Pros: Predictable performance, arguments evaluated once
Cons: May do unnecessary work, can't handle infinite structures
Behavior: Crashes on test(x: 0, y: p()) due to eager evaluation of p()

**Normal-Order (Lazy Approach)**

Pros: Only computes what's needed, can handle infinite structures
Cons: May re-evaluate expressions multiple times, harder to predict performance
Behavior: Returns 0 for test(x: 0, y: p()) because p() is never evaluated
*/

/*:
## Example: Square Roots by Newton's Method


*/

//: [Next](@next)
