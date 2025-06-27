//: [Previous](@previous)
/*:
 # SICP Chapter 5: Computing with Register Machines
 
 This chapter bridges the gap between high-level computational thinking and the physical realities of computer implementation. We'll explore register machines, compilation, and the relationship between software and hardware.
 
 ## 5.1 Designing Register Machines
 
 A **register machine** is an abstract model of computation that manipulates data stored in named registers using primitive operations.
 
 ### 5.1.1 A Language for Describing Register Machines
 */

import Foundation

// Register machine implementation
class RegisterMachine {
    private var registers: [String: Any] = [:]
    private var stack: [Any] = []
    private var pc: Int = 0  // Program counter
    private var instructions: [Instruction] = []
    private var isRunning = false
    
    enum Instruction {
        case assign(register: String, operation: () -> Any)
        case test(condition: () -> Bool)
        case branch(label: String)
        case goto(label: String)
        case save(register: String)
        case restore(register: String)
        case perform(operation: () -> Void)
        case label(String)
    }
    
    func setRegister(_ name: String, _ value: Any) {
        registers[name] = value
    }
    
    func getRegister(_ name: String) -> Any? {
        return registers[name]
    }
    
    func addInstruction(_ instruction: Instruction) {
        instructions.append(instruction)
    }
    
    func run() {
        isRunning = true
        pc = 0
        
        while isRunning && pc < instructions.count {
            executeInstruction(instructions[pc])
            pc += 1
        }
    }
    
    private func executeInstruction(_ instruction: Instruction) {
        switch instruction {
        case .assign(let register, let operation):
            registers[register] = operation()
            
        case .test(let condition):
            registers["flag"] = condition()
            
        case .branch(let label):
            if let flag = registers["flag"] as? Bool, flag {
                jumpToLabel(label)
            }
            
        case .goto(let label):
            jumpToLabel(label)
            
        case .save(let register):
            if let value = registers[register] {
                stack.append(value)
            }
            
        case .restore(let register):
            if !stack.isEmpty {
                registers[register] = stack.removeLast()
            }
            
        case .perform(let operation):
            operation()
            
        case .label:
            break  // Labels don't execute
        }
    }
    
    private func jumpToLabel(_ label: String) {
        for (index, instruction) in instructions.enumerated() {
            if case .label(let instructionLabel) = instruction, instructionLabel == label {
                pc = index - 1  // -1 because pc will be incremented
                return
            }
        }
    }
    
    func stop() {
        isRunning = false
    }
}

/*:
 ### 5.1.2 Abstraction in Machine Design
 
 Let's implement a factorial machine to demonstrate register machine concepts:
 */

/// Creates a register machine that computes factorial using iterative process.
///
/// This function demonstrates how high-level algorithms can be implemented
/// as register machine programs with explicit state management.
///
/// - Returns: A configured register machine that computes 5! = 120.
///
/// - Note: Uses registers for n, product, and counter with iterative algorithm.
func createFactorialMachine() -> RegisterMachine {
    let machine = RegisterMachine()
    
    // Initialize registers
    machine.setRegister("n", 5)
    machine.setRegister("product", 1)
    machine.setRegister("counter", 1)
    
    // Instructions for computing factorial
    machine.addInstruction(.label("test-counter"))
    machine.addInstruction(.test {
        let counter = machine.getRegister("counter") as? Int ?? 0
        let n = machine.getRegister("n") as? Int ?? 0
        return counter > n
    })
    machine.addInstruction(.branch(label: "factorial-done"))
    machine.addInstruction(.assign(register: "product") {
        let product = machine.getRegister("product") as? Int ?? 1
        let counter = machine.getRegister("counter") as? Int ?? 1
        return product * counter
    })
    machine.addInstruction(.assign(register: "counter") {
        let counter = machine.getRegister("counter") as? Int ?? 1
        return counter + 1
    })
    machine.addInstruction(.goto(label: "test-counter"))
    machine.addInstruction(.label("factorial-done"))
    machine.addInstruction(.perform {
        machine.stop()
    })
    
    return machine
}

