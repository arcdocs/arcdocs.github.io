# ATLAS

The ATLAS (Automatically Tuned Linear Algebra Software) project is an ongoing research effort focusing on applying empirical techniques in order to provide portable performance. At present, it provides C and Fortran77 interfaces to a portably efficient BLAS implementation, as well as a few routines from LAPACK.



Read more about atlas on their [website](http://math-atlas.sourceforge.net/).





## Licensing 

ATLAS uses a BSD-style license, without the advertising clause. [Read it here](http://math-atlas.sourceforge.net/faq.html#license).



## The ATLAS module on the HPC

The ATLAS module can be loaded into your environment with the following command:

```bash
$ module add atlas
```

The ATLAS module is available on ARC3:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC3
  - atlas 3.10.3
  - `module add atlas/3.10.3`

```

## Additional Notes

Please also refer to the general notes on how to use [Linear Algebra Libraries](./linalg) on ARC.
