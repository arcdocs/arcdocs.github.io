# IDL

IDL is a data analysis programming language. Only authorised users can use IDL. You can view more details about IDL at the [vendor website](http://www.exelisvis.co.uk/ProductsServices/IDL.aspx)

## Getting started

In order to use IDL on the ARC clusters, you will need to contact your supervisor for licence server information. This will normally be provided as a `port` and a `machine name` in the format `port@machine`.

You will need to set the `LM_LICENSE_FILE` environment variable before you use IDL:

```bash
export LM_LICENSE_FILE=port@machine:$LM_LICENSE_FILE
```

After that, you should be able to load the IDL module:

```bash
module add idl
```

and then run the application by entering the command `idl`.

## Running IDL as a batch job

An example job submission script that runs IDL is shown below:

```bash
#$ -V -cwd
#$ -l h_rt=6:00:00
#$ -l h_vmem=1G

module add idl
idl
```

This will run the application:

- from your current directory with the currently loaded module environment
- with 6 hours of run-time
- requesting 1GByte of memory

If this is saved as a text file with the name: `idl_script.sh` it can then be submitted with:

```bash
qsub idl_script.sh
```

## Running IDL as an interactive job on the compute nodes

IDL can also be launched as an interactive job on a compute node through `qrsh`:

```bash
export LM_LICENSE_FILE=port@machine:$LM_LICENSE_FILE
module add idl
qrsh -cwd -V -l h_rt=6:00:00,h_vmem=1G -pty y $IDL_HOME/idl/bin/idl
```

This will request 1 CPU for 6 hours, with 1G of RAM.

```{note}
If the resources are not available at the point the scheduler tries to allocate them, then the request will fail.
You may find you have to submit the request a few times until it is successful.
```

You can read more about interactive sessions on HPC in the [Usage section](../../usage/interactive).
