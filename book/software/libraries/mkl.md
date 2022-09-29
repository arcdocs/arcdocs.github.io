# MKL

Intel oneAPI Math Kernel Library, formerly Intel Math Kernel Library (Intel MKL), is a library of optimized math routines for science, engineering, and financial applications. Core math functions include BLAS, LAPACK, ScaLAPACK, sparse solvers, fast Fourier transforms, and vector math.



Read more about MKL on their [website](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl.html).





## The MKL module on the HPC

The MKL module can be loaded into your environment with the following command:

```bash
$ module add mkl
```

The MKL module is available on ARC3 and ARC4:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC4
  - mkl 2019.0
  - `module add mkl/2019.0`

* - ARC3
  - mkl 2018.2
  - `module add mkl/2018.2`

* - ARC3
  - mkl 11.3u2
  - `module add mkl/11.3u2`

* - ARC3
  - mkl 2017.1(default)
  - `module add mkl/2017.1(default)`

```

## Additional Notes

Please also refer to the general notes on how to use [Linear Algebra Libraries](./linalg) on ARC.
