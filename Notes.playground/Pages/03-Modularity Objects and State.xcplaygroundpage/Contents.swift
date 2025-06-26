//: [Previous](@previous)
/*:
 # SICP Chapter 3: Modularity, Objects, and State
 
 This chapter explores how to use assignment and mutable data structures to model systems where objects have changing state over time. We'll translate SICP's concepts into Swift's object-oriented and functional programming paradigms.
 
 ## 3.1 Assignment and Local State
 
 When we want to model systems where objects have **state** that changes over time, we need computational objects that can change. An object is said to "have state" if its behavior is influenced by its history.
 
 ### 3.1.1 Local State Variables
 
 Let's start with a simple example - a bank account:
 */

import Foundation

// Functional approach (stateless)
func withdraw(amount: Double, from balance: Double) -> (Double?, Double) {
    if balance >= amount {
        return (amount, balance - amount)
    } else {
        return (nil, balance)
    }
}

var balance: Double = 100
let (withdrawn, newBalance) = withdraw(amount: 50, from: balance)
balance = newBalance

// Object-oriented approach with state
class BankAccount {
    private var balance: Double
    
    init(initialBalance: Double) {
        self.balance = initialBalance
    }
    
    func withdraw(_ amount: Double) -> String {
        if balance >= amount {
            balance -= amount
            return "Withdrew $\(amount). New balance: $\(balance)"
        } else {
            return "Insufficient funds. Balance: $\(balance)"
        }
    }
    
    func deposit(_ amount: Double) -> String {
        balance += amount
        return "Deposited $\(amount). New balance: $\(balance)"
    }
    
    func getBalance() -> Double {
        return balance
    }
}

// Testing the bank account
let myAccount = BankAccount(initialBalance: 100)
print(myAccount.withdraw(50))  // Withdrew $50. New balance: $50
print(myAccount.withdraw(30))  // Withdrew $30. New balance: $20
print(myAccount.withdraw(30))  // Insufficient funds. Balance: $20

/*:
 ### 3.1.2 The Benefits of Introducing Assignment
 
 Assignment allows us to model objects that maintain internal state. This enables more natural modeling of real-world systems.
 */

// Random number generator with state
class RandomGenerator {
    private var seed: UInt64
    
    init(seed: UInt64 = UInt64(Date().timeIntervalSince1970)) {
        self.seed = seed
    }
    
    func nextRandom() -> Double {
        // Linear congruential generator
        seed = (seed &* 1103515245 &+ 12345) & 0x7fffffff
        return Double(seed) / Double(0x7fffffff)
    }
    
    func randomInRange(_ min: Double, _ max: Double) -> Double {
        return min + (max - min) * nextRandom()
    }
}

let randomGen = RandomGenerator(seed: 42)
for _ in 0..<5 {
    print("Random number: \(randomGen.nextRandom())")
}

/*:
 ### 3.1.3 The Costs of Introducing Assignment
 
 With assignment, we can no longer use the **substitution model** for understanding procedures. The introduction of assignment forces us to be concerned with **time** and **identity**.
 
 **Referential transparency** is lost - we can no longer substitute equals for equals.
 */

// Demonstrating loss of referential transparency
func makeWithdrawal(initialBalance: Double) -> (Double) -> String {
    var balance = initialBalance
    
    return { amount in
        if balance >= amount {
            balance -= amount
            return "Remaining balance: $\(balance)"
        } else {
            return "Insufficient funds"
        }
    }
}

let w1 = makeWithdrawal(initialBalance: 100)
let w2 = makeWithdrawal(initialBalance: 100)

// w1 and w2 behave the same initially but diverge after use
print(w1(50))  // Remaining balance: $50
print(w1(25))  // Remaining balance: $25
print(w2(25))  // Remaining balance: $75

// The same expression w1(25) produces different results at different times!

/*:
 ### 3.1.4 Sameness and Change
 
 Assignment forces us to think about what it means for two objects to be "the same". This leads to the concept of **identity** vs **equality**.
 */

// Demonstrating shared vs separate state
class Counter {
    private var count = 0
    
    func increment() {
        count += 1
    }
    
    func getValue() -> Int {
        return count
    }
}

let counter1 = Counter()
let counter2 = Counter()
let counter3 = counter1  // Shared reference