// Test the factorial machine
let factorialMachine = createFactorialMachine()
factorialMachine.run()
if let result = factorialMachine.getRegister("product") as? Int {
    print("Factorial result: \(result)")
}

/*:
 ### 5.1.3 Subroutines
 
 Subroutines allow code reuse and modular design in register machines:
 */

/// Creates a register machine that computes the greatest common divisor.
///
/// This function implements Euclid's algorithm as a register machine program,
/// demonstrating how mathematical algorithms translate to low-level operations.
///
/// - Returns: A configured register machine that computes GCD of 48 and 18.
///
/// - Note: Uses the classic Euclidean algorithm with remainder operations.
func createGCDMachine() -> RegisterMachine {
    let machine = RegisterMachine()
    
    machine.setRegister("a", 48)
    machine.setRegister("b", 18)
    
    machine.addInstruction(.label("gcd-loop"))
    machine.addInstruction(.test {
        let b = machine.getRegister("b") as? Int ?? 0
        return b == 0
    })
    machine.addInstruction(.branch(label: "gcd-done"))
    machine.addInstruction(.assign(register: "t") {
        let a = machine.getRegister("a") as? Int ?? 0
        let b = machine.getRegister("b") as? Int ?? 0
        return a % b
    })
    machine.addInstruction(.assign(register: "a") {
        return machine.getRegister("b") ?? 0
    })
    machine.addInstruction(.assign(register: "b") {
        return machine.getRegister("t") ?? 0
    })
    machine.addInstruction(.goto(label: "gcd-loop"))
    machine.addInstruction(.label("gcd-done"))
    machine.addInstruction(.perform {
        machine.stop()
    })
    
    return machine
}

/*:
 ## 5.2 A Register-Machine Simulator
 
 We can build a simulator that executes register machine programs, providing insight into low-level computation.
 
 ### 5.2.1 The Machine Model
 */

// Enhanced register machine with simulation capabilities
class RegisterMachineSimulator {
    private var registers: [String: Any] = [:]
    private var stack: [Any] = []
    private var labels: [String: Int] = [:]
    private var instructions: [String] = []
    private var pc = 0
    private var instructionCount = 0
    
    func installInstructions(_ program: [String]) {
        instructions = program
        buildLabelTable()
    }
    
    private func buildLabelTable() {
        labels.removeAll()
        for (index, instruction) in instructions.enumerated() {
            if instruction.hasPrefix("label:") {
                let label = String(instruction.dropFirst(6).trimmingCharacters(in: .whitespaces))
                labels[label] = index
            }
        }
    }
    
    func setRegisterValue(_ name: String, _ value: Any) {
        registers[name] = value
    }
    
    func getRegisterValue(_ name: String) -> Any? {
        return registers[name]
    }
    
    func start() {
        pc = 0
        instructionCount = 0
        
        while pc < instructions.count {
            let instruction = instructions[pc]
            instructionCount += 1
            executeInstruction(instruction)
            pc += 1
        }
        
        print("Executed \(instructionCount) instructions")
    }
    
    private func executeInstruction(_ instruction: String) {
        let parts = instruction.components(separatedBy: " ")
        guard !parts.isEmpty else { return }
        
        switch parts[0] {
        case "assign":
            // Simplified assignment
            break
        case "goto":
            if parts.count > 1, let targetPc = labels[parts[1]] {
                pc = targetPc - 1  // -1 because pc will be incremented
            }
        case "branch":
            // Simplified branch
            break
        default:
            break
        }
    }
}

/*:
 ### 5.2.2 The Assembler
 
 An assembler translates symbolic instructions into machine-executable form:
 */

class SimpleAssembler {
    func assemble(_ source: String) -> [String] {
        return source.components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty && !$0.hasPrefix(";") }  // Remove empty lines and comments
    }
    
    func optimizeInstructions(_ instructions: [String]) -> [String] {
        // Simple optimization: remove consecutive labels
        var optimized: [String] = []
        var lastWasLabel = false
        
        for instruction in instructions {
            let isLabel = instruction.hasPrefix("label:")
            if !(isLabel && lastWasLabel) {
                optimized.append(instruction)
            }
            lastWasLabel = isLabel
        }
        
        return optimized
    }
}

