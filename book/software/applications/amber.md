# Amber

## Introduction

Before you are able to access AMBER, you will be asked to read and agree to the licence terms.

These can be viewed by following [this
link](https://ambermd.org/LicenseAmber20.pdf). You are recommended to
print out and sign a copy for your own reference.

To access Amber, load its module through:

```bash
$ module add amber
```

This sets the `AMBERHOME` environment variable and your path to include the `bin` directory, with common executables as follows:

```bash
$AMBERHOME/bin/sander # Serial version of SANDER

$AMBERHOME/bin/sander.MPI   # built to run over Infiniband

$AMBERHOME/bin/pmemd  # Serial version of PMEMD

$AMBERHOME/bin/pmemd.MPI   # pmemd built to run over Infiniband
```

## Example job submission scripts

The following script will run `pmemd` on 16 cores for 48 hours, the module command is included in the submission script therefore it is not necessary to have the environment loaded prior to job submission:

```bash
#!/bin/sh
#$ -cwd
#$ -l h_rt=48:00:00
#$ -pe ib 16
module add amber

l=md19
f=md20
mpirun pmemd.MPI  -O -i $f.in -o $f.out -inf $f.inf \
        -c gc90turn10wat.$l -ref gc90turn10wat.$l -r gc90turn10wat.$f \
        -p gc90turn10wat.top -x gc90turn10wat$f.x -e gc90turn10wat$f.ene
```

This script can be submitted to the batch queues with:

```bash
$ qsub run.sh
```