counter1.increment()
counter1.increment()
print("Counter1: \(counter1.getValue())")  // 2
print("Counter2: \(counter2.getValue())")  // 0
print("Counter3: \(counter3.getValue())")  // 2 (same as counter1)

/*:
 ## 3.2 The Environment Model of Evaluation
 
 With the introduction of assignment, we need a new model for understanding procedure application - the **environment model**.
 
 ### 3.2.1 The Rules for Evaluation
 
 An **environment** is a collection of **frames**, and each frame is a table of **bindings** that associate variable names with values.
 */

// Demonstrating scope and environment with closures
func makeAccountGenerator(initialBalance: Double) -> () -> BankAccount {
    var accountNumber = 1000
    
    return {
        accountNumber += 1
        return BankAccount(initialBalance: initialBalance)
    }
}

let accountGenerator = makeAccountGenerator(initialBalance: 100)
let account1 = accountGenerator()
let account2 = accountGenerator()

/*:
 ### 3.2.2 Applying Simple Procedures
 
 When applying a procedure created by a lambda expression, we create a new environment frame.
 */

func makeMonitor() -> (String) -> String {
    var calls: [String] = []
    
    return { message in
        switch message {
        case "how-many-calls?":
            return "Called \(calls.count) times"
        case "reset":
            calls.removeAll()
            return "Reset monitor"
        default:
            calls.append(message)
            return "Recorded: \(message)"
        }
    }
}

let monitor = makeMonitor()
print(monitor("hello"))
print(monitor("world"))
print(monitor("how-many-calls?"))

/*:
 ### 3.2.3 Frames as the Repository of Local State
 
 The environment model shows how local state is maintained in procedure frames.
 */

func makeAccumulator(initialValue: Double) -> (Double) -> Double {
    var sum = initialValue
    
    return { value in
        sum += value
        return sum
    }
}

let accumulator1 = makeAccumulator(initialValue: 5)
let accumulator2 = makeAccumulator(initialValue: 10)

print(accumulator1(10))  // 15
print(accumulator1(10))  // 25
print(accumulator2(10))  // 20
print(accumulator2(10))  // 30

/*:
 ## 3.3 Modeling with Mutable Data
 
 We can use pairs whose contents can be modified to model mutable data structures.
 
 ### 3.3.1 Mutable List Structure
 
 Swift's reference types (classes) provide mutable behavior similar to Scheme's `set-car!` and `set-cdr!`:
 */

// Mutable linked list implementation
class MutableListNode<T> {
    var value: T
    var next: MutableListNode<T>?
    
    init(_ value: T, next: MutableListNode<T>? = nil) {
        self.value = value
        self.next = next
    }
}

class MutableList<T> {
    var head: MutableListNode<T>?
    
    func append(_ value: T) {
        let newNode = MutableListNode(value)
        if let head = head {
            var current = head
            while current.next != nil {
                current = current.next!
            }
            current.next = newNode
        } else {
            head = newNode
        }
    }
    
    func setCar(_ newValue: T) {
        head?.value = newValue
    }
    
    func setCdr(_ newNext: MutableListNode<T>?) {
        head?.next = newNext
    }
    
    func display() -> String {
        var result = "("
        var current = head
        while current != nil {
            result += "\(current!.value)"
            current = current!.next
            if current != nil {
                result += " "
            }
        }
        result += ")"
        return result
    }
}

// Demonstrating sharing and mutation
let list1 = MutableList<Int>()
list1.append(1)
list1.append(2)

let list2 = MutableList<Int>()
list2.head = list1.head  // Share the structure

print("Before mutation:")
print("List1: \(list1.display())")
print("List2: \(list2.display())")

list1.setCar(3)  // Modify the shared structure

print("After mutation:")
print("List1: \(list1.display())")
print("List2: \(list2.display())")  // Also affected!

/*:
 ### 3.3.2 Representing Queues
 
 A queue can be efficiently implemented using a pair of pointers:
 */

class Queue<T> {
    private var frontPtr: MutableListNode<T>?
    private var rearPtr: MutableListNode<T>?
    
    var isEmpty: Bool {
        return frontPtr == nil
    }
    
    func enqueue(_ item: T) {
        let newNode = MutableListNode(item)
        if isEmpty {
            frontPtr = newNode
            rearPtr = newNode
        } else {
            rearPtr?.next = newNode
            rearPtr = newNode
        }
    }
    
