# Ansys CLI

Once the license and module have been set up correctly, Ansys CLI can be
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

Once the Ansys module is loaded, Ansys can be run using a command with the version number included in the executable name.  For Ansys 2020R2, this is as follows:

```bash
$ module add ansys/2020R2
$ ansys202 -g
```

This runs it graphically, so it's important you have X forwarding enabled or are using [X2Go](../../../getting_started/x2go).

### Running through the batch queues

When running through the [batch queues](../../../usage/batchjob), no interactive input is possible. It is possible to create a journal file which contains all of the commands that would normally be entered within Ansys CLI, in a similar way to how it works with Fluent.

It is then necessary to construct a [job submission script](../../../usage/batchjob.html#resource-specification) that will run Ansys CLI. The job submission script begins with a request for resources and the executable to be run, e.g.:

```bash
#!/bin/bash
# Use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
#Launch the executable
module add ansys/2020R2
export ANSYSLMD_LICENSE_FILE=<LICENSESTRING>
ansys202 -p ANSYS -b -i example.inp -o example.out
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
module add ansys/2020R2
export ANSYSLMD_LICENSE_FILE=<LICENSESTRING>
#Launch the executable
ansys202 -np $NSLOTS -p ANSYS -b -i example.inp -o example.out
```

The file can be submitted to the queue by typing this (assuming you'd written the above into a file called ansys.sh):

```bash
$ qsub ansys.sh
```

### GPU execution using the batch queues

Ansys supports the use of GPUs, although this isn't known to work correctly on ARC4.  If you have experimented with this on ARC4, and have a recipe for running Ansys on the GPUs, please get in touch, and we can document it here.
