# GeSA

Full GeSA implementation based on [MicroGene](https://github.com/morpheby/MicroGene), written in Swift.

(still in development)

## What is GeSA? ##

GeSA is a **Genetic System Architecture**.

GeSA is designed to (abstractly) mimic behavior of biological genetic code — and still be a computational
system architecture designed not for biology, but for normal software development.

## Read on

1. [What is Genetic System Architecture](/docs/GeSA%20Introduction.md)
2. [When should you use it](/docs/GeSA%20Usage.md)
3. [How it is made](/docs/GeSA%20Structure.md)
4. [A short comparison](/docs/GeSA%20Comparison.md)
5. [Sort of Q&A](/docs/GeSA%20QnA.md)
6. [Current state](/docs/GeSA%20State.md)
7. [Some basic and advanced patterns to consider](/docs/GeSA%20Patterns.md)
8. [What you can do with GeSA (Architecture examples)](/docs/GeSA%20Examples.md)

Or [get full PDF](/docs/GeSA%20Description.pdf).

## Short introduction ##

GeSA is designed **specifically** for complex, interdependent projects. GeSA is an architecture, where
you **do not control**:

1. Flow of data
2. Flow of execution

Instead, you define small transforming pieces, that have and input, and output (kinda like in FP), a small
procedure that performs a "test" operation on inputs, and a procedure that transforms input into output. 
Such piece is called a "Gene".

And there is a global namespaced environment, where all of the variables are stored
when not in execution.

So what you have in a single Gene:

1. Input variables
2. Match expression
3. Execution block

Input variables are guaranteed to be available and set upon execution of a match expression, and match
expression is guaranteed to be successful upon execution of the execution block. 

Nothing too complex here (yet).

There are also some limitations:

1. Gene is required to work only with its own variables
2. When working outside of its own variables, assume parallel execution

## GeSA advantages ##

* GeSA provides parallel execution in a concept similar to Actor, but more "functional". Each gene
  can be regarded as a function, with a match statement, that consumes some inputs and produces some outputs.
* GeSA disconnects every single piece of your architecture into small, easily combinable and tunable "Genes",
  allowing to write programs looking at inputs and outputs, not at the whole process of transformation.
* GeSA disconnects your architecture so much, that you can also put its pieces onto different computers
  (similar to actors), and interconnect them effortlessly.
* GeSA allows for massive parallelism (also can be distributed).

## GeSA disadvantages ##

* GeSA is heavy. MicroGene itself is computationally heavy, and this GeSA implementation adds even more
  complexity.
* Writing using GeSA is not simple. 
