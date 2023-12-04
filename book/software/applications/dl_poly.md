# DL_POLY

## Introduction

DL_POLY is a general purpose molecular dynamics simulation tool developed and
provisioned for UK academia. You can read more about it on the [DL_POLY web
page](https://www.scd.stfc.ac.uk/Pages/DL_POLY.aspx).

## Licensing

To access this software you need to agree to the license terms, please submit a
request to the Research Computing team via our [contact
form](https://it.leeds.ac.uk/it?id=sc_cat_item&sys_id=7587b2530f675f00a82247ece1050eda)
confirming you accept the license terms and wish to be added to the DL_POLY
user group.

The licence terms are available on the [DLpoly license page](./dlpoly/license).

## Loading the module

DL_POLY versions 4.08 and 4.09 are currently available on ARC3 and 4.09 and
4.10 on ARC4.  You can add the DL_POLY module by using a command like this:

```bash
$ module add dl_poly/4.09
```

This adds the DL_POLY 4.09 executable files to your environment and must be
included in your job submission script to ensure your jobs can also access
DL_POLY.

## Usage

### DL_POLY 4.09/4.10

DL_POLY 4.09/4.10 is built with to both run in serial and in parallel depending
on the resources available using the single executable `DLPOLY.Z`.

#### Parallel execution

An example job submission script that calls DLpoly is shown below:

```bash
#$ -cwd -V
#$ -l h_rt=48:00:00
#$ -pe ib 16
module add dl_poly/4.10
mpirun -np $NSLOTS DLPOLY.Z
```

This requests 48 hours of runtime on 16 processes spread over Infiniband. It
can be submitted to the queue with the command:

```bash
$ qsub dlpoly.sh
```

#### Serial execution

DL_POLY can be run in serial using the same executable without prepending the
call with `mpirun`.

```bash
#$ -cwd -V
#$ -l h_rt=48:00:00
module add dl_poly/4.10
DLPOLY.Z
```

To submit the above script do:

```bash
$ qsub dlpoly_serial.sh
```

### DL_POLY 4.08

Version 4.08 is built on ARC3 and has a slightly different executable that can
be used as follows:

#### Job submission example

An example job submission script that calls to the `DL_POLY.Z.parallel`
executable and requests multiple cores over Infiniband.

```bash
#$ -cwd -V
#$ -l h_rt=48:00:00
#$ -pe ib 16
module add dl_poly/4.08
mpirun DLPOLY.Z.parallel
```

The same executable can also be used to run a job in serial.
