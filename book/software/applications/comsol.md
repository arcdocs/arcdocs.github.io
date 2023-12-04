# Comsol

## Introduction

COMSOL Multiphysics provides a range of simulation, finite element analysis and
solver functionality. More information on the package is available from the
[COMSOL website](http://www.comsol.com/).

## Versions available

```{list-table}
:header-rows: 1
:widths: 10 10 30

* - System
  - Version
  - Load command
* - ARC3
  - 5.2
  - `module add comsol/5.2`
* - ARC3
  - 5.2a
  - `module add comsol/5.2a`
* - ARC3
  - 5.3
  - `module add comsol/5.3`
* - ARC3
  - 5.3a
  - `module add comsol/5.3a`
* - ARC3
  - 5.4
  - `module add comsol/5.4`
* - ARC3
  - 5.5
  - `module add comsol/5.5`
* - ARC4
  - 5.3a
  - `module add comsol/5.3a`
* - ARC4
  - 5.4
  - `module add comsol/5.4`
* - ARC4
  - 5.5
  - `module add comsol/5.5`
* - ARC4
  - 6.0
  - `module add comsol/6.0`
* - ARC4
  - 6.1
  - `module add comsol/6.1`
```

## Accessing the software

To make COMSOL available in your environment, use the desired `module add`
command from the table above.

## Example script

This script will request exclusive access to an entire node.

```bash
#!/bin/bash
# Run in current working directory with current environment
#$ -cwd -V

#change this line for time
#$ -l h_rt=01:00:00

#Email on start and end of job
#$ -m be

#the line below sets the number of cores and nodes
#$ -l nodes=1

module add comsol/5.1
export LM_LICENSE_FILE=<port@server>:$LM_LICENSE_FILE
comsol batch -np $NSLOTS \
             -tmpdir $TMPDIR \
             -inputfile input.mph \
             -outputfile outphysics.mph \
             -recoverydir /nobackup/$USER/comsolrecovery
```

In the script above:

Change `<port@server>` to the license server details obtained from your
supervisor. For example if you are given `1322@server` :

```bash
export LM_LICENSE_FILE=1322@server:$LM_LICENSE_FILE
```

## Using batch licenses

In addition to the default licenses available for COMSOL, additional batch
licenses are available.  These can be used by adding an additional flag to you
COMSOL command `-usebatchlic`.

## Managing comsol memory usage while running

Running comsol in command line can often create a large number of temporary
files in the `.comsol` directory in your home directory ([Details on running
comsol in command line](https://www.hpc.dtu.dk/?page_id=1257)). This can often
lead to a quota exceeded error on jobs.

To resolve this we recommend creating a comsolrecovery directory in your
nobackup and adding the following line to your comsol batch command in your
submission script `-recoverydir /nobackup/$USER/comsolrecovery`.
