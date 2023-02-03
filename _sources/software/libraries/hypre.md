# HYPRE

Livermore's HYPRE library of linear solvers makes possible larger, more detailed simulations by solving problems faster than traditional methods at large scales. It offers a comprehensive suite of scalable solvers for large-scale scientific simulation, featuring parallel multigrid methods for both structured and unstructured grid problems. The HYPRE library is highly portable and supports a number of languages.



Read more about HYPRE on their [website](http://www.llnl.gov/CASC/hypre).





## Licensing

HYPRE is distributed under the terms of both the MIT license and the Apache License (Version 2.0). Users may choose either license, at their option.



## The HYPRE module on the HPC

The HYPRE module can be loaded into your environment with the following command:

```bash
$ module add hypre
```

The HYPRE module is available on ARC3:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC4
  - hypre 2.14.0
  - `module add hypre/2.14.0`

* - ARC3
  - hypre 2.14.0
  - `module add hypre/2.14.0`

* - ARC3
  - hypre 2.11.2
  - `module add hypre/2.11.2`

```
