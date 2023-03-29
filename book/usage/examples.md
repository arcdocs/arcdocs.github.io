# Job Examples
Included here are a series of template job submissions, that may prove useful
as a starting point for your own submission scripts.

## Serial
A fairly minimal example to run a serial code, using a default allocation of
1Gbyte of RAM, running for up to an hour, executing a binary `example.bin` in
the current directory, and importing the environment from the submitting shell.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
./example.bin
```

## Serial, but needs more memory
As above, but asking for additional memory, so 4.8Gbytes of RAM, which is the
amount that balances with available cores on machines on ARC4.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l h_vmem=4.8G
./example.bin
```

## Serial, but needs lots more memory
If we find ourselves needing lots of memory per core (say above 10G) you may be
better off targeting the large memory nodes.  Here we're asking for 200G, so we
have to use the large memory nodes, as the normal nodes only have 192G
available on ARC4.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l node_type=40core-768G
#$ -l h_vmem=200G
./example.bin
```

## Threaded
Here we're asking for eight cores.  Where we want to use the number of cores
we've been allocated, we can use `$NSLOTS`, which ensures we don't accidentally
use a different figure in two places in the job submission file.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -pe smp 8
./example.bin -t $NSLOTS
```

## Threaded, but gets upset by OpenMP hints
The clues given by the scheduler to help with OpenMP codes can confuse some
codes, which are technically OpenMP aware, but are being used in ways that
don't sit well with the hints.  This removes the hints, allowing the Linux
kernel to assign free cores as it sees fit.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -pe smp 8
unset GOMP_CPU_AFFINITY KMP_AFFINITY
./example.bin -t $NSLOTS
```

## Threaded, using a whole node
Sometimes you may just want a whole node.  Run this way, you get all the cores,
all the memory, all the local disk.  If code needs to be told how many threads
to use, it can be passed `$NSLOTS`.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=1
./example.bin -t $NSLOTS
```

## MPI, small, single node
If you're wanting to run a small MPI job on a single node, you can run it as an smp job.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -pe smp 8
mpirun example.bin
```

## MPI, small, run anywhere
If you're wanting to run an MPI job, and you're not sensitive to having all the
processes on a single machine, you can ask for them to be spread anywhere
across nodes.  There's no guarantee what the scattering is, so you may have 8
cores on one node, spread across eight nodes, or somewhere in between.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -pe ib 8
mpirun example.bin
```

## MPI, using a whole node
Like with the threaded example, we can assign a whole node.  `mpirun` itself
doesn't need to be told how many cores to run on, as it detects that
automatically.  This delivers much more consistent compute performance than
that previous two options, since you're the only job running on the nodes
you're using.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=1
mpirun example.bin
```

## MPI, using more than one node
Running on more than one node is identical to running on a single node.  For
more advanced examples, including mixed OpenMP/MPI codes, see the [Advanced
examples](advanced).
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=3
mpirun example.bin
```

## Using a GPU
Using a GPU uses simplified syntax, and like asking for a whole node, you don't
need to ask for RAM/CPU/disk to go with the GPU.  Our page on [General Purpose
GPU](gpgpu) provides more details.

```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l coproc_v100=1
./example.bin
```
