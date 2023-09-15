# Troubleshooting jobs on HPC

Sometimes things go wrong when we use HPC. This is a fact of life. This can be for many reasons, sometimes it can be HPC related, sometimes it might be to do more specifically with the code you're running.

```{note}
Whilst the Research Computing team provide support for the HPC we can't troubleshoot specific problems you might have with individual languages or scientific software packages. In those cases we'll advise you to speak to your supervisor or contact the original developers for support.
```

This page will aim to cover some of the most common problems people encounter when using the HPC and provide you with the tools you'll need to fix things or in some cases work out what's going wrong.

## Failures submitting your job

When you submit a job to the scheduler it performs a number of quick checks to ensure it knows what you're requesting. If you've provided any incorrect parameters you will recieve an error after using the `qsub` command.

If this happens check the following in your submission script:

- Did you request an acceptable amount of time with `#$ -l h_rt=hh:mm:ss`? (e.g. less than 48 hours)
- Did you request an acceptable amount of memory for a given node? (e.g. on ARC4 192GB or less)
- Did you ensure there were no spaces between a scheduler parameter and value?
- Do you have permission to access the resource you're requesting? (e.g. private nodes)

The `qsub` command also includes an option that allows you to verify whether your job script is acceptable to the scheduler. You can use this to check your job will submit as follows:

```bash
$ qsub -w v my_job.sh
verification: found suitable queue(s)
```

This output tells us our job script is acceptable to the scheduler and should enter the queue.

## Failures during the job run

Jobs can fail during the job run for a wide variety of reasons such as:

- insufficient resources, if your job tries to use more memory or run for more time than requested the job is automatically killed by the scheduler
- lack of space in your [home directory](storage:home-directory)
- bad line ending characters in your job submission script
- failure to checkout software licenses

Your first step to try and identify why a job has failed is to check the [job output and error files](batchjob:job-output) for any of the following:

- code failures and exit codes
- code failures because file or directory do not exist
- syntax errors in your submission script
- permission errors prevent file read or write

## Job output and error files

Whenever a job runs on HPC a number of output files are created by default by the scheduler. These are separate to any output files you've programmed to be produced and should be inspected closely if your job is failing.

Typically, we should expect a job to produce a output file and an error file following the naming pattern `submission_script.sh.oJOBID` and `submission_script.sh.eJOBID` respectively. Where `submission_script.sh` is the name of your job script and `JOBID` is the unique numeric ID of the job when it was submitted.

If a job fails one of the first places to check for more information are these output and error files.

## Queue accounting data

Another useful tool for troubleshooting problems with jobs is the accounting data captured by the scheduler during the course of a job run. You retrieve this data by using the command `qacct -j JOBID` (where `JOBID` is the unique numeric ID of your job). This can take some time to return (especially on ARC3) but will eventually return a large data table that looks as follows:

```bash
qacct -j 42
==============================================================
qname        40core-192G.q
hostname     d10s3b4.arc4.leeds.ac.uk
group        iss
owner        issev001
project      EG
department   defaultdepartment
jobname      test_sub.sh
jobnumber    42
taskid       undefined
account      sge
priority     0
qsub_time    Fri Aug 21 14:09:08 2020
start_time   Fri Aug 21 14:09:30 2020
end_time     Fri Aug 21 14:09:31 2020
granted_pe   NONE
slots        1
failed       0
exit_status  0
ru_wallclock 1s
ru_utime     0.032s
ru_stime     0.046s
ru_maxrss    4.832KB
ru_ixrss     0.000B
ru_ismrss    0.000B
ru_idrss     0.000B
ru_isrss     0.000B
ru_minflt    13994
ru_majflt    0
ru_nswap     0
ru_inblock   0
ru_oublock   32
ru_msgsnd    0
ru_msgrcv    0
ru_nsignals  0
ru_nvcsw     223
ru_nivcsw    43
cpu          0.078s
mem          0.000Bs
io           0.000B
iow          0.000s
maxvmem      0.000B
arid         undefined
ar_sub_time  undefined
category     -l env=centos7,h_rt=900,h_vmem=1G,node_type=40core-192G,project=arc
```

This contains alot of informations but often the most useful rows to check are the lines `maxvmem` and `ru_wallclock`. These contain values that correspond to the amount of memory and time used by the job which can be useful for [troubleshooting aborted jobs](#troubleshooting-job-aborted-errors).

## Windows newline character errors

Job scripts written on Windows computers contain different invisible line ending characters to those used on Unix systems. This can lead to job submission failures that leave the following message in your job error files:

```bash
/bin/bash^M: bad interpreter: No such file or directory
```

This can easily be resolved using the command line tool `dos2unix` which is pre-installed on all HPC systems. To convert a job submission script that was written on a Windows system to run on the HPC just run the command `dos2unix job_script.sh` to correct the line endings characters.

## Job exit status

All jobs return an exit status at the end of the job. An exit status of 0 corresponds to a successful completion of the script that was run. A non-zero exit status suggests an error occured during the running of a job and so the job was not able to complete.

It's important to note that an exit status of 0 does not mean your code ran properly or that your results are correct. It simply means the code ran without an errors.

You can find the exit status of your job as a value in the output of the queue accounting command [`qacct`](#queue-accounting-data).

## Troubleshooting Job Aborted errors

The most common reason a job is aborted is because the job tried to use more resources (memory or time) than was initial specified in the job submission script. If this happens you will find the following line in the job email or in the `qacct -j JOBID` output:

```bash
failed qmaster enforced h_rt, h_cpu, or h_vmem limit
```

This tells us that the scheduler killed the job because it enforced a limit on either time, CPU or memory. To probe this further you should use the queue accounting command [`qacct`](#queue-accounting-data) to retrieve the accounting information for the job in question and check the values for `maxvmem` and `ru_wallclock` and whether those values are equal to or greater than the amount of memory or time requested. You can then update your resource request lines in your job submission script to prevent the job being aborted in the future.
