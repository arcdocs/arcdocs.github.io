# Stata

## Access to Stata

### ARC 4

A number of different versions of Stata are currently available on ARC4 for all
users via our site wide license that supports jobs running on up to 2 cores.

Stata should be primarily run through batch queuing system, however short
interactive runs can done on the login nodes. You can run Stata interactively
though the batch queue system.

## Setting the module environment

Before you can run the software you will need to load the Stata module.  To
load the latest version of the module from the command line, do:

    module add stata

To check that module is loaded you can use:

    module list

## Interactive Stata sessions

It is anticipated that the main benefit of running Stata on the facility will
be from running non-interactive/unattended batch sessions. However, it is also
possible to run interactively for short tests or for visualisation of data for
instance.

### Interactive sessions on the login nodes

Stata can be launched on the login nodes for short tests, by using the
appropriate executable name at the command prompt. For the Stata command line
interface use:

    stata-mp

and for the full graphical interface (providing you have connected using `ssh
-Y` ) using:

    xstata-mp

### Interactive sessions through interactive shells

For longer interactive sessions, it will be necessary to launch Stata through
batch queues, using the command `qrsh` . The length of time required is
specified as an option to the queueing system and specified in the format
`<hh:mm:ss>` . For instance to request an interactive session for two hours,
the full command takes the form:

    qrsh -cwd -V -pe smp 2 -l h_rt=02:00:00,h_vmem=4.8G xstata-mp

where:

-   `-cwd -V` : run from
    current directory and with current environment, i.e. loaded module.
-   `-pe smp 2` : request 2 cores in shared memory environment. This requests
    an appropriate number of computational cores to take advantage of the
    2-core site license for Stata.
-   `02:00:00` : is the
    length of time needed for the job, 2 hours in this case. Job will be
    killed when this time has elapsed.
-   `h_vmem=4.8G` : Amount of memory requested per core. The value given here
    is a sensible default, but you can use more or less as necessary.

For more details about these and other available options please look at the
page on [Interactive jobs](../../usage/interactive).

## Batch execution

In oder to submit a batch job to the cluster it is necessary to use a
submission script. An example submission script for ARC4,
`stata_sub_example.sh`, takes the form:

    #!/bin/bash
    # Batch script to run a Stata/MP job

    # Run from current directory and environment.
    #$ -cwd -V
    # Request wallclock time. Format hh:mm:ss, for e.g 6 hours
    # maximum allowed is 48 hours.
    #$ -l h_rt=06:00:00

    # To get an email when the job begins and ends- fill in your
    #$ -m be

    # Request 2 cores from the machine.
    #Current version of Stata can run on a maximum of 8 Cores
    #$ -pe smp 2

    # Request 4.8Gbytes per core
    #$ -l h_vmem=4.8G

    # Load the Stata module
    module add stata

    # Start the Stata job, with your program in
    # a file your_do_file.do
    stata-mp -b do your_do_script.do

The job can then be submitted to the queuing system using the command:

    qsub stata_sub_example.sh

For more details on options used above and some of the other options available
please look at the page on [Batch jobs](../../usage/batchjob).

## Using Stata Python integration

Stata allows for integration of Python within a Stata session.  From Stata 16
onwards it is possible to use Python from within Stata allowing you to embed
and execute Python code directly.

For this to work Stata needs to be able to find an installation of Python on
your system.  On ARC4, Stata defaults to using the system Python 2.7
installation, which is not recommended.

We recommend taking the following steps to allow Stata to use the [Anaconda
Python 3 distribution](../compilers/anaconda) that is installed on ARC4.

First, create a new Conda environment using the Conda package manager tool,
within which you can install your preferred Python version.  Creating a [new
Conda environment](../compilers/anaconda.html#creating-custom-environments)
allows you to separate the dependencies required for your Stata Python
integration from any other Python dependencies you may have.

```bash
$ module add test anaconda stata/17

$ conda create -yn statapy python=3.10

$ source activate statapy
```

Having activate our `statapy` environment we can now install any Python
packages we require using `pip` or `conda`.

Next, we need to configure our Stata session to use the Conda-installed version
of Python.  To do this we need to set two settings in Stata `python_exec` and
`python_userpath`, you can view these settings directly within Stata by running
`python query`.

```stata
. python query
-------------------------------------------------------------------------------
    Python Settings
      set python_exec      /usr/bin/python
      set python_userpath

    Python system information
      initialized          no
      version              2.7.5
      architecture         64-bit
      library path         /usr/lib64/python2.7/config/libpython2.7.so
```

Here you can see the default setting uses the system installation of Python 2.7.
We can change this with the following steps:

1. Find out the absolute path to your Conda-installed `python` executable.  The
   simplest way to do this is to activate your Conda environment and run `which
   python` in the shell.  This should return a path location to your
   Conda-installed Python.
   To find the correct path for `python_userpath` you will need to identify
   the location of `site-packages` in your Conda environment.  You can find
   this out by running:
   ```bash
   python -c 'import sys; print(sys.path);'`
   ```
   in the shell.
   This will return for you a list of entries one of which will have a format
   of `/home/home01/arcuser/.conda/envs/ENV_NAME/lib/PY_VERSION/site-packages`
   where `ENV_NAME` is the name of your Conda environment and `PY_VERSION` is
   the version of Python you installed.

2. Use the path from step 1. to set the `python_exec` and `python_userpath`
   settings in Stata.

   In the example below the paths are specified for the `arcuser`, you will
   need to use the path provided by `which python` which will include the path
   to your /home directory.

   When setting `python_userpath` you should use the `site-package` path you
   identified in step 1.

   You can set these settings with the following commands within Stata, using
   example paths below:

   ```stata
   . set python_exec ~/.conda/envs/statapy/bin/python, permanently
   (python_exec preference recorded)

   . set python_userpath /home/home01/arcuser/.conda/envs/statapy/lib/python3.10/site-packages, permanently
   (python_userpath preference recorded)
   ```

This will set these changes to the Python settings permanently for your user on
ARC4, so that you do not have to change these settings in the future.

You can confirm these changes are in place by running `python query` in the
Stata console again.

```stata
. python query
-------------------------------------------------------------------------------
    Python Settings
      set python_exec      /home/home01/arcuser/.conda/envs/statapy/bin/python
      set python_userpath  /home/home01/arcuser/.conda/envs/statapy/lib/python3.10/site-packages

    Python system information
      initialized          no
      version              3.10.4
      architecture         64-bit
      library path         /home/home01/arcuser/.conda/envs/statapy/lib/libpython.3.10m.so
```

Once these settings are configured you will be able to use Python from within
Stata on ARC4.
