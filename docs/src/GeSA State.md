
## Current state

There is a basic version implemented in Swift —
[MicroGene](https://github.com/morpheby/MicroGene). It lacks some of the
advertised features, but it provides the necessary foundation to implement
software based on Genetic System Architecture. And, most importantly, I use it
to develop fully-featured GeSA right now.

Also, it would be awesome to have later:

* GeSA-based language
* GeSA compartment and data ACLs with Gene trust features
* GeSA bindings or reimplementations for other languages
* Better matching algorithms
* Fully-featured MBEs (probably as part of the language)
* Gene-packs as libraries
* GeSA debugger
* GeSA IDE with data visualization and Gene overview
* GeSA-based OS with apps as Gene-packs
* Hardware-based gene-packs

Some already planned changes to make

* Internalize Genes and theirs execution into the system itself.
  
  The intention of this feature is to make Genes that are in a state before
  executing and just after matching be internal to the storage and bindable to.
  They should also have controls over their execution embedded into them and
  maybe some additional functions (to be determined later). This should remove
  the special case of interceptors and would allow for greater flexibility of
  execution contexts and execution facilities.


