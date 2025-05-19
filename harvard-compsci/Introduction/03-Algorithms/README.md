# Dividing Tasks to Conquer Faster

```mermaid
---
title: Taking Attendance Algorithm
---

flowchart TD
    1["Everyone Stands and Thinks of Number 1"] -->
    2["Everyone Pairs Off and Adds Their Numbers"] -->
    3["One of Pair Sits"] -->
    4{"If One Person Remains Standing"}
    4 -->|True| 5["Say Number"]
    4 -->|False| 2
```

```mermaid
---
title: Values Behind Lockers Brute Force Algorithm
---

flowchart TD
    1(["for i from 0 to n"]) -->
    2{"if 50 is behind doors[i]"}
    2 --> |true| 3["Return True"] --> 6
    2 --> |false| 4["Return False"] --> 5{"if i < n"}
    5 --> |true| 2
    5 --> |false| 6["Exit"]
```

```mermaid
---
title: Value Behind Lockers Divide & Conquer Algorithm
---

flowchart TD
    vars>"`
      **Variables**
      value = 50
      total = 8
    `"]
    1(["for count from 0 to total"]) -->
    2{"if count equals total"}
    2 --> |true| 3["value doesn't exist"] --> 16
    2 --> |false| 4["if value is behind doors item count"]
    4 --> |true| 5["return value"] --> 15
    4 --> |false| 6["return false"] -->
    7{"if v is below n / 2"}
    7 --> |true| 8["search left half"] --> 4
    7 --> |false| 9["search right half"] --> 4

    15("exit 0")
    16("exit 1")
```

> [!NOTE]
> Computer Scientists tend to talk about efficiency being on the order of several steps. They also throw away constant factors such as the number, they generalise with $O(\\log n)$.

## Big $O$ Notation

This notation is a way to describe the maximum possible number of steps an algorithm can take during runtime. 

__$O$ Maximum Number of Steps__
- $O(n^{2})$
     - n people doing n things, for example, everyone in a room shaking hands would be $n \times n$ or $n^{2}$ handshakes.
- $O(n \\log n)$
- $O(n)$
     - takes linear time, for example, going through the phonebook one at a time. It represents an upper bound on the number of steps you might be counting.
- $O(\\log n)$
     - dividing in half.
- $O(1)$
     - this means it is a constant number of steps, no matter how many people the algorithm is working through.

__$\Omega$ Lowest Number of Steps__
- $\Omega(n^{2})$
- $\Omega(n \\log n)$
- $\Omega(n)$
- $\Omega(\\log n)$
- $\Omega(1)$

__$\Theta$ represents that $O \text{ and } \Omega$ are equal__
- $\Theta(n^{2})$
- $\Theta(n \\log n)$
- $\Theta(n)$
- $\Theta(\\log n)$
- $\Theta(1)$: _linear search_, _binary search_

## Structs for Storing Data

A `struct` is a way of defining structure for variables and containing them within one namespace. This can help make code clean and readable. There is an example of creating a `struct` named `Person` with the attributes `string name` and `string number` for phone number within the [phonebook.c](./phonebook.c) file.

``` mermaid 
---
title: Person Structure Visualised
---
classDiagram
    class Person
    Person : +String name
    Person : +String phone_number
```


## Sorting Algorithms

```mermaid
---
title: Selection Sort
---

flowchart TD
    vars>"`
      **Variables**
      previous = NULL
      completed = 0
      items = [0, 2, 4, 6, 1, 3, 5, 7]
    `"]
    1(["for count in total"]) -->
    2{"if items[count + completed] less than total"}
    2 --> |true| 3
    2 --> |false| 4["move previous to start of array and add 1 to completed"]
    3["check bit at count"]
    3 --> |"smaller"| 5["store as previous"] --> 2
    3 --> |"larger"| 6["keep current bit"] --> 2
```

```mermaid
---
title: Bubble Sort
---

flowchart TD
    vars>"`
      **Variables**
      completed = 0
      items = [0, 2, 4, 6, 1, 3, 5, 7]`"]
    1(["for count in length of items - 1"]) -->
    2{"if count equals the length of items - completed"}
    2 --> |true| 8["print sorted array"]
    2 --> |false| 3
    3{"if items[count] more than items[count] + 1"}
    3 --> |true| 5("switch items[count] and items[count + 1]")
    3 --> |false| 6("leave items[count] and items[count + 1]")
    5 & 6 --> 7("increment count and completed by 1") --> 2
```

[Comparison Sorting Algorithms](https://www.cs.usfca.edu/~galles/visualization/ComparisonSort.html) is a great website that visualises the differences between various sorting algorithms created by [the University of San Francisco](https://www.usfca.edu/). There is also [this video](https://www.youtube.com/watch?v=ZZuD6iUe3Pc) which shows the speeds of various sorting algorithms.

As an algorithm selection sort is quite inefficient as it is constantly cycling through every single element above the current loop increment. Selection Sort is on $\Theta(n^{2})$ because the upper and lower bound of steps are equal.

Bubble Sort works by comparing two values against each over, over and over again. Below is an equation that works out what the order of steps for Bubble Sort is.

```math
n = \text{Number of Items Sorted} \\

\begin{align}
     (n - 1) \times (n - 1) &= n^{2} - 1n + 1 \\
     &= n^{2} - 2n + 1 \\
     &= O(n^{2}) \\
     &= \Omega(n)
\end{align}
```

> [!NOTE]
> You could add `if no swaps exit` to exit early if the array is sorted ahead of time to save some iterations in the case of a lucky early finish.

## Recursion

So far we have spoken about _iteration_ when talking about [loops](../01-C/#loops), however there is another way to cause a repetition and that is known as __recursion__. A recursive function is a function that calls itself, an example is known as merge sort, which splits the array of numbers in half and then calls itself again on the left and right halves of the array, this means each time it is called it's on a smaller amount items, it then ends by merging the halves back together. You can see an example of recursion in [recursion.c](./recursion.c) and one of iteration in [iteration.c](./iteration.c).

Merge Sort works out as more efficient than both the Bubble and Selection sorting algorithms. The basic steps applied to an 8 digit array would result in the array being split into half down to 4, 2 and finally 1 you'd then merge the 2 individuals sorting the values at the same time, then you'd do the same for each step back up to the full array of 8.

A more simplistic way to describe it is you sort the left half of the left half, the right half of the left half and then merge both sides of the left half of the original array, then repeat with the right half of the original array and merge the two halves of the original array.

This Merge Sort algorithm results in fewer iterations and the number of steps is equal to $\log_{2}n$ and below is an example of this algorithm with $n = 8$.

```math
\log_{2}8 = \log_{2}2^{3} \\
```
```math
\log_{2}2^{3} = 3
```
```math
\Theta(n \log n)
```

```mermaid
---
title: Merge Sort
---

flowchart TD
    0{"if only one number"}
    0 --> |true| Quit
    0 --> |false| 1
    1("Sort Right Half of Numbers") -->
    2("Sort Left Half of Numbers") -->
    3("Merge Sorted Halves") --> Quit
```

[Previous: 02-Arrays](../02-Arrays/README.md) <br />
[Next: 04-Memory](../04-Memory/README.md)
