# Higher Level Languages

Higher level languages like [Swift](https://swift.org) are useful as they abstract a lot of the tedious work to functions and 
methods built into the language. Another benefit of higher level languages is automated memory management which saves time and lines of code written.

> [!NOTE]
> The CS50 Course actually utilises Python to teach higher level languages however as I am learning Swift at the moment and rarely use Python I decided it was better for me to utilise this language. In terms of the features and functionality Swift provides much of the same abstractions as Python.

A lot of this section is completed within the [Examples.playground](./Examples.playground) file which will require Xcode to open and run the files. I will include some notes in this `README.md` file for continuity's sake however the program examples are within the Playground. 

To quickly open the Playground directly from the GitHub repository you can use the commands below within your terminal emulator.

``` sh
git clone https://github.com/maclong9/harvard-compsci
open harvard-compsci/Introduction/06-Swift/Examples.playground
```

 > [!NOTE]
 > This playground requires having macOS with Xcode installed.

## Example Libraries
 
[Foundation](https://developer.apple.com/documentation/foundation) is a Swift library that contains a lot of functions for interacting with the operating system, some functionality that is built into C is abstracted into this Library for organisation sake. Some examples of tasks you can perform with this library including finding, creating, manipulating and removing files within your operating system and working with dates and times.

Another useful library is the [Argument Parser](https://github.com/apple/swift-argument-parser) library which allows you to define and parse command line arguments really quickly and it also generates help documentation on the fly for each argument or flag.
