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
    return x * y
}

func add(_ x: Int, _ y: Int) -> Int {
    return x + y
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
    return x * x
}

print("square(21) =", square(21))
print("square(square(3)) =", square(square(3)))

func sumOfSquares(_ x: Int, _ y: Int) -> Int {
    return square(x) + square(y)
}

print("sumOfSquares(3, 4) =", sumOfSquares(3, 4))

func f(_ a: Int) -> Int {
    return sumOfSquares(a + 1, a * 2)
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
*/

/*:
> 🧠 **Summary**:
>
> - **Applicative order**: Evaluate arguments first, then apply the function. (Used by Swift, Lisp, most languages.)
> - **Normal order**: Expand first, evaluate only when needed.
>
> For substitution-based procedures, both yield the same result—**if** evaluation terminates and produces a value.
> But in cases involving infinite loops or side effects, their behavior may diverge. See Exercise 1.5 for an example.
*/

/*:
 #### 1.1.6 Conditional Expressions and Predicates
 
 
 */

//: [Next](@next)
