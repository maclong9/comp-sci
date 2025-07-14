//: [Previous](@previous)
/*:
 # SICP Chapter 4: Metalinguistic Abstraction
 
 This chapter explores how to implement interpreters and compilers, giving us the power to create new programming languages. We'll build evaluators and explore different computational models.
 
 ## 4.1 The Metacircular Evaluator
 
 A **metacircular evaluator** is an interpreter for a programming language written in the same language. This reveals the essential structure of the language itself.
 
 ### 4.1.1 The Core of the Evaluator
 */

import Foundation

// Basic expression types for our mini-language
indirect enum Expression {
    case number(Double)
    case symbol(String)
    case list([Expression])
    case boolean(Bool)
    case procedure([String], Expression, Environment)  // parameters, body, closure environment
}

// Environment for variable bindings
class Environment {
    private var bindings: [String: Expression] = [:]
    private var parent: Environment?
    
    init(parent: Environment? = nil) {
        self.parent = parent
    }
    
    func lookup(_ symbol: String) -> Expression? {
        if let value = bindings[symbol] {
            return value
        }
        return parent?.lookup(symbol)
    }
    
    func define(_ symbol: String, _ value: Expression) {
        bindings[symbol] = value
    }
    
    func extend(with parameters: [String], values: [Expression]) -> Environment {
        let newEnv = Environment(parent: self)
        for (param, value) in zip(parameters, values) {
            newEnv.define(param, value)
        }
        return newEnv
    }
}

/// Evaluates an expression in a given environment using metacircular evaluation.
///
/// This is the core of the metacircular evaluator that handles all expression types
/// including self-evaluating expressions, variables, special forms, and function applications.
///
/// - Parameters:
///   - expression: The expression to evaluate.
///   - environment: The environment containing variable bindings.
/// - Returns: The result of evaluating the expression.
///
/// - Note: This implements the evaluation rules for a Lisp-like language.
func evaluate(_ expression: Expression, in environment: Environment) -> Expression {
    switch expression {
    case .number, .boolean, .procedure:
        return expression  // Self-evaluating
        
    case .symbol(let name):
        guard let value = environment.lookup(name) else {
            fatalError("Undefined variable: \(name)")
        }
        return value
        
    case .list(let elements):
        guard !elements.isEmpty else { return .list([]) }
        
        // Handle special forms
        if case .symbol(let operator) = elements[0] {
            switch operator {
            case "quote":
                return elements[1]
                
            case "if":
                let test = evaluate(elements[1], in: environment)
                if case .boolean(true) = test {
                    return evaluate(elements[2], in: environment)
                } else {
                    return evaluate(elements[3], in: environment)
                }
                
            case "define":
                if case .symbol(let name) = elements[1] {
                    let value = evaluate(elements[2], in: environment)
                    environment.define(name, value)
                    return .symbol("ok")
                }
                
            case "lambda":
                if case .list(let paramExprs) = elements[1] {
                    let parameters = paramExprs.compactMap { expr in
                        if case .symbol(let param) = expr { return param }
                        return nil
                    }
                    return .procedure(parameters, elements[2], environment)
                }
                
            default:
                break
            }
        }
        
        // Function application
        let procedure = evaluate(elements[0], in: environment)
        let arguments = elements.dropFirst().map { evaluate($0, in: environment) }
        
        if case .procedure(let parameters, let body, let closureEnv) = procedure {
            let newEnv = closureEnv.extend(with: parameters, values: Array(arguments))
            return evaluate(body, in: newEnv)
        }
        
        fatalError("Invalid procedure application")
    }
}

// Set up global environment with primitive operations
/// Creates and initializes the global environment with primitive operations.
///
/// This function sets up the base environment containing fundamental operations
/// like arithmetic and comparison functions that form the foundation of the language.
///
/// - Returns: An environment populated with primitive procedures and constants.
func setupGlobalEnvironment() -> Environment {
    let globalEnv = Environment()
    
    // Define primitive procedures
    globalEnv.define("+", .procedure(["x", "y"], .symbol("primitive-add"), globalEnv))
    globalEnv.define("*", .procedure(["x", "y"], .symbol("primitive-multiply"), globalEnv))
    globalEnv.define("=", .procedure(["x", "y"], .symbol("primitive-equal"), globalEnv))
    
    return globalEnv
}

/*:
 ### 4.1.2 Representing Expressions
 
 Our evaluator works with a tree representation of programs, showing the structure more clearly than text.
 */

