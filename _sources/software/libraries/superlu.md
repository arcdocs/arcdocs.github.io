# SuperLU

SuperLU is a general purpose library for the direct solution of large, sparse, nonsymmetric systems of linear equations. The library is written in C and is callable from either C or Fortran program. It uses MPI, OpenMP and CUDA to support various forms of parallelism. It supports both real and complex datatypes, both single and double precision, and 64-bit integer indexing. The library routines performs an LU decomposition with partial pivoting and triangular system solves through forward and back substitution. The LU factorization routines can handle non-square matrices but the triangular solves are performed only for square matrices. The matrix columns may be preordered (before factorization) either through library or user supplied routines. This preordering for sparsity is completely separate from the factorization. Working precision iterative refinement subroutines are provided for improved backward stability. Routines are also provided to equilibrate the system, estimate the condition number, calculate the relative backward error, and estimate error bounds for the refined solutions.



Read more about SuperLU on their [website](https://portal.nersc.gov/project/sparse/superlu/).





## Licensing

Distributed with a permissive [project specific license](https://portal.nersc.gov/project/sparse/superlu/License.txt).



## The SuperLU module on the HPC

The SuperLU module can be loaded into your environment with the following command:

```bash
$ module add superlu
```

The SuperLU module is available on ARC4:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC4
  - superlu 5.2.2
  - `module add superlu/5.2.2`

```
