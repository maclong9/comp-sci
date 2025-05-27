import Foundation

//: [Previous](@previous)
/*:
 # CS-01 Computer Programming

 Most undergraduate CS programs start with an "introduction" to computer
 programming. The best versions of these courses cater to both novices and also
 those who missed beneficial concepts and programming models when first learning
 to code.

 The standard recommendations for this content are _Structure and Interpretation
 of Computer Programs_ which is available as a
 [book](https://sarabander.github.io/sicp/html/index.xhtml).

 There is also a recommendation of video lectures which is [Brian Harvey's SICP
 lectures](https://archive.org/details/ucberkeley-webcast-PL3E89002AA9B9879E?sort=titleSorter)
 for the 61a course at Berkley.

 It is recommended to complete these courses as well as the exercises included.
 You can then improve with additional practice by working through [problems on
 exercism](http://exercism.io/).

 # Structure and Interpretation of Computer Programs

 > The programmer must seek both perfection of part and adequacy of collection.

The programming contents of the book are written in Lisp, however, I will be
writing in Swift, as the book states: 'Using Lisp we restrict or limit not what
we may program, but only the notation for our program descriptions.' The same is
true for most—if not all—programming languages.

Every computer program is a model of a real or mental process. These processes
are huge in number, intricate in detail, and at any time only partially
understood.

Our programs are likely to continually evolve, due to changes as our perception
of the model deepens.

Computers must have programs described accurately in every detail. Since large
programs grow from small ones it is essential to develop a collection of
standard program structures whose correctness is positive.

## 1.0 Building Abstractions with Procedures

The mind exerts power over simple ideas in three ways: 1. Combining several
simple ideas into one compound one, this is how complex ideas are made. 2.
Bringing two ideas together and working on them as a pair without uniting them
into one. 3. Separating them from all other ideas that accompany them. This is
abstraction.

**Computational processes** are abstract beings that inhabit computers. As they
evolve, processes manipulate other abstract things called **data**. Can be seen
as akin to a sorcerers idea of a spirit, it cannot be touch however is very real
and can perform intellectual work.

In a correctly working computer a process executes programs precisely and
accurately. Even small errors, _bugs_ or _glitches_, can have complex and
unanticipated consequences.

> Real world programming requires __care__, __expertise__ and __wisdom__.

Master software engineers have the ability to organize programs so that they can
be reasonably sure the resulting processes will perform the tasks intended.

### Programming in Swift

We need a clear and expressive language for describing computational processes,
and for this purpose we will use Swift. Just as we use a natural language, such
as English, Russian or German, for our everyday speech and mathematics helps us
describe quantitative relationships, computational processes are described in a
programming language.

Swift gives us the tools to articulate and experiment with procedural thinking.
Originally introduced by Apple in 2014, Swift was designed to be safe, modern,
and easy to learn, while remaining powerful enough for systems programming and
performance-critical applications. Built to replace Objective-C, Swift
integrates features from many modern languages, supporting strong type safety,
optionals for handling absence of values, closures for functional programming,
and a syntax that encourages clear, concise code.

Despite its relatively recent origins, Swift has quickly matured into a
practical and widely used language. It supports a broad range of
paradigms—including functional, object-oriented, and protocol-oriented
programming—which makes it particularly well-suited for exploring diverse
approaches to problem-solving. Swift’s focus on safety (like eliminating
null-pointer exceptions) and its expressive power (like treating functions as
first-class values) make it an excellent language for studying core programming
ideas. Moreover, Swift’s growing ecosystem—spanning everything from iOS
development to server-side applications—ensures that the concepts we learn will
remain relevant in real-world contexts. And perhaps best of all, programming in
Swift is genuinely enjoyable.

## 1.1 The Elements of Programming

A powerful programming language is more than just a means of instructing a
computer, it also serves as a framework within which we can realize and
iterate upon ideas. We should pay attention to the way the language allows for combining simple ideas to form more complex ideas.

Every powerful language has three mechanisms for accomplishing this:
    - **Primitive Expressions**, which represent simple entities the language is concerned with.
    - **Means of Combination, by which compound elements are built from simpler ones.
    - **Means of Abstraction**, by which compound elements can be named and manipulated as units.

In programming we deal wiht _procedures_ and _data_. Informally _data_ is "stuff" that we want to manipulate, and _procedures_ are descriptions of rules for maniuplating the _data_.

> A powerful programming language should be able to describe primitive _data_ and should have methods for combining and abstracting _procedures_ and _data_.

 In this chapter we deal with only simple numerical data, this ensures we can focus on the rules for building _procedures_.

 ### 1.1.1 Expressions

 When you type an _expression_ the interpreter responds by displaying the result of evaluation of that expression.

 A common primitive is a number, written in base 10.
*/

print(486)

/*:
Given the snippet of code above the interperter will respond by printing the number `486` to the console.

 Expressions representing numbers may be combined with simple arithmetic operations.
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
 Above is a simple example of combining primitives, the numrical valus and mathematical operators, to create a more complex expression. There is also a slightly more complex example using the `reduce` method to apply the same operators to an array of numbers.

 Even with complex expressions the interpreter operates in the same basic cycle:
    1. Reads the expression.
    2. Evaluates the expression.
    3. Prints the result.

 This mode of operation is often expressed by saying the interpreter runs in a _read-eval-print loop`, sometimes shortened to _repl_. You can start a Swift _repl_ inside of your terminal by running `swift repl`, once this has started you can enter any Swift expression, such as the arithmetic `print` statements above and it will evaluate the expression and print the result.

 ### 1.1.2 Naming & the Environment

 A critical aspect of a programming language is the means it provides for using names to refer to computational objects. In English we would say the name identifies a _variable_ whose _value_ is the object.
 */

let size = 2

/*:
 The above code causes the interpreter to associate the value `2` with the name `size`. Once the name `size` has been associated with the number `2` we can refer to `2` by name:
 */

print(size)
print(5 * size)

/*:
> Note: `let` defines a constant which cannot be reassigned and `var` defines a variable which has a value that can change.

 Below are some more examples of defining values:
 */

let pi = 3.14159
let radius = 10.0

print(pi * (radius * radius))

let circumfrence = 2 * pi * radius

print(circumfrence)

/*:
 
 */
//: [Next](@next)
