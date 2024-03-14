# Storage on HPC

(storage:home-directory)=
## HOME directory

When you log into the either ARC3 or ARC4 you automatically start in your user area or HOME directory. This offers a dedicated, weekly backed up space for file storage that is shared across both HPC systems. Your HOME directory is limited to 10GB per user so its important to avoid using this space as a destination for data generated by cluster jobs, as home directories fill up quickly and exceeding your quota will cause your jobs to fail.

You can always check how much of your quota you're using with the `quota` command:

```bash
$ quota -s
Disk quotas for user medacola:
     Filesystem   space   quota   limit   grace   files   quota   limit   grace
nas-ufaservn1:/export/home/home01
                  7897M  10240M  11264M           25194       0       0

```

In the above case I've used the `quota -s` command to get a human readable output. It shows I've used 7897MB (7.9GB) in the space column, with a quota of 10240MB (10GB) and a hard limit of 11264MB (11GB). This allows me to determine if i'm close to my quota and whether I need to remove some files.

(storage:nobackup)=
## /nobackup

Each HPC system has a large disk mounted on /nobackup for temporary storage of input/output files for jobs. /nobackup is constructed using the [Lustre parallel filesystem](http://www.lustre.org/). ARC3 has ~836TB at 4GB/s and ARC4 has ~1.2PB at 11GB/s.

```{warning} <br>
Users should not rely upon the /nobackup disk for their long-term data storage needs. /nobackup is **not** backed up and files are removed if not accessed after 90 days.
```

Although highly resilient internally, users should not rely upon this resilience for data protection and important data should be moved off this filesystem, to a different location, once compute jobs/IO is complete.

To ensure sufficient space and bandwidth is available to the system’s workload, the /nobackup disk will be purged periodically.

### Accessing /nobackup

To access the /nobackup filesystem from the command prompt:

```bash
$ cd /nobackup
```

When using for the first time, you are encouraged to make a directory under /nobackup to store your data (where USERNAME is your university username) e.g.:

```bash
$ mkdir /nobackup/USERNAME
$ cd /nobackup/USERNAME
```

Data can then be copied into that area using `cp` (or `scp` from remote):

```bash
$ cp -r ${HOME}/data /nobackup/USERNAME/
```

```{warning} **Note about small file sizes** <br>
/nobackup is optimised for large files (where large is >1Mb). File access to lots of small files will not obtain the best out of the filesystem and will slow down your applications.
```