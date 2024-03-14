# Conda within a container

This is a set of instructions for creating and using a conda environment within
a container.  This can be used on the HPC or elsewhere.  We recommend
[Apptainer](../software/infrastructure/apptainer).  This is tested as working
on ARC4 only, although containers built this way on ARC4 should also work on
ARC3.

## Why you want to use containers for Conda environments

Conda environments create thousands of small files, that needs to be written
when you create it, and many are read everytime you run any software within
your environment.  This is not playing into the strengths of the Lustre
filesystem that underpins /nobackup.

By making a container, you end up with something that's faster, easier to
transfer onto other systems, share with others, and backup into your OneDrive.
Pretty much better in everyway.

## Creating the container

### Create a YAML file for the environment

Conda allows you to build containers from a YAML file, which describes the
content.  We're going to use this example, and write it to a file called
`environment.yml`:

```yaml
channels:
  - defaults
  - conda-forge
dependencies:
  - matplotlib
  - python=3.9
  - pip
  - pip:
    - vivarium
```

### Write a recipe file

A single recipe should work for most situations here.  The content of
`mamba-example.def` is provided below:

```
Bootstrap: docker
From: mambaorg/micromamba

%files
   environment.yml

%post
    micromamba create -q -y -f environment.yml -p /opt/conda-env
    micromamba clean -aqy
    micromamba config set --system use_lockfiles false

%runscript
    micromamba run -p /opt/conda-env "$@"
```

This recipe starts with a minimal micromamba Docker container, which is a fast,
self-contained binary that's an alternative to Conda.

In the `%post` section, you can see it creates a conda environment using the
provided YAML file, and tries to clean up after itself, to keep the size of the
container as small as possible.

In the `%runscript` section, we have a line that runs any command provided to
the container within the created Conda environment.

### Build the container

This is a single command, to take the recipe and YAML file and create a SIF
image, that we can use later:

```bash
$ module add apptainer
$ apptainer build mamba-example.sif mamba-example.def
```

With a small example, this will take a minute or so, but will take longer with
more complex environments.  Once complete, you should see you now have a
`mamba-example.sif` file.

SIF files are great, in that they're a single file that encapsulates everything
you need for a container, unlike formats used by systems like Docker, which use
more complex layered arrangements.

## Using the container

Let's just prove that it has indeed installed the vivarium library we asked
for, and run a python command within the container:

```bash
$ ./mamba-example.sif python -c "import vivarium;print(vivarium.__version__)"
1.2.7
```

You're also free to use the apptainer command.  The equivalent would be:

```bash
$ apptainer run mamba-example.sif python -c "import vivarium;print(vivarium.__version__)"
1.2.7
```

Using the apptainer command directly allows you alter bind mounts, configure it
to use GPUs, and other more advanced options.

## Note on using conda packages that depends on cuda

There's a virtual package called "cuda" that is autodiscovered from the running
system, to allow Conda to match installed packages to the current system.  When
you're building a container, you will often be doing this on a machine without
the GPU you're planning on using at runtime.  This can be overridden in the
recipe:

```
CONDA_OVERRIDE_CUDA=12.0 micromamba create -q -y -f environment.yml -p /opt/conda-env
```

The version here should match the version you're trying to build for.  At the
time of writing, 12.0 is currently supported on the P100 cards on ARC3, and the
V100 cards on ARC4.