/// Parses a string representation into an Expression object.
///
/// This simplified parser handles basic literals like numbers, booleans, and symbols.
/// In a complete implementation, this would handle complex s-expressions.
///
/// - Parameter input: The string to parse.
/// - Returns: An Expression representing the parsed input.
///
/// - Note: This is a simplified parser for demonstration purposes.
func parse(_ input: String) -> Expression {
    // Simplified parser for demonstration
    if let number = Double(input) {
        return .number(number)
    }
    
    if input == "true" { return .boolean(true) }
    if input == "false" { return .boolean(false) }
    
    return .symbol(input)
}

/*:
 ### 4.1.3 Evaluator Data Structures
 
 The evaluator maintains environments as chains of frames, supporting lexical scoping.
 */

// Example: Creating and using environments
let globalEnv = setupGlobalEnvironment()
globalEnv.define("x", .number(10))
globalEnv.define("y", .number(5))

let localEnv = globalEnv.extend(with: ["z"], values: [.number(3)])
localEnv.define("w", .number(7))

// Look up variables
if let x = globalEnv.lookup("x") {
    print("Found x: \(x)")
}

/*:
 ## 4.2 Variations on a Scheme — Lazy Evaluation
 
 **Lazy evaluation** delays computation until values are actually needed. This enables working with infinite data structures efficiently.
 
 ### 4.2.1 Normal Order and Applicative Order
 */

// Thunk for delayed evaluation
struct Thunk {
    let expression: Expression
    let environment: Environment
    private var evaluated: Expression?
    private var isEvaluated = false
    
    mutating func force() -> Expression {
        if !isEvaluated {
            evaluated = evaluate(expression, in: environment)
            isEvaluated = true
        }
        return evaluated!
    }
}

/// Creates a thunk for lazy evaluation of an expression.
///
/// This function implements lazy evaluation by deferring computation until the value
/// is actually needed, enabling efficient handling of infinite data structures.
///
/// - Parameters:
///   - expression: The expression to evaluate lazily.
///   - environment: The environment for variable lookup.
/// - Returns: A thunk that can be forced to produce the expression's value.
func lazyEvaluate(_ expression: Expression, in environment: Environment) -> Thunk {
    return Thunk(expression: expression, environment: environment)
}

/*:
 ### 4.2.2 An Interpreter with Lazy Evaluation
 
 Lazy evaluation changes when expressions are evaluated, enabling new programming patterns.
 */

// Stream implementation using lazy evaluation
struct LazyStream<T> {
    let head: T
    let tail: () -> LazyStream<T>?
    
    func take(_ n: Int) -> [T] {
        var result: [T] = []
        var current: LazyStream<T>? = self
        
        for _ in 0..<n {
            guard let stream = current else { break }
            result.append(stream.head)
            current = stream.tail()
        }
        
        return result
    }
}

/// Creates an infinite lazy stream of natural numbers starting from a given value.
///
/// This function demonstrates lazy evaluation by creating an infinite sequence
/// that generates numbers on demand without computing the entire sequence.
///
/// - Parameter n: The starting natural number.
/// - Returns: A lazy stream of consecutive natural numbers.
///
/// - Note: Uses lazy evaluation to handle infinite sequences efficiently.
func naturals(from n: Int) -> LazyStream<Int> {
    return LazyStream(head: n) {
        naturals(from: n + 1)
    }
}

let lazyNaturals = naturals(from: 1)
print("First 5 naturals: \(lazyNaturals.take(5))")

/*:
 ## 4.3 Variations on a Scheme — Nondeterministic Computing
 
 **Nondeterministic computing** allows programs to express ambiguous computations and automatically search for solutions.
 
 ### 4.3.1 Amb and Search
 */

// Simplified amb implementation for demonstration
class AmbEvaluator {
    private var choiceStack: [() -> Any] = []
    
    func amb<T>(_ choices: [T]) -> T {
        guard let first = choices.first else {
            fatalError("No choices available")
        }
        
        if choices.count > 1 {
            // Save continuation for backtracking
            let remaining = Array(choices.dropFirst())
            choiceStack.append { remaining.randomElement()! }
        }
        
        return first
    }
    
    func require(_ condition: Bool) {
        if !condition {
            backtrack()
        }
    }
    
    private func backtrack() {
        guard let continuation = choiceStack.popLast() else {
            fatalError("No more choices")
        }
        // In a real implementation, this would restore the computation state
    }
}

/*:
 ### 4.3.2 Examples of Nondeterministic Programs
 
 Nondeterministic programming enables elegant solutions to constraint satisfaction problems.
 */

/// Demonstrates solving a logic puzzle using nondeterministic programming.
///
/// This function shows how amb (ambiguous choice) and require (constraint)
/// can be used to solve constraint satisfaction problems by automatic search.
///
/// - Note: Uses the AmbEvaluator to explore solution space automatically.
func solvePuzzle() {
    let evaluator = AmbEvaluator()
    
    // Example: Find two numbers that sum to 10
    let a = evaluator.amb([1, 2, 3, 4, 5, 6, 7, 8, 9])
    let b = evaluator.amb([1, 2, 3, 4, 5, 6, 7, 8, 9])
    
    evaluator.require(a + b == 10)
    evaluator.require(a != b)
    
    print("Solution: \(a) + \(b) = 10")
}