    func dequeue() -> T? {
        guard let front = frontPtr else { return nil }
        
        let item = front.value
        frontPtr = front.next
        if frontPtr == nil {
            rearPtr = nil
        }
        return item
    }
    
    func peek() -> T? {
        return frontPtr?.value
    }
    
    func display() -> String {
        var result = "Queue: ["
        var current = frontPtr
        while current != nil {
            result += "\(current!.value)"
            current = current!.next
            if current != nil {
                result += ", "
            }
        }
        result += "]"
        return result
    }
}

// Testing the queue
let queue = Queue<String>()
queue.enqueue("a")
queue.enqueue("b")
queue.enqueue("c")
print(queue.display())

print("Dequeued: \(queue.dequeue() ?? "nil")")
print(queue.display())

/*:
 ### 3.3.3 Representing Tables
 
 Tables can be implemented as lists of key-value pairs:
 */

class Table<Key: Hashable, Value> {
    private var records: [(Key, Value)] = []
    
    func lookup(_ key: Key) -> Value? {
        for (k, v) in records {
            if k == key {
                return v
            }
        }
        return nil
    }
    
    func insert(_ key: Key, _ value: Value) {
        // Update existing key or add new record
        for i in 0..<records.count {
            if records[i].0 == key {
                records[i] = (key, value)
                return
            }
        }
        records.append((key, value))
    }
    
    func display() -> String {
        return "Table: \(records.map { "(\($0.0): \($0.1))" }.joined(separator: ", "))"
    }
}

// Two-dimensional table
class TwoDTable<Key1: Hashable, Key2: Hashable, Value> {
    private var table = Table<Key1, Table<Key2, Value>>()
    
    func lookup(_ key1: Key1, _ key2: Key2) -> Value? {
        if let subtable = table.lookup(key1) {
            return subtable.lookup(key2)
        }
        return nil
    }
    
    func insert(_ key1: Key1, _ key2: Key2, _ value: Value) {
        if let subtable = table.lookup(key1) {
            subtable.insert(key2, value)
        } else {
            let newSubtable = Table<Key2, Value>()
            newSubtable.insert(key2, value)
            table.insert(key1, newSubtable)
        }
    }
}

// Testing tables
let mathTable = TwoDTable<String, String, Double>()
mathTable.insert("add", "3", 8)      // 3 + 5 = 8
mathTable.insert("add", "5", 10)     // 5 + 5 = 10
mathTable.insert("mul", "3", 15)     // 3 * 5 = 15

print("add 3: \(mathTable.lookup("add", "3") ?? 0)")
print("mul 3: \(mathTable.lookup("mul", "3") ?? 0)")

/*:
 ### 3.3.4 A Simulator for Digital Circuits
 
 We can build a digital circuit simulator to demonstrate event-driven simulation:
 */

// Basic wire implementation
class Wire {
    private var signal: Bool = false
    private var actions: [(Bool) -> Void] = []
    
    var signalValue: Bool {
        return signal
    }
    
    func setSignal(_ newSignal: Bool) {
        if signal != newSignal {
            signal = newSignal
            // Call all procedures in action list
            for action in actions {
                action(signal)
            }
        }
    }
    
    func addAction(_ action: @escaping (Bool) -> Void) {
        actions.append(action)
        action(signal)  // Run action immediately with current signal
    }
}

// Basic logic gates
func inverter(input: Wire, output: Wire, delay: TimeInterval) {
    input.addAction { signal in
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            output.setSignal(!signal)
        }
    }
}

func andGate(a1: Wire, a2: Wire, output: Wire, delay: TimeInterval) {
    let action = {
        let newSignal = a1.signalValue && a2.signalValue
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            output.setSignal(newSignal)
        }
    }
    
    a1.addAction { _ in action() }
    a2.addAction { _ in action() }
}

func orGate(o1: Wire, o2: Wire, output: Wire, delay: TimeInterval) {
    let action = {
        let newSignal = o1.signalValue || o2.signalValue
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            output.setSignal(newSignal)
        }
    }
    
    o1.addAction { _ in action() }
    o2.addAction { _ in action() }
}

// Half adder implementation
func halfAdder(a: Wire, b: Wire, sum: Wire, carry: Wire) {
    let d = Wire()
    let e = Wire()
    
    orGate(o1: a, o2: b, output: d, delay: 0.05)
    andGate(a1: a, a2: b, output: carry, delay: 0.03)
    inverter(input: carry, output: e, delay: 0.02)
    andGate(a1: d, a2: e, output: sum, delay: 0.03)
}

