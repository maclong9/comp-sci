# A Deeper Glimpse of How Programming Works

## Compiling In More Detail

Compiling is used as a catch-all phrase for converting source code to machine code, however, it's only one step of the actual process. The full process contains 4 steps known as __preprocessing__, __compiling__, __assembling__, and __linking__.

### The Four Steps of Compilation

1. **preprocessing**:
   Lines starting with `#` are known as a preprocessor directive, the most common case being `#include` which tells the compiler to replace the contents of the `#include` line with the contents of the stated header file.
2. **compiling**:
  This step is where the computer converts the C code the programmer wrote into a language known as [Assembly Language](https://en.wikipedia.org/wiki/Assembly_language) which was used for programming before C.
3. **assembling**:
  Next up the compiler will take the Assembly Code from the previous step and convert it to [Machine Code](https://en.wikipedia.org/wiki/Machine_Code). 
4. **linking**:
   The way linking works is by taking all of the compiled `.c` files that are mentioned or referenced by an `include <{libname}.h>` and sort of stitching them together so they can utilise the functions from one another.

> [!NOTE]
> The code is only converted to assembly if you are using `gcc` if you are using the more modern `clang` which is built on LLVM it instead compiles to LLVM IR.

## Debugging

It's rare to write a program 100% right the first time, this is because you may not have thought of something, typed something incorrectly or missed out on a parameter that a function requires to work. 

A debugger allows you to set points in your code where the runtime will pause, you can then view the value of variables at that point during the runtime. This can be useful for figuring out why something isn't working as intended.

The term _bug_ was coined by [Grace Hopper](https://en.wikipedia.org/wiki/Grace_Hopper) whose colleague discovered a moth stuck inside one of the relays of their punchcard computer causing an error.

> [!TIP]
> If your text editor has [Language Server Protocol](https://en.wikipedia.org/wiki/Language_Server_Protocol) support, you can get useful warnings and errors directly inside your code editor without the need for compiling or running a debugger, this can save you a lot of time by helping you catch errors early.

## Memory

A stick of RAM contains black chips on the circuit board, these are where the bytes your computer uses as Random Access Memory are stored. Each byte has a location which is accessible in C by finding the address of the byte.

```
bool   1 byte
int    4 bytes
long   8 bytes
float  4 bytes
double 8 bytes
char   1 byte
string ? bytes
```

## Arrays

Arrays are a collection of a type, the values must all be of the same type. A great use case for this is storing a collection of scores which would be of type integer. This allows us to keep the data of the array stored in memory with each value back to back. There is an example of this in the [scores.c](./scores.c) file.

You use what is known as an __index__ to access data from an array, so to print the third item of an array you would point to the array with an index of 2. This is because arrays start at 0 instead of 1.

```c
int[] numbers = { 0, 1, 2, 3, 4 };

print("%i", numbers[2]);
```

## Strings

A string is stored in memory slightly differently, while an integer is stored at a memory address with that value inside, a string is an array of type `char` defined as a [pointer](../04-Memory#pointers) with the address of the pointer being the first character of the string, the bytes in memory following that original address are the string up until it reaches a null terminate code usually represented by `00000000` telling the computer that the string ends there.

You can manipulate strings using the `<string.h>` and `<ctype.h>` libraries, some common functions include `strlen` for finding the length of a string and `toupper` to capitalise a singular character or string. Another function is `strcmp` which is used to compare two strings and will exit with `0` if the strings are the same, it compares strings in _ASCIIbetical_ order. 

```c
if(strcmp("test", "test") == 0) { ... }
```

## Command Line Arguments

While accepting user input during runtime is useful, sometimes you want to be able to run a program with a specific input and have the program use that during its processing. You can see this method used with `cp` and `mv` as well as other common UNIX commands.

```c
int main(int argc, string argv[]) {
  printf("%i", argc); // returns count of arguments starting from 0
  print("Output:\nZero: %s\nOne: %s", ,argv[0], argv[1]);
}
```
```sh
λ ./main hello
Argument Zero: ./main
Argument One: hello
```

> [!TIP]
> It is common for Command Line Tools to use __flags__ to check for particular arguments e.g `rm -r` to recursively remove everything within a folder. `if (strcmp(argv[i], "-r") == 0)` is how you would check for this flag.

## Cryptography

Cryptography is the art of scrambling and sending information, it is a way to ensure that only the desired recipient can open the data. It has been commonly achieved by rotating the letters of the alphabet, for example, the cypher `ROT13` which moves each letter of the alphabet forward 13 places wrapping around at the end. More complex algorithms are used in real-world applications and require both the sender and receiver to have a `key` which is an algorithm allowing them to decrypt the data.

[Previous: 01-C](../01-C/README.md) <br />
[Next: 03-Algorithms](../03-Algorithms/README.md)
