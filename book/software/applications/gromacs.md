# Gromacs

## Introduction

[Gromacs](https://www.gromacs.org) is freely available and open source software.

## Setting the module environment

A number of versions of Gromacs are available on the facility.

To load gromacs into your environment use (for example):

```bash
$ module add gromacs/2020.3gpu
```

This will now provide you with access to the gromacs executables from the
command line.  Older versions were built separately with and without GPU
support.  Since 2023.1 there is only one version, which supports single
precision and GPUs.

Alternatively you can load the default version of gromacs installed on ARC with
the command:

```bash
$ module add gromacs
```

## Executable naming conventions

Modern Gromacs tends to use just one main command:

|Executable               |Description
|-------------------------|--------------------------
|`gmx`                    |single precision serial executable

Non-GPU builds also provide:

|Executable               |Description
|-------------------------|--------------------------
|`gmx_d`                  |double precision serial executable

With older versions, there were also:

|Executable               |Description
|-------------------------|--------------------------
|`mdrun`                  |single precision serial executable
|`mdrun_d`                |double precision serial executable
|`mpirun mdrun_mpi`       |single precision parallel MPI executable
|`mpirun mdrun_mpi_d`     |double precision parallel MPI exectable

`Gromacs` versions below `4.6.3`:

|Executable               |Description
|-------------------------|--------------------------
|`mdrun.MPI`              |single precision, parallel MPI executable
|`mdrun_d.MPI`            |double precision, parallel MPI executable

There are also single/double precision versions of the tools that come with the
application for CPU builds, with the same naming scheme as above. For more
information look at the [Gromacs](http://www.gromacs.org/) homepage and at the
[Gromacs documentation](http://www.gromacs.org/Documentation).

## Batch execution with current versions

### Serial execution

An example job submission script (`example_serial.sh`) that runs a gromacs
executable is shown below:

```bash
#!/bin/bash
#$ -cwd -V
# request 10 hours of runtime
#$ -l h_rt=10:00:00
gmx mdrun <args>
```

This requests 10 hours of runtime, to run in the current directory `-cwd` and
using the current environment `-V`, using the single precision version of
mdrun, and where `<args>` represents the arguments to mdrun. More memory per
core can be requested, 2Gb for instance, by adding the line `#$ -l h_vmem=2G`
to the script. You can find more submission options on the [batch job
page](batchjob:list-of-sge-options).

The script can be submitted with:

```bash
$ qsub example_serial.sh
```

## Parallel execution

An example submission script (`example_parallel.sh`) looking to use the
parallel executable is shown below:

```bash
#!/bin/bash
#$ -cwd -V
# request 10 hours of runtime
#$ -l h_rt=10:00:00
# request 40 cores
#$ -l np=40
mpirun gmx_mpi mdrun <args>
```

This requests 10 hours of runtime, to run in the current directory `-cwd`,
using the current environment `-V`, running on 40 cores `-l np=40`, using the
single precision parallel version of mdrun, and where `<args>` represents the
arguments to `mdrun` .

Since we're using a whole node here, you'll get the maximum 4.8Gbytes per core
allocated.  You can find more submission options on the [batch job
page](batchjob:list-of-sge-options).

The script can be submitted with:

```bash
$ qsub example_parallel.sh
```

## Using a GPU

An example submission script (`example_gpu.sh`) looking to use the parallel
executable is shown below:

```bash
#!/bin/bash
#$ -cwd -V
# request 10 hours of runtime
#$ -l h_rt=10:00:00
# request a GPU on ARC4
#$ -l coproc_v100=1
gmx mdrun <args>
```

This requests 10 hours of runtime, to run in the current directory `-cwd`,
using the current environment `-V`, running with 1 GPU, 10 cores, and 48Gbytes
of RAM `-l coproc_v100=1`, using the single precision version of mdrun, and
where `<args>` represents the arguments to `mdrun` .

More memory per core cannot be requested, without also requesting more GPUs.
You can find more submission options on the [batch job
page](batchjob:list-of-sge-options).

The script can be submitted with:

```bash
$ qsub example_gpu.sh
```

## Batch execution with legacy versions

### Serial execution

An example job submission script (`example_serial.sh`) that runs a gromacs
executable is shown below:

```bash
#!/bin/bash
#$ -cwd -V
# request 10 hours of runtime
#$ -l h_rt=10:00:00
mdrun_d  <args>
```

This requests 10 hours of runtime, to run in the current directory `-cwd` and
using the current environment `-V`, using the double precision version of
mdrun, and where `<args>` represents the arguments to mdrun. More memory per
core can be requested, 2Gb for instance, by adding the line `#$ -l h_vmem=2G`
to the script. You can find more submission options on the [batch job
page](batchjob:list-of-sge-options).

The script can be submitted with:

```bash
$ qsub example_serial.sh
```

## Parallel execution

An example submission script (`example_parallel.sh`) looking to use the
parallel executable is shown below:

```bash
#!/bin/bash
#$ -cwd -V
# request 10 hours of runtime
#$ -l h_rt=10:00:00
# request 4 cores
#$ -pe ib 4
mpirun mdrun_mpi_d <args>
```

This requests 10 hours of runtime, to run in the current directory `-cwd`,
using the current environment `-V`, running on 4 cores `-pe ib 4`, using the
double precision parallel version of mdrun, and where `<args>` represents the
arguments to `mdrun` .

More memory per core can be requested, 2Gb for instance, by adding the line `#$
-l h_vmem=2G` to the script. You can find more submission options on the [batch
job page](batchjob:list-of-sge-options).

The script can be submitted with:

```bash
$ qsub example_parallel.sh
```

## Performance tuning Gromacs

General advice can be found at the
[Gromacs website](https://manual.gromacs.org/documentation/2023.1/user-guide/mdrun-performance.html).
