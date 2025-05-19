# A More Traditional Language

## Source Code

Source code is what the human writes, it is compiled down to machine code. This is because if we were writing an entire program in 0s and 1s like in the past with [punchcards](https://en.wikipedia.org/wiki/Computer_programming_in_the_punched_card_era), programming would be very painful.

### Compiling

You can compile your program in several ways, running `make hello` will tell the compiler to compile a `.c` file named `hello.c` into a binary called `hello`. You can be more specific with `clang`, the actual compiler program that `make` is running for you. With `clang` you can specify any output file `clang -o hi hello.c`. 

`clang` is a newer compiler built on top of [LLVM](https://llvm.org) which is a new compiler infrastructure designed to help people build new languages.

> [!NOTE]
> If your compile execution prints no text to the Standard Output[^1] then it worked, if something went wrong it will print an error message.

### Keywords

Source code is full of keywords, these words dictate to the compiler that they should cause a specific action to happen, for example, `printf` is a function meaning the compiler will see the text and link it to the function `printf`, the compiler then assembles the binary to run the processes defined in the aforementioned above.

### Formatting

The `printf` function mentioned earlier prints to the Standard Output. There are some caveats such as being unable to use the <kbd>Return</kbd> key to start a new line, even though there will be a new line in the code the compiler requires what is known as an __Escape Sequence__ which is a character prefixed with a `\` in this case for the new line you would use `\n`.

You can interpolate a [variable](#variables) into a string, this is useful for displaying data that might change during the running of a program or specific data that has been collected from somewhere such as the current weather.

```c
char initial = "M";
printf("%c", initial);
```

__Format codes__
- `%c`: Character
- `%f`: Floating Point
- `%f`: Double, similar to float but `64b`, also defined with `%f`.
- `%u`: Unsigned Integer
- `%i`: Integer
- `%p`: Pointer
- `%s`: String
- `%b`: Boolean
- `%x`: Hexadecimal
- `%li`: Long Integer

> [!NOTE]
> To print a backslash using `printf` you have to write `\\` to escape the backslash itself.

### Libraries

C utilises libraries to tuck away various functionality in __Header Files__, this allows you to keep the distributed binary small as it only includes the functions the program needs and not every single function that C is capable of running. These files are added to the compilation step by specifying them with `#include <{lib_name}.h>` at the top of a C file.

While C comes with some standard libraries, you can create your own. This is useful if you want to define a function that may be used multiple times across different files in a large application, custom libraries are specified with `#include "{lib_name}.h"` at the top of the file.

> [!TIP]
> Read the **Manual Pages** for a library to discover how each included function works and parameter types.

### Variables

Variables are reusable values you can store in memory for the program to use later. You can store a variety of types including `char` for a single text character and `int` for an integer. Defining a variable is as simple as writing the type, followed by the variable's name and then what you would like the variable to be equal to. You can also reassign variables by assigning it again later on in the code.

``` c
int a = 9;
int b = 10;
const int c = 16;

printf("%i", a); // 9
printf("%i", b); // 10
printf("%i", c); // 16

a = 11;
c = 17; // ! will not compile unless this line is removed.

printf("%i", a); // 11
printf("%i", b); // 10
```

> [!TIP]
> You can use `const` to define unchangeable variables, `const int n = 5;` as an example.

### Input

Receiving input from the user of the program is a key functionality that nearly every program requires, you can utilise the `scanf` function from the `<stdlib.h>` file to read input. This function can read the Standard Input[^2] to store most data types.

```c
int age;
printf("Enter your age: ");
scanf("%i", age);

char response;
printf("Enter (Y)es or (N)o: ");
scanf("%c", response);
```

> [!CAUTION]
> `scanf` doesn't check the type of the data so logic will need to be implemented for validating input.
 
### Logical Operators

C contains a variety of logical operators used for comparing two values against each other, these can be used within what is known as an if statement to control the flow of your program, a good example of this can be seen in [compare.c](./compare.c) where we check if `x` and `y` are equal depending on whether the result is `TRUE` or `FALSE` print a different string.

The final two logical operators are known as `OR` and `AND`, which can be used during a statement to add conditions to the check, an `OR` statement will return `TRUE` if any of the conditions are true, whereas `AND` will only return `TRUE` if all of the conditions are true. You can see an example of the `AND` operator used in [agree.c](./agree.c).

```c
if (x == y && y = z) {
    printf("All Are Equal");
}
```

__A List of Logical Operators__
- `<` less than.
- `>` greater than.
- `==` is equal to.
- `!=` is not equal to.
- `||` or.
- `&&` and.

### Loops

This is a way of causing a repetition in your code, it can save you from writing the same line of code to make it repeat 4 times, instead, you can just run a loop that counts to 4 and print the statement on each iteration.
There are 2 main types of loops a `while` loop and `for` loop.

A `while` loop will continue to repeat as long as a condition is true and once it returns false the loop will terminate. A while loop should be used when you aren't sure how many iterations there could be. 

```c
int score = 0;

while (score < 5) {
    printf("Shoot the Target!");

    if(hit) {
        counter++;
        print("Great Shot!");
    } else {
        print("You Missed!");
    }
}
printf("You Win!");
```

You can also use a `do while` loop with the major difference being the contents of the loops is executed before the condition is checked rather than after it is checked. This is useful for adding validation to user inputs.

```c
char *name;
do {
    printf("Enter your name: ");
    scanf("%d", &name);
} while(name < 1);
```

A `for` loop should be used when you know exactly how many times you want the loop to run. It is a more concise syntax than a while loop as the variables utilised to track the loop are defined in the loops definition.

```c
for (int i = 0; i < 3; i++) {
    printf("Hello!"); 
}
```

> [!NOTE]
> In simple programs it is normal to use `i` and `j` for incrementing integers and `n` and `m` for quantities. They should be descriptive such as `score` for larger programs.

### Functions

A function is a process you can define and then execute by name, it's useful for keeping loops and the `main` function tidy as instead of all of the logic being placed within a code block each specific task can be separated into a function.

There are two types of functions, one is just a __function__ and returns a value of a type which you must specify in the function declaration, this is known as a return type. The other is called a __subroutine__ and is defined in the same way as a function except you use `void` as the return type, this is because a subroutine doesn't return any value but just runs a piece of logic.

A function can be declared with parameters, though it doesn't have to have any, parameters are values passed to the function to be used within the enclosed logic.

```c
int add(int a, int b) {
    return a + b;
}

void print_three(char *text) {
    for (int i = 0; i < 3; i++) {
        printf("%s\n", &text);
    }
}

int main(void) {
    int result = add(5, 5); // 10
    printThree("5 + 5 = %i", result);
}
```

> [!NOTE]
> The `main` function is defined as `int` because it returns `0` if the program is successful and a different number known as an **error code** if something goes wrong.

### Scope

Now that we have multiple functions defined in our code, __scope__ becomes an important topic. Essentially scope is a way of describing what any given aspect of your code has access to, for example in the `main` function if you have a variable defined named `age` you cannot use that variable within the `print_age` function unless it is passed down as a parameter.

```c
int x = 32; // Globally Scoped Variable

int print_age() {
    printf("%i", age); // will not work because age is not passed to print_age
}

int main(void) {
    int age = 64;
    print_age(); 
}
```

This is known as __Local__ and __Global__ scope, with local being the contents of the block of code itself, in the example above `age` is defined in the `main` function's local scope. To define a global variable you must define it outside of any functions, including the `main` function.

### Comments

Comments are sections of code that are ignored by the compiler, in C they are defined with `//` and can be used to leave yourself or others who may read your code notes about the code you have written. It's particularly useful for code that might not be easily explained just by reading the code. You can define a comment over multiple lines with `/* ... */` for longer text.

```c
printf("Hello, World!"); // Hello, World!
// printf("Hello, Two!); // won't run

/*
    printf("None of these will run!");
    printf("None of these will run!");
    printf("None of these will run!");
*/
```

> [!TIP]
> Good code should be self-documenting. Use comments for complex and non-standard code to explain what it is for.

### Type Casting

Type Casting allows you to treat one type as another, this is particularly useful when you want to perform division on a selection of integers and the result might contain a decimal point. You can utilise type casting by either wrapping the desired type in parentheses or in the case of converting to `float` you can just add one `float` to the equation and the rest of the numbers will be treated as such.

```c
int result_one = ((float) a + (float) b) / 3;
int result_two = (a + b) / 3.0;
```

[Previous: 00-Introduction](../README.md) <br />
[Next: 02-Arrays](../02-Arrays/README.md)

[^1]: Standard Output is an example of [Standard Streams](https://en.wikipedia.org/wiki/Standard_streams).
[^2]: Standard Input is also an example of a Standard Stream, another common one is Standard Error.
