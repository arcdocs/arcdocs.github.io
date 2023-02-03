# PETSc

PETSc, the Portable, Extensible Toolkit for Scientific Computation, pronounced PET-see (/?p?t-si?/), is a suite of data structures and routines for the scalable (parallel) solution of scientific applications modeled by partial differential equations. It supports MPI, and GPUs through CUDA, HIP or OpenCL, as well as hybrid MPI-GPU parallelism; it also supports the NEC-SX Tsubasa Vector Engine. PETSc (sometimes called PETSc/TAO) also contains the TAO, the Toolkit for Advanced Optimization, software library.



Read more about PETSc on their [website](https://petsc.org/release/).





## Licensing

Distributed under a BSD license.



## The PETSc module on the HPC

The PETSc module can be loaded into your environment with the following command:

```bash
$ module add petsc
```

The PETSc module is available on ARC3:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC3
  - petsc 3.10.2
  - `module add petsc/3.10.2`

* - ARC3
  - petsc 3.4.5
  - `module add petsc/3.4.5`

```
