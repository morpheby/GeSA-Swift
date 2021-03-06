## When should you use it

So here are some points of when should you consider using GeSA:

  - Your system is potentially complex
  - Your system may contain multiple joints and interdependencies
  - You want your system to be very agile from the inception and till
    EOL
  - You can start with a minimal system and build upon it
  - Initial design may differ significantly from later designs
  - You may need additional computational resources eventually
  - It is hard to draw distinct lines of concern-separation in your
    system
  - You want a specific feature of GeSA for your system (this one is
    obvious, right?)

Also, here are some points of when it may be a bad idea to use GeSA:

  - Your system is small-scaled
  - Your initial system design will not change much
  - Your system will suffer significantly from poor single-thread
    performance and/or high execution latency

And, finally, here is the most important factor-test (the first one is
also a sign of a well-designed genetic system):

1.  If you can split your system in such pieces that you can throw away
    or omit without significant impact on the operation of your system
    as a whole.
2.  Removing any such pieces in most other architectures will inevitably
    create lots of dangling references and involve lots of work to
    remove them (or at least refactoring).

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
