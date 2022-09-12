# Numerical Libraries

There are several versions of BLAS (Basic Linear Algebra Subprograms) and LAPACK (Linear Algebra PACKage) numerical libraries installed on the system. There are a number of versions available on ARC3/4, Intel's Maths Kernel Library (MKL) library, Automatically Tuned Linear Algebra Software (ATLAS) and the original Netlib. All these libraries, aside from Netlib, are optimised to run on the available hardware. Netlib reference versions are only installed for completeness and we advise that you use one of the other implementations wherever possible.

## Setting the module environment

All available modules can be listed via the `module avail` command. Numerical libraries will be listed under the `/apps/Modules/libraries` heading. 
To load a specific library, e.g. MKL:

```
$ module load mkl
```

to switch to another version of the libraries, e.g. Atlas:

```
$ module switch mkl atlas
```

This will load the appropriate libraries and paths for your chosen compiler and bit environments.

### Compiler Flags

To simplify linking to the various versions of the numerical libraries, loading the modules as described above will also set up customised environment variables, `$ARC_LINALG_FFLAGS` for use with Fortran and `$ARC_LINALG_CFLAGS` for C. For the multi-threaded versions of the libraries use `$ARC_LINALG_MT_FFLAGS` for Fortran and `$ARC_LINALG_MT_CFLAGS` for C.

#### Fortran

For instance, to compile a simple Fortran program, named `matmul.f90` with the MKL library, first load the module:

```
$ module load mkl
```

and to compile the code, with the default Intel compiler use:

```
$ ifort -o matmul matmul.f90 $ARC_LINALG_FFLAGS
```

To switch to the GNU compiler and a different version of the libraries, e.g. ATLAS:

```
$ module switch intel gnu
$ module switch mkl atlas
```

To compile and link to the libraries use:

```
$ gfortran -o matmul matmul.f90 $ARC_LINALG_FFLAGS
```

#### C

To compile a simple C program, named `matmul.c` with the MKL library, first load the module

```
$ module load mkl
```

and to compile the code, with the default Intel compiler use:

```
$ icc -o matmul matmul.c $ARC_LINALG_CFLAGS
```

To switch to the GNU compiler and a different version of the libraries, e.g. ATLAS:

```
$ module switch intel gnu
$ module switch mkl atlas
```

To compile and link to the libraries use:

```
$ gcc -o matmul matmul.f90 $ARC_LINALG_CFLAGS
```