/*:
 ### 5.2.3 Monitoring Machine Performance
 
 Performance monitoring helps understand computational efficiency:
 */

class PerformanceMonitor {
    private var instructionCounts: [String: Int] = [:]
    private var registerAccesses: [String: Int] = [:]
    private var totalInstructions = 0
    
    func recordInstruction(_ instruction: String) {
        totalInstructions += 1
        let opcode = instruction.components(separatedBy: " ").first ?? instruction
        instructionCounts[opcode, default: 0] += 1
    }
    
    func recordRegisterAccess(_ register: String) {
        registerAccesses[register, default: 0] += 1
    }
    
    func printStatistics() {
        print("Total instructions executed: \(totalInstructions)")
        print("Instruction breakdown:")
        for (instruction, count) in instructionCounts.sorted(by: { $0.value > $1.value }) {
            print("  \(instruction): \(count)")
        }
        print("Register access frequency:")
        for (register, count) in registerAccesses.sorted(by: { $0.value > $1.value }) {
            print("  \(register): \(count)")
        }
    }
}

/*:
 ## 5.3 Storage Allocation and Garbage Collection
 
 Managing memory is crucial for efficient computation. We'll explore allocation strategies and garbage collection.
 
 ### 5.3.1 Memory as Vectors
 */

// Simple memory manager
class MemoryManager {
    private var memory: [Any?] = Array(repeating: nil, count: 1000)
    private var freeList: [Int] = []
    private var nextAllocation = 0
    
    init() {
        // Initialize free list
        for i in 0..<memory.count {
            freeList.append(i)
        }
    }
    
    func allocate() -> Int? {
        if !freeList.isEmpty {
            return freeList.removeFirst()
        }
        
        if nextAllocation < memory.count {
            let address = nextAllocation
            nextAllocation += 1
            return address
        }
        
        return nil  // Out of memory
    }
    
    func deallocate(_ address: Int) {
        guard address >= 0 && address < memory.count else { return }
        memory[address] = nil
        freeList.append(address)
    }
    
    func store(_ value: Any, at address: Int) {
        guard address >= 0 && address < memory.count else { return }
        memory[address] = value
    }
    
    func load(from address: Int) -> Any? {
        guard address >= 0 && address < memory.count else { return nil }
        return memory[address]
    }
    
    func garbageCollect() {
        // Mark and sweep garbage collection (simplified)
        var reachable: Set<Int> = []
        markReachable(from: 0, visited: &reachable)  // Start from root
        
        for i in 0..<memory.count {
            if !reachable.contains(i) && memory[i] != nil {
                deallocate(i)
            }
        }
        
        print("Garbage collection completed. Freed \(memory.count - reachable.count) objects")
    }
    
    private func markReachable(from address: Int, visited: inout Set<Int>) {
        if visited.contains(address) || address < 0 || address >= memory.count {
            return
        }
        
        visited.insert(address)
        
        // In a real implementation, we would traverse object references
        // This is a simplified version
    }
}

/*:
 ### 5.3.2 Maintaining the Illusion of Infinite Memory
 
 Garbage collection allows programs to behave as if they have unlimited memory:
 */

// Cons cell implementation with garbage collection
class ConsCell {
    let car: Any
    let cdr: Any
    
    init(car: Any, cdr: Any) {
        self.car = car
        self.cdr = cdr
    }
}

class LispHeap {
    private var memoryManager = MemoryManager()
    private var consTable: [Int: ConsCell] = [:]
    
    func cons(_ car: Any, _ cdr: Any) -> Int? {
        guard let address = memoryManager.allocate() else {
            // Trigger garbage collection and try again
            garbageCollect()
            return memoryManager.allocate()
        }
        
        let cell = ConsCell(car: car, cdr: cdr)
        consTable[address] = cell
        return address
    }
    
    func car(of address: Int) -> Any? {
        return consTable[address]?.car
    }
    
    func cdr(of address: Int) -> Any? {
        return consTable[address]?.cdr
    }
    
    private func garbageCollect() {
        print("Running garbage collection...")
        memoryManager.garbageCollect()
        
        // Remove unreachable cons cells
        let reachableAddresses = Set(consTable.keys)  // Simplified
        for address in consTable.keys {
            if !reachableAddresses.contains(address) {
                consTable.removeValue(forKey: address)
            }
        }
    }
}

