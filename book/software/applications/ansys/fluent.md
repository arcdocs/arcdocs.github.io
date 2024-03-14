# Fluent

Once the license and module have been set up correctly, Fluent can be run both in serial and in parallel.  We generally recommend running Fluent either in serial for short test jobs, or in parallel on whole nodes, to ensure consistent good performance.

## Running Fluent in Serial mode

There are three ways in which to launch fluent in serial:

- On login nodes
- As an [interactive session](../../../usage/interactive)
- As a [batch job](../../../usage/batchjob)

```{note}
When launching the Fluent GUI you must have an X-server running locally and have enabled [X11 forwarding](../../../getting_started/logon/x11-graphics) through your SSH client.
```

### Using on Login nodes

```{warning}
Please note you should not run full experiments on the login nodes. Only use this method for quick tests!
```

Once the Ansys module is loaded, fluent can be run by entering its name at the command prompt:

```bash
$ fluent
```

### Running interactively through the batch queues

Once the desired Ansys module has been loaded, to launch fluent in serial in an [interactive session](../../../usage/interactive), use the following commands in the terminal:

```bash
$ qrsh -cwd -V -l h_rt=<hh:mm:ss> -l h_vmem=<vmem> fluent <dim>
```

In the above command, `hh:mm:ss` is the length of real-time the shell will exist for, `vmem` is the amount of memory required, `dim` is the dimension/precision of the fluent process (e.g. `2d` for two dimension, single precision).

For example, to launch the fluent GUI in an [interactive session](../../../usage/interactive) for 3D double precision, issue:

```bash
$ qrsh -cwd -V -l h_rt=6:00:00 -l h_vmem=2G fluent 3ddp
```

### Running through the batch queues

When running through the [batch queues](../../../usage/batchjob), no interactive input is possible. It is possible to create a journal file which contains all of the commands that would normally be entered within fluent, e.g. file test.jou :

```
file/read-case test.cas
file/read-data test.dat
solve iter 4
/file/write-data test2.dat
y
/exit
y
```

It is then necessary to construct a job submission script that will run fluent. The job submission script begins with a request for resources and the executable to be run, e.g. :

```bash
#!/bin/bash
# Export all variables and use current working directory
#$ -V -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
#Launch the executable
module add ansys/2022R1
export ANSYSLMD_LICENSE_FILE=<port>@<host>
fluent 3ddp -g -i test.jou
```

In this case, the 3-dimensional, double precision module is launched, however this can be interchanged with any other modules. The `-g` option will suppress the GUI and `-i` specifies the name of the input journal file. The file can be submitted to the queue by typing:

```bash
$ qsub fluent.sh
```

The above job submission script assumes that the Ansys module is loaded and license is defined. If desired, the module command can be loaded into the job submission script (removing the `-V`):

```bash
#!/bin/bash
# Use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
#Launch the executable
module add ansys/2022R1
export ANSYSLMD_LICENSE_FILE=<port>@<host>
fluent 3ddp -g -i test.jou
```

## Running in parallel

There are three ways of launching Fluent to work in parallel:

- On login nodes
- As an [interactive session](../../../usage/interactive)
- As a [batch job](../../../usage/batchjob)

To launch an [interactive session](../../../usage/interactive) with high resource requirements, load the ansys module and type the following at the command prompt:

```bash
$ qrsh -cwd -V -l h_rt=<hh:mm:ss> -l nodes=<nodes> fluent <dim> -rsh -scheduler_tight_coupling
```

In the above commands `hh:mm:ss` is the length of real-time the shell will exist for and `nodes` is the number of nodes requested. `dim` is the dimension/precision of the fluent process (e.g. 3ddp for 3-D double precision). E.g. the to launch fluent for 6 hours on 40 processors on ARC4:

```bash
$ qrsh -cwd -V -l h_rt=6:00:00 -l nodes=1 fluent 2d -rsh -scheduler_tight_coupling
```

