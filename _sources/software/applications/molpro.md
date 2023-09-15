# Molpro

## Setting up the environment

To set up the environment load the version of the software that you want to
use. For example for version `2010.1.25` use:

```bash
$ module add molpro/2010.1.25
```

## Scratch files

Molpro writes a larges amount of temporary or scratch files. By default these
are written to the `/tmp` directory on compute nodes. The `/tmp` directories
are usually fairly small and may fill up quickly causing jobs to fail. In this
case, to avoid these failures you may need to change the location of the
scratch files. You can redirect these scratch files to another directory, such
as the local SSD, or an area on /nobackup using the `-d` argument, e.g.:

```bash
# Use locally allocated space
$ molpro -d $TMPDIR
# or if this is insufficient
$ molpro -d /nobackup/your_scratch_directory
```

The directory `/nobackup/your_scratch_directory` is a directory that you create
in the `/nobackup` area. Read more about the `/nobackup` filesystem
[here](storage:nobackup).

## Example job scripts

### Serial job submission

To run jobs through the batch scheduler, you need to submit them by using the
command `qsub <script name>`.  Below is an example job script. The example
script below requests 1Gb RAM per core, and a single core for 2 hours, using
the current environment and running from the current working directory.  It
runs the molpro script called `example.com`.

```bash
#!/bin/bash
#$ -l h_rt=2:0:0
#$ -l h_vmem=1G
#$ -V
#$ -cwd
molpro -d $TMPDIR example.com
```

### MPP job submission

This is the same as the serial version, but asks for 8 cores and uses the MPP mode.

```bash
#!/bin/bash
#$ -l h_rt=2:0:0
#$ -l h_vmem=1G
#$ -pe smp 8
#$ -V
#$ -cwd
molprop -n $NSLOTS -d $TMPDIR example.com
```

### MPPX job submission

This is the same as the serial version, but asks for 8 cores and uses the MPPX mode.

```bash
#!/bin/bash
#$ -l h_rt=2:0:0
#$ -l h_vmem=1G
#$ -pe smp 8
#$ -V
#$ -cwd
molprox -t $NSLOTS -d $TMPDIR example.com
```