// Full adder implementation
func fullAdder(a: Wire, b: Wire, cIn: Wire, sum: Wire, cOut: Wire) {
    let s = Wire()
    let c1 = Wire()
    let c2 = Wire()
    
    halfAdder(a: b, b: cIn, sum: s, carry: c1)
    halfAdder(a: a, b: s, sum: sum, carry: c2)
    orGate(o1: c1, o2: c2, output: cOut, delay: 0.05)
}

/*:
 ## 3.4 Concurrency: Time Is of the Essence
 
 When systems have state that changes over time, the temporal order becomes crucial, especially in concurrent systems.
 
 ### 3.4.1 The Nature of Time in Concurrent Systems
 
 Concurrent programming introduces complexities related to timing and coordination:
 */

// Demonstrating race conditions
class SharedCounter {
    private var count = 0
    private let lock = NSLock()
    
    func increment() {
        // Without synchronization, this could cause race conditions
        lock.lock()
        let temp = count
        count = temp + 1
        lock.unlock()
    }
    
    func getValue() -> Int {
        lock.lock()
        let value = count
        lock.unlock()
        return value
    }
}

// Safe concurrent operations using DispatchQueue
func safeConcurrentExample() {
    let counter = SharedCounter()
    let queue = DispatchQueue.global(qos: .userInitiated)
    
    for _ in 0..<1000 {
        queue.async {
            counter.increment()
        }
    }
    
    queue.sync {
        print("Final count: \(counter.getValue())")
    }
}

/*:
 ### 3.4.2 Mechanisms for Controlling Concurrency
 
 Swift provides several mechanisms for safe concurrent programming:
 */

// Using DispatchQueue for serialization
class SerializedBankAccount {
    private var balance: Double
    private let serialQueue = DispatchQueue(label: "account.serial")
    
    init(initialBalance: Double) {
        self.balance = initialBalance
    }
    
    func withdraw(_ amount: Double, completion: @escaping (String) -> Void) {
        serialQueue.async {
            if self.balance >= amount {
                self.balance -= amount
                completion("Withdrew $\(amount). Balance: $\(self.balance)")
            } else {
                completion("Insufficient funds. Balance: $\(self.balance)")
            }
        }
    }
    
    func transfer(to otherAccount: SerializedBankAccount, amount: Double, completion: @escaping (String) -> Void) {
        self.withdraw(amount) { result in
            if result.contains("Withdrew") {
                otherAccount.deposit(amount) { _ in
                    completion("Transfer completed: \(result)")
                }
            } else {
                completion("Transfer failed: \(result)")
            }
        }
    }
    
    func deposit(_ amount: Double, completion: @escaping (String) -> Void) {
        serialQueue.async {
            self.balance += amount
            completion("Deposited $\(amount). Balance: $\(self.balance)")
        }
    }
}

/*:
 ## 3.5 Streams
 
 **Streams** are a powerful abstraction that allows us to model infinite sequences and support elegant and efficient composition of programs.
 
 ### 3.5.1 Streams Are Delayed Lists
 
 A stream is a lazily evaluated list where elements are computed only when needed:
 */

// Swift implementation of streams using lazy evaluation
struct Stream<Element> {
    private let head: () -> Element
    private let tail: () -> Stream<Element>?
    
    init(head: @escaping () -> Element, tail: @escaping () -> Stream<Element>?) {
        self.head = head
        self.tail = tail
    }
    
    var first: Element {
        return head()
    }
    
    var rest: Stream<Element>? {
        return tail()
    }
    
    func take(_ n: Int) -> [Element] {
        var result: [Element] = []
        var current: Stream<Element>? = self
        
        for _ in 0..<n {
            guard let stream = current else { break }
            result.append(stream.first)
            current = stream.rest
        }
        
        return result
    }
}

// Infinite stream of integers
func integers(startingFrom n: Int) -> Stream<Int> {
    return Stream(
        head: { n },
        tail: { integers(startingFrom: n + 1) }
    )
}