/*:
 ## 5.4 The Explicit-Control Evaluator
 
 We can implement a Scheme evaluator using register machine techniques, making the evaluation process explicit.
 
 ### 5.4.1 The Core of the Explicit-Control Evaluator
 */

// Simplified explicit-control evaluator
class ExplicitControlEvaluator {
    private var exp: Any = ""
    private var env: Any = ""
    private var val: Any = ""
    private var proc: Any = ""
    private var argl: [Any] = []
    private var stack: [Any] = []
    private var pc = "eval-dispatch"
    
    func evaluate(_ expression: Any, environment: Any) -> Any {
        exp = expression
        env = environment
        pc = "eval-dispatch"
        
        while true {
            switch pc {
            case "eval-dispatch":
                pc = evaluateDispatch()
            case "eval-self-eval":
                pc = evaluateSelfEval()
            case "eval-variable":
                pc = evaluateVariable()
            case "eval-application":
                pc = evaluateApplication()
            case "apply-dispatch":
                pc = applyDispatch()
            case "primitive-apply":
                pc = primitiveApply()
            case "compound-apply":
                pc = compoundApply()
            case "ev-sequence":
                pc = evaluateSequence()
            case "done":
                return val
            default:
                fatalError("Unknown PC state: \(pc)")
            }
        }
    }
    
    private func evaluateDispatch() -> String {
        // Determine expression type and dispatch
        if isNumber(exp) || isString(exp) {
            return "eval-self-eval"
        } else if isSymbol(exp) {
            return "eval-variable"
        } else {
            return "eval-application"
        }
    }
    
    private func evaluateSelfEval() -> String {
        val = exp
        return "done"
    }
    
    private func evaluateVariable() -> String {
        // Look up variable in environment
        val = lookupVariable(exp, in: env)
        return "done"
    }
    
    private func evaluateApplication() -> String {
        // Save continue and evaluate operator
        stack.append("ev-appl-did-operator")
        return "eval-dispatch"
    }
    
    private func applyDispatch() -> String {
        if isPrimitive(proc) {
            return "primitive-apply"
        } else {
            return "compound-apply"
        }
    }
    
    private func primitiveApply() -> String {
        val = applyPrimitive(proc, args: argl)
        return "done"
    }
    
    private func compoundApply() -> String {
        // Set up new environment and evaluate body
        env = extendEnvironment(proc, args: argl, baseEnv: env)
        return "ev-sequence"
    }
    
    private func evaluateSequence() -> String {
        // Evaluate sequence of expressions
        return "done"
    }
    
    // Helper functions (simplified implementations)
    private func isNumber(_ exp: Any) -> Bool { return exp is Double || exp is Int }
    private func isString(_ exp: Any) -> Bool { return exp is String }
    private func isSymbol(_ exp: Any) -> Bool { return exp is String }
    private func isPrimitive(_ proc: Any) -> Bool { return false }
    private func lookupVariable(_ symbol: Any, in env: Any) -> Any { return "" }
    private func applyPrimitive(_ proc: Any, args: [Any]) -> Any { return "" }
    private func extendEnvironment(_ proc: Any, args: [Any], baseEnv: Any) -> Any { return "" }
}

/*:
 ## 5.5 Compilation
 
 **Compilation** translates high-level programs into efficient machine code, achieving better performance than interpretation.
 
 ### 5.5.1 Structure of the Compiler
 */

/// A simplified compiler that translates arithmetic expressions to machine instructions.
///
/// This class demonstrates the compilation process by converting high-level
/// arithmetic expressions into a sequence of low-level machine operations.
///
/// - Note: Supports basic arithmetic operations and simple optimizations.
class ArithmeticCompiler {
    enum Instruction {
        case loadConstant(Int)
        case loadVariable(String)
        case add
        case multiply
        case store(String)
    }
    