We'd not normally recommend running Fluent interactively on the HPC though, as you're almost always better running batch jobs.

### Running a large mesh interactively

Occasionally, you will need to have interactive access to a large model that requires large amounts of memory and/or cores.
Whilst it might be possible to use a login node to do this for a short period of time, this is not a preferred option as the login nodes are a shared resource.

However, you can request an interactive session on the backend compute nodes to do this.

### Parallel execution through the batch queues

Parallel execution via the batch queues is performed by combination of the techniques mentioned above. Firstly a journal file (`test_para.jou`) should be created to control the parallel run, without the aid of the GUI file:

```
file/read-case test_para.cas
file/read-data test_para.dat
solve iter 4
/file/write-data test2_para.dat
y
/exit
y
```

Then a job submission script (`fluent_para.sh`) should be created, that requests resources and executes the code:

```bash
#!/bin/bash
# use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
# Run on 40 processors on ARC4
#$ -l nodes=1
# define license and load module
module add ansys/2022R1
export export ANSYSLMD_LICENSE_FILE=<port>@<host>
#Launch the executable
fluent -g -i test_para.jou 3ddp -rsh -scheduler_tight_coupling
```

In this case, the 3-dimensional, double precision module is launched on 40 processors. The `-g` option will suppress the GUI and `-i` specifies the name of the input journal file. The file can be submitted to the queue by typing:

```bash
$ qsub fluent_para.sh
```

The job will be run once the requested resources become available.

### Smaller parallel jobs

If you want to run on multiple cores but use less than a whole node, it's
recommended that you use the smp parallel environment, and use a slightly
different fluent command:

```bash
#!/bin/bash
# use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
# Run on 8 cores
#$ -pe smp 8
# Request 4Gbytes per core
#$ -l h_vmem=4G
# define license and load module
module add ansys/2022R1
export ANSYSLMD_LICENSE_FILE=<port>@<host>
#Launch the executable
fluent -g -i test_para.jou 3ddp
```

### GPU execution using the batch queues

Fluent supports the use of GPUs, although we've not currently seen significant benefit from doing so on ARC.  To submit a GPU job:

```bash
#!/bin/bash
# use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
# Run on 1 GPU on ARC4 (using coproc_p100=1 on ARC3)
#$ -l coproc_v100=1
# define license and load module
module add ansys/2022R1
export ANSYSLMD_LICENSE_FILE=<port>@<host>
#Launch the executable
fluent -g -i -gpgpu=1 test_para.jou 3ddp -rsh -scheduler_tight_coupling
```

## Running with Fluent 19.2 or below

When running these versions, omit the `-scheduler_tight_coupling` parameter.

## Running with old version of Fluent v15 or below

When running Fluent v15 or below in parallel batch mode, additional parameters need to be added to the Fluent command line in the batch submission script.

Taking the script in the previous section as an example, the line:

```bash
fluent -g -i test_para.jou 3ddp -rsh
```

Should be switched to:

```bash
fluent -g -i test_para.jou 3ddp -pib -sgeup
```

## Additional notes

There are also known inefficiencies when running fluent on part nodes on ARC, which is why the above examples all use `-l nodes=<nodes>` to ensure exclusive access to nodes.  For optimal performance, run fluent on whole nodes.  For example, to run on a single node:

```bash
#!/bin/bash
# use current working directory
#$ -cwd
# Request three hours of runtime
#$ -l h_rt=3:00:00
# Run on 1 nodes (24 cores on ARC3, 40 cores on ARC4)
#$ -l nodes=1
# define license and load module
module add ansys/2020R2
export ANSYSLMD_LICENSE_FILE=<port>@<host>
#Launch the executable
fluent -g -i test_para.jou 3ddp -rsh -scheduler_tight_coupling
```

You will wait slightly longer for a whole node than using the scattered allocation model (`-pe ib 40`), but your code is likely to run significantly faster.
