# Artificial Intelligence

New AI Models are able to generate text and images that are interesting and make sense, some of the images can look almost realistic and can produce entire news stories. It is becoming harder to discern the real from the artificially generated as the technology progresses.

**Prompt Engineering** is a term used to describe the act of giving AI a good system prompt that teaches it how to behave in the way you want it to, in the example of Harvard's DDB it is geared towards focusing on Computer Science and specific aspects of it.

The above is known as a *system prompt* whereas a *user prompt* is the actualy question the end user asks so the AI will take into consideration it's own knowledge while following the guidelines set by the *system prompt* and attempt to answer the *user prompt*.

## Human Intuition

The way to build an AI model is to attempt to convert what we consider the intuitive route to take, for example like playing the breakout game you understand to move the paddle towards the ball so you don't lose the game.

``` mermaid
---
title: Breakout
---
graph TD
    A[Start] --> B{Is ball left of paddle?}
    B -- Yes --> C[Move left]
    B -- No --> D{Is ball right of paddle?}
    D -- Yes --> E[Move right]
    D -- No --> F[Stay still]
```

> [!NOTE]
> AI is good at games because the inputs and outputs can be represented mathematically with a goal in the form of a function to maximise/minimise.

``` mermaid
---
title: Tic Tac Toe
---
graph TD
    A[Start] --> B{Can get 3 in a row this turn?}
    B -- Yes --> C[Play in square to get 3 in a row]
    B -- No --> D{Can opponent get 3 in a row?}
    D -- Yes --> E[Block opponent]
    D -- No --> F[?]
```

If you give the AI instructions based on what side it is playing to reach the following: 
    - if O wins `-1`
    - if draw `0`
    - if X wins `1`

It will find it easier to find the correct output as the results are represented mathematically. The value of the board is not determined until either of the teams have won or there are no spaces left to play.

The issue is with larger games than Tic Tac Toe is there are much more inputs and possibilities in how to play them. For example Chess in the first 4 moves only are `288 Million` possible moves an in Go there are `256 Quintillion`.

This is why we created **machine learning** which is a subset of AI for computers learning what they should do without being coached step by step by a human. Another option is **reinforcement learning** where you give it `+1` or `-1` depending on whether it was good or not, like a dog.

There are examples of robots being guided by a human to show it the general motion of flipping a pancake, the robot is then left to attempt it without the human's guidance only recieving a `1` or `0` depending on whether it did a good job or not. The robot's hand movement is mapped to coordinates so it knows what it is doing.

In this example of a maze with lava pits, it would be a good idea to reward the computer for getting there with less moves so that it finds the quickes solution possible. You can do something like add a randomisation of `10%` that will mean that in that percintile it will randomly move to a different direction rather than the move that returns the highest score so that it can find more efficient pathways.