/*:
 ## 4.4 Logic Programming
 
 **Logic programming** represents knowledge as facts and rules, allowing queries to be answered through logical inference.
 
 ### 4.4.1 Deductive Information Retrieval
 */

// Simple fact database
struct Fact {
    let predicate: String
    let arguments: [String]
}

struct Rule {
    let conclusion: Fact
    let conditions: [Fact]
}

class LogicDatabase {
    private var facts: [Fact] = []
    private var rules: [Rule] = []
    
    func addFact(_ fact: Fact) {
        facts.append(fact)
    }
    
    func addRule(_ rule: Rule) {
        rules.append(rule)
    }
    
    func query(_ queryFact: Fact) -> Bool {
        // Direct fact matching
        for fact in facts {
            if fact.predicate == queryFact.predicate &&
               fact.arguments == queryFact.arguments {
                return true
            }
        }
        
        // Rule-based inference (simplified)
        for rule in rules {
            if rule.conclusion.predicate == queryFact.predicate {
                // Check if all conditions are satisfied
                let allConditionsSatisfied = rule.conditions.allSatisfy { condition in
                    query(condition)
                }
                if allConditionsSatisfied {
                    return true
                }
            }
        }
        
        return false
    }
}

// Example: Family relationships
let familyDB = LogicDatabase()

// Facts
familyDB.addFact(Fact(predicate: "parent", arguments: ["Adam", "Abel"]))
familyDB.addFact(Fact(predicate: "parent", arguments: ["Adam", "Cain"]))
familyDB.addFact(Fact(predicate: "parent", arguments: ["Eve", "Abel"]))
familyDB.addFact(Fact(predicate: "parent", arguments: ["Eve", "Cain"]))

// Rules
familyDB.addRule(Rule(
    conclusion: Fact(predicate: "sibling", arguments: ["X", "Y"]),
    conditions: [
        Fact(predicate: "parent", arguments: ["Z", "X"]),
        Fact(predicate: "parent", arguments: ["Z", "Y"])
    ]
))

/*:
 ### 4.4.2 How the Query System Works
 
 The logic programming system uses **unification** and **backtracking** to find solutions.
 */

/// Performs unification between a pattern and data, finding variable bindings.
///
/// This algorithm is fundamental to logic programming, matching patterns against
/// data and determining consistent variable bindings.
///
/// - Parameters:
///   - pattern: An array representing the pattern to match (may contain variables).
///   - data: An array representing the concrete data to match against.
/// - Returns: A dictionary of variable bindings if unification succeeds, nil otherwise.
///
/// - Note: Variables are identified by names starting with "?".
func unify(_ pattern: [String], _ data: [String]) -> [String: String]? {
    guard pattern.count == data.count else { return nil }
    
    var bindings: [String: String] = [:]
    
    for (p, d) in zip(pattern, data) {
        if p.hasPrefix("?") {  // Variable
            if let existing = bindings[p], existing != d {
                return nil  // Inconsistent binding
            }
            bindings[p] = d
        } else if p != d {
            return nil  // Literal mismatch
        }
    }
    
    return bindings
}

// Example unification
if let bindings = unify(["parent", "?x", "Abel"], ["parent", "Adam", "Abel"]) {
    print("Unification successful: \(bindings)")
}

/*:
 ## Exercises (Implementation Required)
 
 ### 4.1 Exercises
 - **Exercise 4.1**: Implement left-to-right vs right-to-left evaluation
 - **Exercise 4.2-4.10**: Extending the evaluator with new constructs
 - **Exercise 4.11-4.21**: Analyzing and modifying the evaluator
 
 ### 4.2 Exercises
 - **Exercise 4.22-4.34**: Implementing lazy evaluation
 
 ### 4.3 Exercises
 - **Exercise 4.35-4.49**: Nondeterministic programming exercises
 
 ### 4.4 Exercises
 - **Exercise 4.50-4.79**: Logic programming system implementation
 
 ## Key Takeaways
 
 1. **Metacircular evaluation** reveals the structure of programming languages
 2. **Lazy evaluation** enables efficient computation with infinite data
 3. **Nondeterministic programming** supports automatic search and backtracking
 4. **Logic programming** represents knowledge declaratively through facts and rules
 5. **Interpreters vs compilers** represent different approaches to language implementation
 6. **Language design** involves fundamental choices about evaluation strategies
 7. **Metalinguistic abstraction** provides the ultimate programming power
 */

//: [Next](@next)
