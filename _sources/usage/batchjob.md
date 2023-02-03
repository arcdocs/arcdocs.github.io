# Batch jobs

The computational power of the HPC facilities at Leeds is organised through a batch job scheduling system. This involves users submitting a script that outlines the resources required, and the program to be run, to the scheduler which allocates that job a position in the queue of jobs. The scheduler software that runs on both ARC3 and ARC4 is [Son of Grid Engine](https://arc.liv.ac.uk/trac/SGE), plus locally developed and implemented patches.

## Job scripts

The scripts submitted are referred to as **job scripts** or **job submission scripts**. These are shell scripts (files ending `.sh`) and at a bare minimum specify:

- how long the job needs to run for
- on how many processors to run (assumed 1 unless otherwise specified)

With this information, the scheduler is able to run jobs at some point in the future when the resources become available. Crucially, the queue is **not** first-come-first-serve and implements a [fair-share policy](#fair-share-policy) to guide the scheduler towards allocating resources fairly between different faculties and users.

The common commands used on HPC to interact with batch jobs are:

- [`qsub`](#the-hello-world-job-script) - submits a job script to the scheduler
- [`qstat`](#monitoring-jobs) - checks the status of submitted jobs
- [`qdel`](#deleting-jobs) - deletes a specified job from the queue

### Writing jobs scripts on HPC

We encourage users to write their job submission scripts using text editor tools available on ARC3 and ARC4 such as:

- `nano` (recommended for beginners)
- `gedit`
- `vim`
- `emacs`

The basic approach to create a new job submission file on HPC would be `nano job_submit.sh` or `vim job_submit.sh`. This opens the new empty file in the text editor ready for you to write its contents.

``` {warning}
Job scripts written on Windows computers contain different invisible line ending characters that lead to job submission failures such as
`/bin/bash^M: bad interpreter: No such file or directory` <br>
You can use the command `dos2unix job_script.sh` on HPC to convert your script to the correct line endings.
```

### The Hello world job script

In this basic hello world job script example we've got a job script called `job_script1.sh` that requests a single core, 1GB of RAM, and 15 minutes of run time in order to run some R code.

```shell
#R single core submission script

#Run with current environment (-V) and in the current directory (-cwd)
#$ -V -cwd

#Request some time- min 15 mins - max 48 hours
#$ -l h_rt=00:15:00

#Request some memory per core
#$ -l h_vmem=1G

#Get email at start and end of the job
#$ -m be

#Now run the job
module load R
R CMD BATCH R.in R.out
```

We can submit this script to the scheduler by using `qsub`:

```bash
$ qsub job_script1.sh
Your job 42 ("job_script1.sh") has been submitted
```

This returns some text to confirm our job has been submitted and provides us with the jobs unique ID number (in this case 42).

``` {note} **Array jobs** <br>
If you intend to runs multiple similar jobs with the same resource specification, we recommend using the [task array system](./taskarrays).
```

### Resource specification

The job script specified above includes a number of lines that request some amount of compute resource for our job. This is defined by the syntax `#$ <option>`. These lines are commented out of the shell script but are read by the scheduler to determine how much compute resource is required and thus how to fit the job into the queue.

The first things we specify in the example script above were:

```bash
#$ -V -cwd
```

`-V` tells the scheduler to use the current environment (including environment variables and loaded modules) and `-cwd` tells the scheduler to run the job within the current directory (helping ensure any paths specified are correct). These are commonly included in all job scripts.

Next we have the lines requesting a time allocation and the amount of memory required per core:

```bash
#$ -l h_rt=00:15:00

#$ -l h_vmem=1G
```

Here `-l h_rt=hh:mm:ss` is a request for a specific amount of runtime, with a maximum limit of 48h. The line `-l h_vmem=` requests a specific amount of memory per core, in the example we request 1 GB to run on 1 core.

To use multiple cores within a node using the OpenMP protocol you include the following option:

```bash
#$ -pe smp np
```

Where `np` is the number of cores you wish to request. The maximum number of cores you can request using `smp` is the total number of cores available on a node (ARC4 - 40, ARC3 - 24).

```{warning}
If your job attempts to run for longer than the amount of time or use more memory per core than requested this will cause the scheduler to kill your job. This is one of the most common problems people encounter, read more on the [troubleshooting page](./troubleshooting).
```

Next we have options to request notifications about the job:

```bash
#$ -m be
```

The option `-m` will specify that we wish to receive an email about the job, in this case `be` at the start and the end of the job. This will automatically be sent to your University of Leeds email address.

#### List of SGE options

```{list-table}
:header-rows: 1
:widths: 10 30 10

* - Option
  - Description
  - Default
* - `-l h_rt=hh:mm:ss`
  - The wall clock time (amount of real time needed by the job). This parameter must be specified, failure to include this parameter will result in an error message.
  - Required
* - `-l h_vmem=memory`
  - Sets the limit of virtual memory required per core. If you require more memory than 1GB/process you must specify this flag. e.g. `-l h_vmem=12G` will request 12GB memory. The maximum memory that can be requested for a shared memory job is the total of the processes requested multiplied by the virtual memory requested per core, and this must be equal to or less than the amount available in a single node.
  - 1G
* - `-pe smp np`
  - Specifies the shared memory parallel environment for parallel programs using OpenMP/threads. `np` is the number of cores to be used by the parallel job. The maximum number of cores that can be requested for shared memory jobs is limited by the number of cores available in a single node.
  - 1
* - `-pe ib np`
  - Specifies the parallel environment for parallel programs using MPI, `np` is the number of cores to be used by the parallel job.
  -
* - `-l nodes=x[,ppn=y][,tpp=z]`
  - Specifies a job for parallel programs using MPI. Assigns whole compute nodes. `x` is the number of nodes, `y` is the number of processes per node, `z` is the number of threads per process.
  -
* - `-l np=x[,ppn=y][,tpp=z]`
  -  Specifies a job for parallel programs using MPI. Assigns whole compute nodes. `x` is the number of processes, `y` is the number of processes per node, `z` is the number of threads per process.
  -
* - `-l node_type=type`
  - Specifies the type of node to be used. Where `type` can be: a standard node with the flag `40core-192G` or the high memory node with the flag `40core-768G`.
  - 40core-192G (ARC4) 24core-128G (ARC3)
* - `-l coproc=`
  - A wrapper line for requesting resources on GPGPU nodes, see [GPGPU page](./gpgpu) for more details. Passing a number between 1 and 4 requests a proportion of the resources on GPGPU nodes.
  -
* - `-l disk=<bytes>`<br/>`-l disk_type=*|ssd|hdd`<br/>`-l disk_out=<directory>`<br/>`-l disk_usejobname`
  - These parameters control local disk usage.  Please refer to [Temporary/Scratch Storage on Compute nodes](./scratch) for more details.
  -
* - `-hold_jid prev_job_id`
  - Hold the job until the previous job (`prev_job_id`) has completed – useful for chaining runs together.
  -
* - `-l placement=type`
  - Choose optimal for launching a process topology which minimises the number of infiniband switch hops used in the calculation, minimising latency. Choose `scatter` for running processes anywhere on the system without topology considerations.
  -
* - `-t start-stop`
  - Produce an array of sub-tasks (loop) from `start` to `stop`, giving `$SGE_TASK_ID` variable to identify the individual sub-tasks. See [task array page](./taskarrays) for more details.
  -
* - `-P project_name`
  - Submit the job to a specific private node queue. Where `project_name` is the name of a private queue you have permission to submit to.
  -
* - `-help`
  - Prints a list of options.
  -
* - `-cwd`
  - Execute the job from the current working directory; output files are sent to the directory form which the job was submitted, not to the user’s home directory.
  -
* - `-V`
  -  Export all current environment variables to all spawned processes. Necessary for current module environment to be transferred to SGE shell.
  -
* - `-m be`
  - Send mail at the beginning (`b`) and at the end (`e`) of the job to the owner.
  -
* - `-M email@leeds.ac.uk`
  - Specify mail address for `-m` option.
  - Your user email address
* - `-j y`
  - Combine the standard error and standard output into one file.
  -
* - `-N name`
  - Give the job a specific name. Where `name` is the desired job name.
  - Name of submission script
```

### Monitoring jobs

Once you've submitted a job you can monitor its progress in the queue using the command `qstat JOBID` where `JOBID` is the unique numeric ID of your submitted job.

In the example below we've just submitted a job and want to check its status in the queue.

```bash
$ qstat 54
job-ID  prior   name       user         state submit/start at     queue                          slots ja-task-ID
-----------------------------------------------------------------------------------------------------------------
 54 0.00000 test_sub.s exuser     qw    08/21/2019 14:09:08                                    1

```

Using `qstat` returns a table with the following columns:

- the job ID
- the job priority determined by the scheduler [fair share policy](#fair-share-policy)
- the name of the submission script
- the user who submitted the job
- the jobs state in the queue
    (`qw` for waiting; `r` for running; `hqw` for hold waiting, `Eqw` for errored whilst queueing, `t` for transferring state)
- the submission time, or if the job is running the start time
- the number of slots (cores) requested
- the task ID number if the job is a [task array](./taskarrays)

```{note}
If you run `qstat` expecting an output and nothing happens and your prompt is returned it means you have no jobs currently in the queue. This suggests your job has completed.
```

You can also pass the `qstat` command a number of additional arguments to view the queue or other users queues.

```bash
$ qstat -u 'username'
# where username is your own or another username

$ qstat -u '*'
# will return the entire queue
```

#### Deleting jobs

Sometimes a situation might arise where you need to delete one of your submitted jobs from the queue. You can do this with the straightforward command `qdel JOBID` where `JOBID` is the unique numeric ID of the job we wish to delete.

When the job is successfully deleted we get the following output:

```bash
$ qdel 42
exuser has deleted job 42
```

```{note}
You can only use `qdel` to delete your own submitted jobs from the queue, so don't try and be smart and clear the queue just for your jobs as it won't work.
```

### Job output

When a job runs it produces two output files by default even if you haven't specified your code to write a results file. These contain information from the standard output and standard error produced by your job and are are named following the pattern `submission_script.sh.oJOBID` and `submission_script.sh.eJOBID`. Where `submission_script.sh` is the name of your job script and `JOBID` is the unique numeric ID of the job when it was submitted.

For example, if we submitted a job called `test_run.sh` and it was given the job ID `4689` we'd expect the following files produced alongside any results files:

```bash
test_run.sh.o4689
test_run.sh.e4689
```

Both these files contain useful information about how the job progressed and are especially useful if your job encountered an error. You can read more about using these files to help troubleshoot problems in the [troubleshooting section](./troubleshooting).

### Job holding

Often a workflow can involve a number of steps in a process, where each steps requires the outputs of the previous and should only start when the previous step completes. The scheduler has a system of job dependencies built into it that allows you to submit a series of jobs and specify that jobs should be on hold until another job has completed.

For instance you could do this with two submission scripts `job1.sh` and `job2.sh`, where `job2.sh` should only begin once `job1.sh` has finished. You can specify this when submitting jobs as follows:

```bash
$ qsub job1.sh
Your job 626 ("job1.sh") has been submitted

$ qsub -hold_jid 626 job2.sh
Your job 627 ("job2.sh") has been submitted
```

`job2.sh` will then be held in the queue until `job1.sh` is completed.

This allows for developing a workflow of jobs that run one after another to complete long stepwise tasks.

### Fair-share policy

The fair-share policy is two-tiered policy that takes into account the usage of a faculty as a whole and the past usage of the user. In the first tier of the policy faculties are allocated a share of the queue space on the basis of funding, meaning that faculties do not have equal shares of system capacity. The fair-share policy then determines an initial faculty level priority based on the faculties share and the total usage by all faculty member users.

```{note}
The fair-share policy and levels are set by the ARC management group and cannot be altered by the system’s support team.
```

Next the fair-share policy determines an individual user's job priority. Initially, all users from a faculty have the same initial priority which then decreases based on the users usage of the HPC. Essentially, this means that a user with recent (the last 7 days) heavy usage will have their jobs reduced in priority to allow other user’s jobs to run.

The fair-share policy has the following consequences:

- The more usage by members of your faculty, the more jobs submitted by users in the faculty, the longer you have to wait in the queue
- If you submit lots of jobs your subsequent jobs will have a lower priority and you will have to wait longer in the queue and so will jobs submit by other users from your faculty for the next 1 or 2 weeks
- Jobs submitted by people from another faculty may start before yours
- Jobs submitted after your job may start before yours

```{note}
There is no test queue on the ARC service. To help determine your most efficient usage we recommend submit small test jobs.
The smaller the jobs the less time it will wait in the queue and the less impact it will have on your priority.
```