    /// Compiles a string arithmetic expression into machine instructions.
    ///
    /// This method performs syntactic analysis and code generation,
    /// translating high-level expressions into executable instruction sequences.
    ///
    /// - Parameter expression: The arithmetic expression to compile.
    /// - Returns: An array of machine instructions representing the compiled expression.
    func compile(_ expression: String) -> [Instruction] {
        // Very simplified compiler
        if let number = Int(expression) {
            return [.loadConstant(number)]
        }
        
        if expression.contains("+") {
            let parts = expression.components(separatedBy: "+")
                .map { $0.trimmingCharacters(in: .whitespaces) }
            
            var instructions: [Instruction] = []
            for part in parts {
                instructions.append(contentsOf: compile(part))
            }
            
            // Add instructions for addition
            for _ in 1..<parts.count {
                instructions.append(.add)
            }
            
            return instructions
        }
        
        return [.loadVariable(expression)]
    }
    
    /// Optimizes a sequence of instructions using peephole optimization.
    ///
    /// This method performs simple optimizations like constant folding
    /// to improve the efficiency of the generated code.
    ///
    /// - Parameter instructions: The original instruction sequence.
    /// - Returns: An optimized instruction sequence with better performance characteristics.
    func optimize(_ instructions: [Instruction]) -> [Instruction] {
        // Simple peephole optimization
        var optimized: [Instruction] = []
        var i = 0
        
        while i < instructions.count {
            let current = instructions[i]
            
            // Look for constant folding opportunities
            if i + 2 < instructions.count,
               case .loadConstant(let a) = current,
               case .loadConstant(let b) = instructions[i + 1],
               case .add = instructions[i + 2] {
                
                optimized.append(.loadConstant(a + b))
                i += 3
            } else {
                optimized.append(current)
                i += 1
            }
        }
        
        return optimized
    }
}

/*:
 ### 5.5.2 Compiling Expressions
 
 Expression compilation demonstrates the transformation from high-level constructs to machine operations.
 */

let compiler = ArithmeticCompiler()
let instructions = compiler.compile("3 + 4")
let optimized = compiler.optimize(instructions)

print("Original instructions: \(instructions)")
print("Optimized instructions: \(optimized)")

/*:
 ### 5.5.3 Compiling Combinations
 
 Complex expressions require careful compilation to maintain correct evaluation order and register usage.
 */

class RegisterAllocator {
    private var availableRegisters = ["R1", "R2", "R3", "R4", "R5"]
    private var usedRegisters: Set<String> = []
    
    func allocateRegister() -> String? {
        for register in availableRegisters {
            if !usedRegisters.contains(register) {
                usedRegisters.insert(register)
                return register
            }
        }
        return nil  // No registers available
    }
    
    func freeRegister(_ register: String) {
        usedRegisters.remove(register)
    }
    
    func freeAllRegisters() {
        usedRegisters.removeAll()
    }
}

/*:
 ## Exercises (Implementation Required)
 
 ### 5.1 Exercises
 - **Exercise 5.1**: Design register machine for computing factorials
 - **Exercise 5.2**: Use the simulator to test machines from 5.1
 - **Exercise 5.3**: Implement machine for computing square roots
 - **Exercise 5.4**: Extend machines to handle different data types
 - **Exercise 5.5-5.13**: Various register machine design exercises
 
 ### 5.2 Exercises
 - **Exercise 5.14-5.19**: Simulator implementation and enhancement
 
 ### 5.3 Exercises
 - **Exercise 5.20-5.22**: Memory allocation and garbage collection
 
 ### 5.4 Exercises
 - **Exercise 5.23-5.30**: Explicit-control evaluator implementation
 
 ### 5.5 Exercises
 - **Exercise 5.31-5.52**: Compiler implementation and optimization
 
 ## Key Takeaways
 
 1. **Register machines** provide a bridge between high-level and low-level computation
 2. **Simulation** helps understand machine behavior and performance characteristics
 3. **Memory management** is crucial for building practical computing systems
 4. **Garbage collection** maintains the illusion of unlimited memory
 5. **Explicit-control evaluation** reveals the mechanical nature of interpretation
 6. **Compilation** trades translation time for execution efficiency
 7. **Optimization** improves program performance through code transformation
 8. **Computer architecture** fundamentally shapes how we design and implement programs
 */

//: [Next](@next)
