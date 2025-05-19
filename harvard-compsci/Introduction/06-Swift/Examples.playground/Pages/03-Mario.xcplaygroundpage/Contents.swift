/*:
 # Mario Example
 
 Using Swift's `String` class you can print multiple of the same character or string without the need for `for` or `while` loops, this saves a lost of time in comparison to the similar code written in c.
 */

print(String(repeating: "?", count: 4))
print("")

let height = 10
let width = 25

for _ in 1...height {
  for _ in 1...width {
    print("#", terminator: "")
  }
  print("")
}

//: [Previous](@previous)     [Next](@next)
