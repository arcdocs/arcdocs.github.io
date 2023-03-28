# Job Examples

## Serial
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
./example.bin
```

## Serial, but needs more memory
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l h_vmem=4.8G
./example.bin
```

## Serial, but needs lots more memory
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l node_type=40core-768G
#$ -l h_vmem=200G
./example.bin
```

## Threaded
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -pe smp 8
./example.bin -t $NSLOTS
```

## Threaded, but gets upset by OpenMP hints
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -pe smp 8
unset GOMP_CPU_AFFINITY KMP_AFFINITY
./example.bin -t $NSLOTS
```

## Threaded, using a whole node
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=1
./example.bin -t $NSLOTS
```

## MPI, using a whole node
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=1
mpirun example.bin
```

## MPI, using more than one node
```bash
#$ -cwd -V
#$ -l h_rt=01:00:00
#$ -l nodes=3
mpirun example.bin
```
