//: [Previous](@previous)

import PlaygroundSupport
/*:
 # CS-10 Bonus Recap Lessons

 These lessons are suggested if you don't have time to do the full course, or as I would recommend to use them as a recap once the rest of the course is completed to really drill the ideas down into your mind.

 The two books are _Computer Systems: A Programmer's Perspective_ and _Designing Data-Intensive Applications_.
 */
import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 20) {
      Text("Equation:")
        .font(.headline)
      Text("2x + 3y = 8")
        .font(.system(size: 24, weight: .bold, design: .monospaced))
      Text("3x + 4y = 11")
        .font(.system(size: 24, weight: .bold, design: .monospaced))
    }
  }
}

PlaygroundPage.current.setLiveView(ContentView())
