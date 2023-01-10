# FFTW

FFTW is a C subroutine library for computing the discrete Fourier transform (DFT) in one or more dimensions, of arbitrary input size, and of both real and complex data (as well as of even/odd data, i.e. the discrete cosine/sine transforms or DCT/DST). We believe that FFTW, which is free software, should become the FFT library of choice for most applications.



Read more about FFTW on their [website](https://www.fftw.org/).





## Licensing

Released under the GNU General Public License (GPL, see [FFTW license](https://www.fftw.org/doc/License-and-Copyright.html)).



## The FFTW module on the HPC

The FFTW module can be loaded into your environment with the following command:

```bash
$ module add fftw
```

The FFTW module is available on ARC3 and ARC4:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC4
  - FFTW 3.3.8
  - `module add fftw/3.3.8`

* - ARC4
  - FFTW 2.1.5
  - `module add fftw/2.1.5`

* - ARC3
  - FFTW 3.3.7
  - `module add fftw/3.3.7`

* - ARC3
  - FFTW 3.3.6-pl1
  - `module add fftw/3.3.6-pl1`

* - ARC3
  - FFTW 2.1.5
  - `module add fftw/2.1.5`

```
