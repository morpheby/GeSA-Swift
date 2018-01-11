
## A short comparison

So basically GeSA combines:

* Event-Driven programming. Genes basically react to events that happen in the
  Storage. The main difference is that unlike with events, there is the central
  Storage, and events are bound to abstract condition definitions that may not
  be ever present.
* Some Functional programming. Genes are supposed to have no side effects and
  only transform inputs. Of course, in real app this isn’t necessarily the case
  as some actions would certainly require side effects.
* Aspect-Oriented programming. Genes and Storage can be understood as advices
  and a centralized join-point collection.
* Data-driven programming. Genes are the combination of input conditions and
  data transformation. Unlike in Data-driven programming, there is no
  whole-program input, and so Genes have no differentiation between external
  input and other Gene’s outputs.

Sure, I’m not stating that I’m taking the best of those. Each has lots of
downsides to it, and some of them are also relevant to GeSA.