// Stream of Fibonacci numbers
func fibonacciStream() -> Stream<Int> {
    func fibHelper(a: Int, b: Int) -> Stream<Int> {
        return Stream(
            head: { a },
            tail: { fibHelper(a: b, b: a + b) }
        )
    }
    return fibHelper(a: 0, b: 1)
}

// Testing streams
let intStream = integers(startingFrom: 1)
print("First 10 integers: \(intStream.take(10))")

let fibStream = fibonacciStream()
print("First 10 Fibonacci numbers: \(fibStream.take(10))")

/*:
 ### 3.5.2 Infinite Streams
 
 Streams allow us to work with infinite sequences naturally:
 */

// Sieve of Eratosthenes using streams
func sieve(_ stream: Stream<Int>) -> Stream<Int> {
    let first = stream.first
    return Stream(
        head: { first },
        tail: {
            guard let rest = stream.rest else { return nil }
            return sieve(filterStream(rest) { $0 % first != 0 })
        }
    )
}

func filterStream<T>(_ stream: Stream<T>, _ predicate: @escaping (T) -> Bool) -> Stream<T>? {
    var current: Stream<T>? = stream
    
    while let str = current {
        if predicate(str.first) {
            return Stream(
                head: { str.first },
                tail: {
                    guard let rest = str.rest else { return nil }
                    return filterStream(rest, predicate)
                }
            )
        }
        current = str.rest
    }
    
    return nil
}

let primes = sieve(integers(startingFrom: 2))
print("First 10 primes: \(primes.take(10))")

/*:
 ### 3.5.3 Exploiting the Stream Paradigm
 
 Streams enable elegant solutions to complex problems:
 */

// Stream of random numbers
func randomStream(seed: UInt64) -> Stream<Double> {
    var currentSeed = seed
    return Stream(
        head: {
            currentSeed = (currentSeed &* 1103515245 &+ 12345) & 0x7fffffff
            return Double(currentSeed) / Double(0x7fffffff)
        },
        tail: { randomStream(seed: currentSeed) }
    )
}

// Monte Carlo estimation using streams
func monteCarlo(_ experiment: @escaping () -> Bool) -> Stream<Double> {
    func helper(passed: Int, trials: Int) -> Stream<Double> {
        let result = experiment()
        let newPassed = passed + (result ? 1 : 0)
        let newTrials = trials + 1
        
        return Stream(
            head: { Double(newPassed) / Double(newTrials) },
            tail: { helper(passed: newPassed, trials: newTrials) }
        )
    }
    
    return helper(passed: 0, trials: 0)
}

/*:
 ## Exercises (Implementation Required)
 
 ### 3.1 Exercises
 - **Exercise 3.1**: Implement make-accumulator that returns a procedure
 - **Exercise 3.2**: Implement make-monitored procedure
 - **Exercise 3.3**: Implement make-account with password protection
 - **Exercise 3.4**: Add call-the-cops feature to account
 - **Exercise 3.5-3.8**: Various environment model exercises
 
 ### 3.2 Exercises
 - **Exercise 3.9-3.11**: Environment model analysis exercises
 - **Exercise 3.12-3.14**: List structure and mutation exercises
 
 ### 3.3 Exercises
 - **Exercise 3.15-3.20**: Mutable data structure exercises
 - **Exercise 3.21-3.23**: Queue implementation exercises
 - **Exercise 3.24-3.27**: Table implementation exercises
 - **Exercise 3.28-3.32**: Digital circuit simulator exercises
 
 ### 3.4 Exercises
 - **Exercise 3.33-3.37**: Constraint system exercises
 - **Exercise 3.38**: Concurrency exercises
 - **Exercise 3.39-3.49**: Serialization and deadlock exercises
 
 ### 3.5 Exercises
 - **Exercise 3.50-3.62**: Stream processing exercises
 - **Exercise 3.63-3.76**: Infinite streams and delayed evaluation
 - **Exercise 3.77-3.82**: Stream paradigm applications
 
 ## Key Takeaways
 
 1. **Assignment and state** enable modeling of objects that change over time
 2. **Environment model** replaces substitution model for stateful computation
 3. **Mutable data structures** provide flexible modeling capabilities
 4. **Concurrency** introduces timing complexities that require careful coordination
 5. **Streams** offer elegant solutions for infinite sequences and lazy evaluation
 6. **Time and identity** become central concerns when introducing state
 7. **Functional vs imperative** programming represent different computational paradigms
 */

//: [Next](@next)
