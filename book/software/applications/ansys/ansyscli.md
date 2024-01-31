# Ansys CLI

Once the license and module have been set up correctly, Ansys Command-Line Interface (CLI) can be
run both in serial and in parallel.

## Running Ansys CLI in Serial mode

There are three ways in which to launch Ansys CLI in serial:

- On login nodes
- As an [interactive session](../../../usage/interactive)
- As a [batch job](../../../usage/batchjob)

### Using on Login nodes

```{warning}
Please note you should not run full experiments on the login nodes. Only use this method for quick tests, or interactive exploring of the tool.
```

Once the Ansys module is loaded, Ansys can be run using a command with the version number included in the executable name.  For Ansys 2022R1, this is as follows:

```bash
$ module add ansys/2022R1
$ ansys221 -g
```

This runs it graphically, so it's important you have X forwarding enabled or are using [X2Go](../../../getting_started/x2go).

### Running through the batch queues

When running through the [batch queues](../../../usage/batchjob), no interactive input is possible. It is possible to create a journal file which contains all of the commands that would normally be entered within Ansys CLI, in a similar way to how it works with Fluent.

It is then necessary to construct a [job submission script](batchjob:resource-specification) that will run Ansys CLI. The job submission script begins with a request for resources and the executable to be run, e.g.:

```bash
#!/bin/bash
# Use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
#Launch the executable
module add ansys/2022R1
export ANSYSLMD_LICENSE_FILE=<port>@<host>
export LSTC_LICENSE=ANSYS
ansys221 -p ANSYS -b -i example.inp -o example.out
```

In this case, we're running the Ansys CLI with:

| Syntax           | Description |
| -----------      | ----------- |
| `-p ANSYS`       | Start using the ANSYS product |
| `-b`             | Run in batch mode             |
| `-i example.inp` | Use example.inp input file    |
| `-o example.out` | Use example.out output file   |

The file can be submitted to the queue by typing this (assuming you'd written the above into a file called ansys.sh):

```bash
$ qsub ansys.sh
```

## Running in parallel

```bash
#!/bin/bash
# use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
# Run on 8 processors
#$ -pe smp 8
# define license and load module
module add ansys/2022R1
export ANSYSLMD_LICENSE_FILE=<port>@<host>
export LSTC_LICENSE=ANSYS
#Launch the executable
ansys221 -np $NSLOTS -p ANSYS -b -i example.inp -o example.out
```

The file can be submitted to the queue by typing this (assuming you'd written the above into a file called ansys.sh):

```bash
$ qsub ansys.sh
```

### GPU execution using the batch queues

Ansys supports the use of GPUs, although we have no data on the performance speed up for typical jobs, but as a starting point, you may want something like this:

```bash
#!/bin/bash
# use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
# Run on 1 GPUs on ARC4 (using coproc_p100=1 on ARC3)
#$ -l coproc_v100=1
# define license and load module
module add ansys/2022R1
export ANSYSLMD_LICENSE_FILE=<port>@<host>
export LSTC_LICENSE=ANSYS
# Fix to make it launch correctly
unset PE_HOSTFILE
#Launch the executable
ansys221 -np $NSLOTS -acc nvidia -na $ARC_SGE_RESOURCE_COPROC_V100 -p ANSYS -b -i example.inp -o example.out
```

The file can be submitted to the queue by typing this (assuming you'd written the above into a file called ansys.sh):

```bash
$ qsub ansys.sh
```

````{admonition} GPU performance
You really want to make sure that this gives you a significant performance advantage by using a GPU compared with running a standard CPU job.  Please do let us know how you get on with this if you do experiment with GPU acceleration, as this is currently untested.
````
