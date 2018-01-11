## What you can do with GeSA

Let’s see some examples when it is really great to use GeSA.

### Developing a growing agile system

So you start with a backend service that has a database **A** and some
business logic.

![Conventional: Step 1 —
Initial](Example-Architecture-1/Step%201%20—%20Initial.png) 

> *Seems simple enough…*

![GeSA: Step 1 —
Initial](Example-GeSA-Architecture-1/Step%201%20—%20Initial.png) 

> *Seems like you never mentioned that GeSA is simple for a reason.*

Then you decide you need some caching for the business logic.

![Step 2 — Caching](Example-Architecture-1/Step%202%20—%20Caching.png) 

> *Still OK…*

(—insert drawing here—)

Even later, you add database **B** that stores some performance
statistics from caching.

![Step 3 —
Statistics](Example-Architecture-1/Step%203%20—%20Statistics.png) 

> *Maybe it’s time to think about some refactoring.*

(—insert drawing here—)

And also add another value for business logic and cache it as well.

![Step 4 — Additional
process](Example-Architecture-1/Step%204%20—%20Additional%20process.png) 

> *So, you like copy-pasting, eh?*

(—insert drawing here—)

And database **C** that makes some of the caching persistent.

![Step 5 — Persistent
Cache](Example-Architecture-1/Step%205%20—%20Persistent%20Cache.png) 

> *I’ll tell you what it doesn’t do… It certainly doesn’t make things
> simpler.*

(—insert drawing here—)

And then you decide that caching needs to be done on a separate server
(with database C)…

![Step 6 — Offload
C](Example-Architecture-1/Step%206%20—%20Offload%20C.png) 

> *I hope you didn’t want microservices. And please, do use REST at
> least.*

(—insert drawing here—)

And you also decide you don’t need some of the values to be cached. And
that seems weird to do cache profiling in business logic — so you
refactor it.

![Step 7 — Uncache](Example-Architecture-1/Step%207%20—%20Uncache.png) 

> *Doesn’t seem like it became simpler after refactoring.*

(—insert drawing here—)

Now you want to cache the other value on the second server only when the
count of objects is ≥500. You also want it done only when the count of
changed/added objects is ≥5 or when change of the value in any of the
objects is more than (cached average)\*10%/(count of changed objects).
If the count is \[100; 500), you want to cache the value on the first
server with the same conditions. If the count is \<100, you want to
cache, but only in memory.

![Step 8 —
Multicache](Example-Architecture-1/Step%208%20—%20Multicache.png) 

> *Do you like it? Do you like it?\! Do YoU lIkE iT?\!\!1 Actually,
> seems quite good.*

(—insert drawing here—)

And that profiling? You feel it is ineffective to do that on the first
server for the caching that is done on the second server. You want to
make it async and replicate it on both servers.

> Seems like such change would require even more redesign in
> conventional architecture — so we skip that.

(—insert drawing here—)

But you also want to use only database B.

(—insert drawing here—)

### A dynamic-input system (game)

Let’s model a simple open-world RPG in both GeSA and conventional OOP.

(—insert drawing here—)(—insert drawing here—)

And let’s add a DLC with a motorcycle.

(—insert drawing here—)(—insert drawing here—)

> GeSA is very much a state-machine on steroids. So whenever you need
> state-machine-like functionality but with steroids — GeSA may be the
> best choice)

### Another dynamic-input system (SCADA/IoT)

…

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
