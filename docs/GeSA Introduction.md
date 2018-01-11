## What is Genetic System Architecture

What is Genetic System Architecture? Genetic System Architecture (GeSA
for short, alternately Genetic Programming) is a software design
architecture (paradigm) that acts around data flow, not execution
flow\[1\]. It is akin to both Functional Programming and Object-Oriented
Programming, but unlike those, it has neither a defined functional
composition nor a defined class composition. Instead, the explicit
decision on what function/class (in GeSA — gene) will be used is made at
runtime based on intrinsic and extrinsic properties of the data, match
condition specified in the gene, priority of the gene and external
conditions of the system (e.g. local or remote gene, availability of
computational resources, etc).

While initially it may seem convoluted, wasteful, indeterminate — there
are several benefits, that in my opinion far outweigh this. Here are a
couple of such benefits:

  - **GeSA is agnostic to computational units** and can work as a
    **microservice architecture**. Beyond having implicit
    multi-threading and thread-safety, you can have one program split
    and replicated on any number of completely (hardware) unrelated
    computational units, till they are networked in any way. For
    example, once you have developed your software for PC, you can
    easily just cut some of the genes, and copy them over to a hundred
    of Raspberry Pi’s (with, of course, corrections for target OS and HW
    architecture). They will interoperate without any additional
    changes, and you will instantly get all the benefits of
    microservices without the hassle of designing the system for
    microservices initially (and the less design decisions you have to
    make upfront is usually the better).
  - **Changing and substituting components is easy**, since each gene is
    supposed to rely only on its data and never on the existence (or
    implementation) of other genes. Take this as a same core premise of
    OOP but even more: your genes don’t even know there are other genes,
    what are interfaces to them, what inputs and outputs they have. So
    you can easily interject additional genes or replace other genes
    (even with specific and definite conditions\!) anywhere in the
    data-flow without breaking a thing. Take OOP: to add some specific
    behaviors to a class, you need to subclass it. Then you have some
    indeterminate calls to superclass at occasional points where you
    want to fallback to other functions. You also have to use something
    like dependency injection or painstakingly replace each call to a
    new instance of this superclass with your new subclass. And what if
    it’s in the third-party lib? There are multitudes of design patterns
    to accommodate that, each adding more design complexity… If we go to
    FP — it is even worse and changing anything in a strictly defined
    composition is near impossible without major dives into the code.
    What to do in GeSA? You just define a new gene with higher priority
    and specific conditions when it should fire — the system works
    everything out internally and in a determinate predictable matter.
    You can even define a lower-priority “a-la superclass” gene — later
    than “subclass” genes. Even less upfront design decisions, right?
  - **Debugging can be terrifically simple**. Each data point that is
    important for branching of any kind is exposed by design and can be
    captured, viewed, extracted, substituted or mocked without
    additional efforts from inside the genes themselves. Execution can
    be controlled in a manner that shows what have impacted certain
    decisions, and any gene can be stopped while leaving other genes to
    continue working (imagine in-app debugging).

## Contents

0.  [Home](/README.md)
1.  [What is Genetic System Architecture](/docs/GeSA%20Introduction.md)
2.  [When should you use it](/docs/GeSA%20Usage.md)
3.  [How it is made](/docs/GeSA%20Structure.md)
4.  [A short comparison](/docs/GeSA%20Comparison.md)
5.  [Sort of Q\&A](/docs/GeSA%20QnA.md)
6.  [Current state](/docs/GeSA%20State.md)
7.  [Some basic and advanced patterns to
    consider](/docs/GeSA%20Patterns.md)
8.  [What you can do with GeSA (Architecture
    examples)](/docs/GeSA%20Examples.md)

<!-- end list -->

1.  As all other paradigms, it is language-agnostic and can be freely
    implemented on top of any other language, but having a GeSA-language
    will do it just as much good as existence of OOP and FP languages
    does for OOP and FP.
