<details id=contents>
<summary><strong>Table of Contents</strong></summary><ol>

<li><a href="/comp-sci/">Introduction</a></li>
<li><a href="./01-Programming">Programming</a></li>
<li><a href="./02-Computer Architecture">Computer Architecture</a></li>
<li><a href="./03-Algorithms and Data Structures">Algorithms and Data Structures</a></li>
<li><a href="./04-Math for CS">Math for CS</a></li>
<li><a href="./05-Operating Systems">Operating Systems</a></li>
<li><a href="./06-Computer Networking">Computer Networking</a></li>
<li><a href="./07-Databases">Databases</a></li>
<li><a href="./08-Languages and Compilers">Languages and Compilers</a></li>
<li><a href="./09-Distributed Systems">Distributed Systems</a></li>
<li><a href="./10-Bonus Recap Lessons">Bonus Recap Lessons</a></li>

</ol></details>

---

```swift
import PlaygroundSupport
```

# CS-10 Bonus Recap Lessons

These lessons are suggested if you don't have time to do the full course, or as I would recommend to use them as a recap once the rest of the course is completed to really drill the ideas down into your mind.

The two books are _Computer Systems: A Programmer's Perspective_ and _Designing Data-Intensive Applications_.

```swift
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
```

