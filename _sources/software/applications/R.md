# R

R is a programming language and software environment initially developed for statistical and graphical computing. It has grown in popularity and is used for a diverse range of research problems.

## Selecting an R version

There are multiple versions of R installed on ARC3/4.  You can load the default version of R available on each with the command:

```bash
$ module add R
```

However, if you want another version of R you can install it through the conda packagement system included in the Anaconda module. For example to install R/4.0.3 you would do the following:

```bash
# load the anaconda module
$ module load anaconda

# use conda to create an environment in which we install r version 4.0.3, using the conda forge channel
$ conda create -n r4 -c conda-forge r-base=4.0.3

# activate and enter this new environment
$ source activate r4
```

You can then use this version of R as outlined in the rest of this page. For more information on the conda commands used here check the [conda documentation](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html#managing-conda).

## Launching on the front end

R can be launched by entering its name at the command prompt; i.e.:

```bash
$ R
```

Please note that this method should not be used apart from for quick
tests. Exit the R console by typing.

```R
q()
```

## Running through an interactive shell

The following will launch R interactively via the batch queues.

```bash
$ qrsh -cwd -V-l h_rt=<time>,h_vmem=<mem> R
```

In the above command,`<time>` is the length of real-time the shell will exist for, and `<mem>` is how much memory you're requesting. e.g. to run R for 6 hours, with 4G of RAM:

```bash
$ qrsh -cwd -V -l h_rt=6:00:00,h_vmem=4G R --vanilla
```

This will run R from within the terminal from which it was launched.

Follow this link for further information on the [meaning of R startup flags](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/Startup).

## Batch Execution

To run R in batch-mode you must first generate a list of commands for R to process in a file, e.g. `example.R`.

A script must then be created that will request resources from the queuing system and launch the R executable; script `runR.sh`:

```bash
#!/bin/bash
# Run in current working directory and use current environment
#$ -cwd -V
# Set a 6 hour limit
#$ -l h_rt=6:00:00
#Request more memory, the default is 1Gb
#$ -l h_vmem=1536M
# Load R module
module add R
# run R using command file
Rscript example.R
```

This can be submitted to the queuing system using:

```bash
$ qsub runR.sh
```

## Installing R packages

Given the large number of R packages available and pace of development, it is preferable that users install the packages they need as opposed to using a centrally provided set of packages.

To install package `foo`, start an R session by entering its name at the command prompt; i.e.:

```bash
$ R
```

and then from within R, install the package:

```R
> install.packages('foo')
```

This will install the package and any dependencies that are required. It will do this by creating a local library (in your home directory by default) where it saves the package binaries and archives. The package should then be accessible from subsequent R interactive sessions and batch jobs.

If you're using a conda installed version of R, these will install into your conda environment instead.
