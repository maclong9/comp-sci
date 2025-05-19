# Memory

## Colors

Your screen uses pixels to render images, they are essentially tiny square lights which is why low-resolution images or screens can render images that appear blocky because of the size of the pixels used to create the image. This is sometimes in an art style called [Pixel Art](https://en.wikipedia.org/wiki/Pixel_Art), popularised by 8-bit video games. 

An image file simply maps to a pattern of pixels to turn on and off or alter the colour to reproduce the image detailed in the pattern. A common way to alter the colour of a pixel is known as the [RGB Color Model](https://en.wikipedia.org/wiki/RGB_color_model) with the letters standing for Red, Green & Blue with each having a possible value of 0 through 255.

[HEX Triplet](https://en.wikipedia.org/wiki/Web_colors) is another common colour notation with the values of a HEX `#000000` equaling Red, Green and Blue again for every 2 places. Instead of 0 to 255, HEX uses a Hexadecimal notation with `0-9` followed by `A-F` for `10-15`.

Most programs that work with colors from photo editors to web programming use HEX and RGB as options for colors. Another common choice is HSL and there is a new colorspace called OKLCH.

## Hexadecimal

Sometimes you require more than ten digits and representing these things in bytes can become tedious so we instead use hexadecimal. Most computers typically use hexadecimal to number the bytes available in memory.

The mathematics below shows the value of each column and how to figure out basic hex values.

```math
\overbrace{0}^{16} \overbrace{0}^{1} = 0
```
```math
\overbrace{0}^{16} \overbrace{1}^{1} = 1
```
```math
\overbrace{0}^{16} \overbrace{A}^{1} = 10
```
```math
\overbrace{0}^{16} \overbrace{F}^{1} = 15
```
```math
\overbrace{1}^{16} \overbrace{0}^{1} = 16
```
```math
\overbrace{1}^{16} \overbrace{1}^{1} = 17
```
```math
\overbrace{2}^{16} \overbrace{3}^{1} = 36
```
```math
\overbrace{F}^{16} \overbrace{F}^{1} = 255
```

> [!NOTE]
> You will not need to do this kind of conversion very frequently.

```
grid of memory
8 byte 0x123 for p
store 50 in 4 of the blocks.
stored in 0x123 = 291
```

## Pointers 

You can use the `%p` format code and the `&` appended to a variable name to print the address that a value is being stored in memory. This is known as a pointer which points to the memory address. The `*` character is used for syntax relating to pointers if you use it with a type `int *p` it declares a pointer, if you use it without specifying a type `printf("%i", *p);` it will point to that memory address. 

```
diagram of s stored in 8 bytes pointing to the start of string hi!\0
```

> [!NOTE]
> Modern computers use 64-bit allowing you to count to crazy high numbers. $64–bit = 2^{63} - 1$.

You cannot compare a string with another string by doing `s == t` because `s` and `t` in this case are defined as a pointer to the first item in an array of characters making up a string. This is why the `strcmp` function exists. The same issue will happen if you try to copy the value of a string variable into a new variable, which is why the `strcpy` function exists because if you tried to copy a variable using `s = t` you would end up with the issue of `s` and `t` mirroring each other with changes to each individually because they are both pointed at the same memory address.

## Allocation

`malloc` is a function contained within `<stdlib.h>` and is used to allocate a section of memory to a variable. As an example consider `char *t = malloc(8);` which would reserve space in memory for `t` equal to `8B` the function then returns the first-byte address of the chunk reserved.

> [!WARNING]
> Anytime a function could return `NULL` like in `malloc` you should check and `return 1` if so because this means there isn't enough memory.

The `free` function is the exact opposite of `malloc` instead of reserving space for a variable it frees up a chunk of memory that was previously allocated. You should always free the memory that you have allocated otherwise you can end up with memory leaks which cause the user's system to run out of memory.

```c
free(t);
```

For convenience, you can use the `sizeof` function to reserve chunks of memory that are the exact size of various data types. You can also use the result of the `sizeof` function in an equation to easily create arrays that are the correct memory size of 8 integers or something similar. This makes your code more portable as there are rare inconsistencies across operating systems where the size of a type may be slightly different.

```c 
int *x = malloc(sizeof(int));
int arr = malloc(3 * sizeof(int));
```

There are tools you can use to check for memory leaks, on macOS you can use `leaks` and on Linux, you can use `valgrind` both work in pretty much the same way with minor differences. However, if you have allocated space using `malloc` but not freed that memory with `free` these tools will let you know about it.

### Garbage Values

These are quite a fun little experiment, if you allocate some memory but do not assign anything to the space you allocated and then iterate over every address within that section of memory and print the value you, you are likely to see what are known as __garbage values__, these are values that are stored in memory that you did not set, so they came from another program or something the operating system was running. You can compile and run [garbage.c](./garbage.c) and you will see a lot of values printed out with some of them being non-zero values even though the code never assigns any values.

[here](https://www.youtube.com/watch?v=5VnDaHBi8dM) is a fun video explaining pointers and memory allocation.

```c

int main(void) {
    int *x;
    int *y;

    x = malloc(sizeof(int));

    *x = 42;
    *y = 13;

    y = x;

    *y = 13;
}
```

The above code sets a variable in a low-level way by allocating the variable `x` and then assigning a value separately. `y` is also assigned a value but no space is ever allocated for `y` this would result in a garbage value and can cause computers to crash. You cannot dereference a pointer that has never been pointed to a memory address. The code above is fixed by the line that assigns `y` to `x` which means `y` is now pointing to a valid memory address.

## A Brief Look Into Scope 

There is an example in this directory called [swap.c](./swap.c), which uses a function to swap the values of `x` and `y` however it only works due to the usage of a temporary variable within the `old_swap` function. This is because the values passed to the `old_swap` function would just be copies of the original `x` and `y` and therefore altering the values of `a` and `b` would only affect the local scope after the function has terminated they would be discarded leaving `x` and `y` at their original values.

To fix the issue mentioned above, there is another function labelled `swap` which instead of taking just integers accepts a pointer to an integer, this allows the `swap` function to directly manipulate the value at the address of `x` and `y` because `a` and `b` are not a value but instead a pointer that locates the original values.

## Stack Frames and Overflowing

The compiled result of machine code goes to the top of the computer's memory in a stack of frames. Just below that you will find the __global variables__, followed by the __heap__ which is where the `malloc` function will assign chunks of memory from, at the very bottom of the frames you have what is known as the __stack__, this is where functions with variables and the command line arguments get their memory from. 

In the `swap` example from the previous section inside of the stack, you will find `main` which is at the very bottom and calls `swap`, swap will get its _frame_ placed above `main` and will be discarded once it exits. 

Using too many swap or stack frames can cause overlap because one starts from the top and the other from the bottom, so if you don't remember to call `free` they can run into each other, overwrite one another and then the program will have a lot of problems.

Calling functions or recursions too much can cause a memory error known as a __heap overflow__, calling `malloc` too much can cause the stack memory to overflow known as __stack overflow__. Finally, there is something called __buffer overflow__ which is when an individual chunk of memory overflows.

 > [!NOTE]
 > A **Segmentation Fault** means something has gone wrong with the memory. You may run into this if you don't initialise a `char *` variable.

## File IO

While `stdin` and `stdout` are great sometimes we need to store values in a file or read some data from a file. That is where the following file input and output functions come in, you can see a basic [phonebook.c](./phonebook.c) implementation which walks through the basics of writing to a file.

Another example file is [cp.c](./cp.c) which utilises both the reading and writing of a file, the result is a simple recreation of the standard UNIX command `cp` which copies a file to a new specified location based on command line arguments.

``` c
while(fread(&b, sizeof(b), 1, src) != 0) {
```

The above line of code uses `fread` to read from the address of `b`, at a size of `b`, and then copy `1` byte at a time from the `src` file variable. It will do this as long as it succeeds, when there are no bytes it exits. The following line does the opposite, instead, it tells `fwrite` to find the address of `b` then 1 byte at a time write to `dst` file.

``` c
fwrite(&b, sizeof(b), 1, dst);
```

__file I/O functions__
- `fopen` opens a file
  - works with read, write or append mode.
  - store as a `FILE *`
- `fclose` closes a file
- `fprintf` print to a file
- `fscanf` read from a file
- `fread` read write binary data from a file
- `write` binary data to a file
- `fseek` moves around in the file

[Previous: 03-Algorithms](../03-Algorithms/README.md) <br />
[Next: 05-Data-Structures](../05-Data-Structures/README.md)
