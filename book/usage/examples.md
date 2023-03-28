# Job Examples

## Serial

A fairly minimal example to run a serial code, using a default allocation of
1Gbyte of RAM, running for up to an hour, executing a binary `example.bin` in
the current directory.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
./example.bin
```

## Serial, but needs more memory

As above, but asking for additiona memory, so 4.8Gbytes of RAM, which is the
amount that lines up with available cores on the machine on ARC4.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l h_vmem=4.8G
./example.bin
```

If we find ourselves needing lots of memory per core (say above 10G) you may be
better off targeting the large memory nodes.  Here we're asking for 200G, so we
have to use the large memory nodes, as the normal nodes only have 192G
available on ARC4.
## Serial, but needs lots more memory
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

## MPI, using a whole node
Like with the threaded example, we assign a whole node.  `mpirun` itself
doesn't need to be told how many cores to run on, as it detects that
automatically.
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=1
mpirun example.bin
```

## MPI, using more than one node
Running on more than one node is identical to running on a single node.  For
more advanced examples, including mixed OpenMP/MPI codes, see the [Advanced
examples](advanced.md).
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=3
mpirun example.bin
```
