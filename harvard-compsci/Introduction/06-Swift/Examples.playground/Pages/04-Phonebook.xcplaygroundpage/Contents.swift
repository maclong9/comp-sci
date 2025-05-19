var people = [
  ["name": "Carter", "number": "1234"],
  ["name": "David", "number": "5678"],
  ["name": "Harvard", "number": "9012"]
]

let nameToFind = "Mac"

func findName(in people: [[String: String]], for name: String) -> String {
  for person in people {
    if person["name"] == nameToFind {
      return person["number"] ?? "Not Found"
    }
  }
  return "Not Found"
}

print(findName(in: people, for: nameToFind))
people.append(["name": "Mac", "number": "0000"])
print(findName(in: people, for: nameToFind))

//: [Previous](@previous)     [Next](@next)
