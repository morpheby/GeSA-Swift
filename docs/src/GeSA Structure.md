
## How it is made

Let’s start with the two most important components: *Gene* and *Storage*.

**Storage** is a global data-space where Genes put theirs output and from where
it is taken to other Genes. Storage is separated in named compartments (the
type of naming system is not important — the language may use symbols, strings,
UUIDs or whatever is best suited), compartments can be nested and can contain
named data values. Multiple data values of same or different types can share
the same name (but doing so too much may impact performance, unless it is
intended for parallelization).

Each data value stored is *unique and non-copyable*. Its access is guaranteed
to be *exclusive* for the Gene it was given to.

A Gene is defined by two parts: a *match-bind expression (MBE)* and an
*executable*. When an MBE of the Gene is successfully matched with some data in
the storage, the data is taken out from the storage and bound to that Gene.
Right after that, the executable of that Gene will be called, which can produce
some output at the end. So basically, a Gene is an object that has a condition
(match part of MBE), some variables/properties (bind part of MBE) as an input,
some defined transformation (executable part), and some output (return value of
the executable).

> In fact, it is very similar to Actors and the only major difference from
> Actors is that there is no “sending of messages”; instead, messages find
> their target Gene.

There are also some additional components which can be added onto Genes to
implement specific features. Most of them will be explored below.
