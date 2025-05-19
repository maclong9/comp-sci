/*:
 # Calculator Example
*/

enum Operation: String, CaseIterable {
  case add
  case subtract
  case multiply
  case divide
}

enum OperationError: Error {
  case wrongOperand(String)
}

func calculate(_ operandOne: Double, _ operation: Operation, _ operandTwo: Double) throws -> Double {
  switch operation {
    case .add:
      return operandOne + operandTwo
    case .subtract:
      return operandOne - operandTwo
    case .multiply:
      return operandOne * operandTwo
    case .divide:
      guard operandTwo != 0 else {
        throw OperationError.wrongOperand("Cannot divide by zero")
      }
      return operandOne / operandTwo
  }
}

/*:
  ## Experiment
 
 This example shows a good example of error handling to ensure that you are getting the correct input, in this example the error handling can be seen ensuring you don't try to divide by zero.
 
 There is also a safety feature with the type checking, because the operation parameter is typecast as `Operation` it won't allow any input that does not match with the `enum Operation` defined at the top of this example. In the case of Swift you will get an error in your editor and it won't even let you run or compile the code, this is a great feature because it stops you accidentally building the project and finding out about this error when it appears in a real world use case scenario.
 
 Try the following:
 1. Divide by Zero
 2. Use a non existant operator such as `.ad`
 
 > You will need to open the console to see the resulting Error when attempting to divide by zero you can do this by clicking the button in the bottomr right of Xcode or by pressing ⌘-⇧-Y.
 
 You can see the `try` keyword below, this means that the function being used can throw and `try` indicates that the computer will attempt to run `calculate` if it fails it will display the error.
*/

try calculate(15, .add, 64)
try calculate(160, .subtract, 120)
try calculate(64, .divide, 4)
try calculate(1600, .multiply, 4)

//: [Previous](@previous)     [Next](@next)
