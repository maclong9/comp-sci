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
# CS-01 Computer Programming

Most undergraduate CS programs start with an "introduction" to computer programming. The best versions of these courses cater to both novices and also those who missed beneficial concepts and programming models when first learning to code.

The standard recommendations for this content are _Structure and Interpretation of Computer Programs_ which is available as a [book](https://sarabander.github.io/sicp/html/index.xhtml).

There is also a recommendation of video lectures which is [Brian Harvey's SICP lectures](https://archive.org/details/ucberkeley-webcast-PL3E89002AA9B9879E?sort=titleSorter) for the 61a course at Berkley.

It is recommended to complete these courses as well as the exercises included. You can then improve with additional practice by working through [problems on exercism](http://exercism.io/).

# Structure and Interpretation of Computer Programs

> The programmer must seek both perfection of part and adequacy of collection.

The programming contents of the book are written in Lisp, however, I will be writing in Swift, as the book states: 'Using Lisp we restrict or limit not what we may program, but only the notation for our program descriptions.' The same is true for most—if not all—programming languages.

Every computer program is a model of a real or mental process. These processes are huge in number, intricate in detail, and at any time only partially understood.

Our programs are likely to continually evolve, due to changes as our perception of the model deepens.

Computers must have programs described accurately in every detail. Since large programs grow from small ones it is essential to develop a collection of standard program structures whose correctness is positive.

## 1.0 Building Abstractions with Procedures

The mind exerts power over simple ideas in three ways:

1. Combining several simple ideas into one compound one, this is how complex ideas are made.
2. Bringing two ideas together and working on them as a pair without uniting them into one.
3. Separating them from all other ideas that accompany them. This is abstraction.

**Computational processes** are abstract beings that inhabit computers. As they evolve, processes manipulate other abstract things called **data**. Can be seen as akin to a sorcerers idea of a spirit, it cannot be touch however is very real and can perform intellectual work.

In a correctly working computer a process executes programs precisely and accurately. Even small errors, _bugs_ or _glitches_, can have complex and unanticipated consequences.

> Real world programming requires __care__, __expertise__ and __wisdom__.

Master software engineers have the ability to organize programs so that they can be reasonably sure the resulting processes will perform the tasks intended.

### Programming in Swift

We need a clear and expressive language for describing computational processes, and for this purpose we will use Swift. Just as we use a natural language, such as English, Russian or German, for our everyday speech and mathematics helps us describe quantitative relationships, computational processes are described in a programming language.

Swift gives us the tools to articulate and experiment with procedural thinking. Originally introduced by Apple in 2014, Swift was designed to be safe, modern, and easy to learn, while remaining powerful enough for systems programming and performance-critical applications. Built to replace Objective-C, Swift integrates features from many modern languages, supporting strong type safety, optionals for handling absence of values, closures for functional programming, and a syntax that encourages clear, concise code.

Despite its relatively recent origins, Swift has quickly matured into a practical and widely used language. It supports a broad range of paradigms—including functional, object-oriented, and protocol-oriented programming—which makes it particularly well-suited for exploring diverse approaches to problem-solving. Swift’s focus on safety (like eliminating null-pointer exceptions) and its expressive power (like treating functions as first-class values) make it an excellent language for studying core programming ideas. Moreover, Swift’s growing ecosystem—spanning everything from iOS development to server-side applications—ensures that the concepts we learn will remain relevant in real-world contexts. And perhaps best of all, programming in Swift is genuinely enjoyable.

## 1.1 The Elements of Programming


