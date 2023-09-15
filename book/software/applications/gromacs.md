# Gromacs

## Introduction

Gromacs is freely available and open source software.

## Setting the module environment

A number of versions of Gromacs are available on the facility.

To load gromacs into your environment when you log in, use (for example):

```bash
$ module add gromacs/4.5.3
```

This will now provide you with access to the gromacs executeables from the command line.

Alternatively you can load the default version of gromacs installed on ARC with the command:

```bash
$ module add gromacs
```

Will load the executables for the default 4.6.3 version.

## Executable naming conventions

The main executables available are :

|Executable               |Description
|-------------------------|--------------------------
|`mdrun`                  |single precision serial executable
|`mdrun_d`               |double precision serial executable
|`mpirun mdrun_mpi`      |single precision parallel MPI executable
|`mpirun mdrun_mpi_d`   |double precision parallel MPI exectable

However, the naming convention for `Gromacs` versions below `4.6.3` are a little different:

|Executable               |Description
|-------------------------|--------------------------
|`mdrun.MPI`              |single precision, parallel MPI executable
|`mdrun_d.MPI`           |double precision, parallel MPI executable

There are also single/double precision versions of the tools that come with the application, with the same naming scheme as above. For more information look at the [Gromacs](http://www.gromacs.org/) homepage and at the [Gromacs documentation](http://www.gromacs.org/Documentation).

## Batch execution

### Serial execution

An example job submission script (`example_serial.sh`) that runs a gromacs executeable is shown below:

```bash
#!/bin/bash
#$ -cwd -V
# request 10 hours of runtime
#$ -l h_rt=10:00:00
mdrun_d  <args>
```

This requests 10 hours of runtime, to run in the current directory `-cwd` and using the current environment `-V`, using the double precision version of mdrun, and where `<args>` represents the arguments to mdrun. More memory per core can be requested, 2Gb for instance, by adding the line `#$ -l h_vmem=2G` to the script. You can find more submission options on the [batch job page](batchjob:list-of-sge-options).

The script can be submitted with:

```bash
$ qsub example_serial.sh
```

## Parallel execution

An example submission script (`example_parallel.sh`) looking to use the parallel executeable is shown below:

```bash
#!/bin/bash
#$ -cwd -V
# request 10 hours of runtime
#$ -l h_rt=10:00:00
# request 4 cores
#$ -pe ib 4
mpirun mdrun_mpi_d <args>
```

This requests 10 hours of runtime, to run in the current directory `-cwd`, using the current environment `-V`, running on 4 cores `-pe ib 4`, using the double precision parallel version of mdrun, and where `<args>` represents the arguments to `mdrun` .

More memory per core can be requested, 2Gb for instance, by adding the line `#$ -l h_vmem=2G` to the script. You can find more submission options on the [batch job page](batchjob:list-of-sge-options).

The script can be submitted with:

```bash
$ qsub example_parallel.sh
```
