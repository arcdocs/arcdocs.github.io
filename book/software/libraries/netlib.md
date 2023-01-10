# Netlib

LAPACK is written in Fortran 90 and provides routines for solving systems of simultaneous linear equations, least-squares solutions of linear systems of equations, eigenvalue problems, and singular value problems. The associated matrix factorizations (LU, Cholesky, QR, SVD, Schur, generalized Schur) are also provided, as are related computations such as reordering of the Schur factorizations and estimating condition numbers. Dense and banded matrices are handled, but not general sparse matrices. In all areas, similar functionality is provided for real and complex matrices, in both single and double precision.



Read more about netlib on their [website](https://netlib.org/lapack).





## Licensing

Distributed under a BSD license.



## The netlib module on the HPC

The netlib module can be loaded into your environment with the following command:

```bash
$ module add netlib
```

The netlib module is available on ARC3 and ARC4:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC4
  - netlib 3.8.0
  - `module add netlib/3.8.0`

* - ARC3
  - netlib 3.8.0
  - `module add netlib/3.8.0`

```

## Additional Notes

Please also refer to the general notes on how to use [Linear Algebra Libraries](./linalg) on ARC.
