# Advanced Job Examples

These are provided to give you a starting point, and give you ideas on what can
be done.

## Submitting Mixed Mode Jobs
The ‘mixed mode’ (MPI+OpenMP) programming model typically involves MPI
processes running across nodes and OpenMP threads upon each node with the total
number of processes (MPI*OpenMP) equalling the number of physical processor
cores.

Your code will need to call MPI_Init and make use of OpenMP directives. You
will compile your code using an MPI wrapper and enabling OpenMP support, for
example:

```bash
$ mpif90 -openmp example.f90 -o mixed.exe
```

You will need to determine `ppn`, the number of MPI processes per node, and
`tpp`, the number of OpenMP threads per MPI process.

Additionally, you can either ask for a given number of nodes nodes or for the
total number of MPI processes `np`. Note that `ppn` is related to `np` since
`ppn` = `np`/`nodes`.

Your submission script would then need to contain:

```bash
#$ -V
#$ -l h_rt=01:00:00
#$ -l nodes=<nodes>, ppn=<ppn>, tpp=<tpp>
mpirun ./a.out
```
or

```bash
#$ -V
#$ -l h_rt=01:00:00
#$ -l np=<np>, ppn=<ppn>, tpp=<tpp>
mpirun ./a.out
```
There are 24 cores per node on ARC3, so you would typically ensure `ppn`\*`tpp`=24.
There are 40 cores per node on ARC4, so you would typically ensure `ppn`\*`tpp`=40.

### Example
Using ARC4, To run an MPI+OpenMP executable mixed.exe with 80 MPI processes
each launching 4 OpenMP threads, the following submission script would be
needed:
```bash
#$ -V
#$ -cwd
#$ -l h_rt=01:00:00
#$ -l np=80, ppn=10, tpp=4
mpirun ./mixed.exe
```
This will allocate 8 nodes (=8*40=320 cores).
Each node will have 10 MPI processes, each of which will have 4 OpenMP threads
(so 10\*4=40 processes per node in total, and 8\*140=320 (=80MPI\*4OpenMP)
processes in total.

Alternatively, the same effect can be achieved by:
```bash
#$ -V
#$ -cwd
#$ -l h_rt=01:00:00
#$ -l nodes=8, ppn=10, tpp=4
mpirun ./mixed.exe
```
Note that the `OMP_NUM_THREADS` environment variable is automatically set by
the batch system and so you do not need to set this in your environment.

## Job Dependencies
The SGE scheduler allows you to submit a job but then hold them in the queue
until certain job dependencies are met, ie. it will hold the job until a
previous job (or number of jobs have completed).

To do this, submit the first job as normal:

```bash
$ qsub job1.sh
```

As usual, the scheduler will give you a job ID `<jobid>`.

If you then want to submit another job that is dependent on the first one
completing, use the `-hold_jid` option for qsub:

```bash
$ qsub -hold_jid <jobid> job2.sh
```

Job 2 will remain in the queue until job 1 has completed.

Alternatively, if you have given the job a name (using the `-N` option), then
you can put a hold on subsequent jobs using the name instead:

```bash
$ qsub -hold_jid <jobname> job2.sh
```

If you give several jobs the same name, then the job will be held until all the
named jobs have been completed.
See [Batch jobs](./batchjob.html#list-of-sge-options) for more details on
`hold_jid`.

## Restartable jobs

SGE supports jobs that exit telling the scheduler that they're not finished,
and so should be rescheduled.  This is very useful when you have a long running
job that ultimately will take longer than 48 hours to complete, but you can
easily save the current progress as you go along.  Here is a dummy example to
hopefully give you ideas on how this could be used:

```bash
#!/bin/bash
#$ -l h_rt=0:10:0

# Which subtask we're currently processing.  This script assumes we're only
# completing one subtask per SGE job, but there's no reason you couldn't
# process more.
counter=1

# Read the restartfile, if present, to continue from where we got up to
if [ -f restartfile ];then
  echo loading restart file
  . restartfile
fi

# If we detected we've been restarted, we may need to run differently, so
# here's how you could detect it.
if [[ $RESTARTED == 1 ]];then
  echo Auto-submitted job continuing
fi

# Complete a unit of work
echo Doing work - counter: $counter

# Increment the counter once we've done a unit of work
let counter++

# Write the next task number to the restartfile
echo counter=$counter > restartfile

# If we've not yet completed all our tasks, tell the scheduler that we'll need
# to run again
if [ $counter -le 10 ];then
  exit 99
fi

# We've completed all tasks, so don't restart.
echo Complete!
```

## Non integer task array sequences

This shows how you can run a task array with two sets of parameters where one
of them is non-integer.

```bash
# Run a total of 72 tasks
#$ -t 1-72
# Put the logs into a separate directory
#$ -o logs
#$ -e logs
#$ -cwd -V
#$ -l h_rt=0:10:0

# Define array dimensions, lining up with the 72 tasks we're running
rows=18
columns=4

# Calculate row and column indexes
row_index=$(( ($SGE_TASK_ID - 1) / $columns + 1 ))
col_index=$(( ($SGE_TASK_ID - 1) % $columns + 1 ))

# Map the integer value into the floating point value we actually wanted
calculated_float=$(printf %.4f\\n "$(($col_index))e-4")

# Run the experiment passing those values in
./run_code $calculated_float $row_index
```
