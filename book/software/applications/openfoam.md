# OpenFoam

OpenFOAM is a free, open source CFD software package; this does not require a
license to use.

OpenFOAM is an open-source set of C++ based command tools which can be used to
perform Computational Fluid Dynamics simulations, it is entirely based inside
the terminal and has no direct user interface. Results from the simulations can
be viewed by running the command `paraFoam` to launch an external viewing
application.

```{note}
Versions older than v1906 may behave slightly differently, such as not
requiring `source $FOAM_SRC_FILE` but use of these versions is not covered by
this documentation.  Usage described in this document assumes you're using
v1906 on ARC4, and may require some adjustment if using other versions, or
using ARC3.

It also assumes you're using the default module environment, and haven't
altered compilers being used.  If you have, please adjust accordingly.
```

## Tutorials

You are best looking at the official
[Tutorials](https://www.openfoam.com/documentation/tutorial-guide)

## Running OpenFOAM

### Setting up the environment

The openfoam installed on our systems is compiled with a gnu compiler rather
than the intel one which is the default in your environment. Before you can
load the openfoam module you will need to switch compilers.

```bash
$ module swap intel gnu/6.3.0
$ module add openfoam/v1906
```

The environment is not yet fully loaded. To check what you need to do you can
run the command:

```bash
$ module help openfoam/v1906
```

For v1906, next run the following command to access the openFoam command line
variables:

```bash
$ source $FOAM_SRC_FILE
```

### Launching on the front end

Visualisation of OpenFOAM results can be done using paraFoam at the command
prompt. You need to have an openfoam case file to do this fully:

```bash
$ paraFoam
```

If you're visualising large data sets this should not be done on the login
nodes, since this can use a considerable amount of RAM and CPU. Instead, this
should be done using an interactive job with SGE.

#### Running through an interactive shell

The following will launch paraFoam interactively, displaying the full GUI:

```bash
$ qrsh -cwd -V -l h_rt=<hh:mm:ss> paraFoam
```

In the above command, `<hh:mm:ss>` is the length of real-time the shell will
exist for, `-cwd` indicated the current working directory and `-V` exports the
the current environment.  For example, to run paraFoam for 1 hour:

```bash
$ qrsh -cwd -V -l h_rt=1:00:00 paraFoam
```

This will run paraFoam within the terminal from which it was launched.

#### Batch Execution

To run OpenFOAM in batch-mode you first need to setup your case.

A script must then be created that will request resources from the queuing
system and launch the desired OpenFOAM executables; script `runfoam.sh`:

```bash
#!/bin/bash
# Run in current working directory and import the current environment
#$ -cwd -V
# Set a 6 hour limit
#$ -l h_rt=6:00:00
# Load OpenFOAM module
module swap intel gnu/6.3.0
module add openfoam/v1906
source $FOAM_SRC_FILE
# Run actual OpenFoam commands
blockMesh
icoFoam
```

This can be submitted to the queuing system using:

```bash
$ qsub runfoam.sh
```

#### Parallel Execution

If you've configured your OpenFOAM job to be solved in parallel, you need to
prepare and submit it differently.  You will want to decompose your case first
with `decomposePar` after setting up the case for the desired number of
processors.  This can normally be done on a login node before submitting your
main job.  Here is an example of a suitable submission script:

```bash
#$ -l h_rt=01:00:00
#$ -l h_vmem=4.8G
#$ -pe smp 4
#$ -cwd -V
module swap intel gnu/6.3.0
module add openfoam/v1906
source $FOAM_SRC_FILE
mpirun interFoam -parallel
```

This will request 4 cores, and 19.2Gbytes of RAM.  If you needed less memory,
reduce the requested RAM per core.  If you needed more memory, you're best
asking for more cores rather than more RAM per core, if possible.

##### Jobs requiring a whole node or more

```bash
#$ -l h_rt=01:00:00
#$ -l np=40
#$ -cwd -V
module swap intel gnu/6.3.0
module add openfoam/v1906
source $FOAM_SRC_FILE
mpirun interFoam -parallel
```

This will request 40 cores and exclusive access to the nodes. On ARC4, this
results in a single node being allocated, with a full node's memory split
between those 40 cores.

If more memory per core is required, then reduce the number of processes per
node to split the available memory netween those active processes. For example:

```bash
#$ -l np=40,ppn=10
```

This will allocate 40 cores as before, but with 10 processes per node and so 4
nodes overall. The available memory per node is therefore allocated across four
nodes rather than one and so four times the memory would be available per core
compared to the previous example.
