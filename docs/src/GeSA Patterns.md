
## Some basic and advanced patterns to consider

### Bridging object instance or OS resource (bridging from OOP)

Put the instance into storage at a pre-defined path. Match by this path on all
Genes that require that object. Access is by design thread-safe.

If the object requires a specific execution thread, add this to the Gene
specification (should be a feature of a GeSA implementation).

### Performing sequential execution (bridging from procedural programming)

Create a dummy data value and put it into a pre-defined path. Match by this
path on all Genes that require to be never executed in parallel.

If the object requires a specific execution thread, add this to the Gene
specification.

### Using GeSA process in a procedural way (Bridging GeSA into other paradigms)

Create an OS lock object and put it into storage. Then put the input data in
the storage. Wait on the lock. Have a Gene that matches the final result of the
process and the lock created — and unlocks the lock.

### Alter the data with a single-run process in the already established process

Match with a higher priority. Add a marker to the output. Never match if the
marker is present.

### Perform non-concurrent operation (use locking mechanism)

Create an empty object and put it at a pre-defined path. Match by this object
on all Genes that work on the same process and require non-concurrent access.

This effectively makes the object into a kind of 'token', allowing execution
only to the Gene that has it bound.

(more later)
