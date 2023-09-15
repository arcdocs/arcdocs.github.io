# Interactive jobs

It is also possible to runs jobs in interactive mode on both ARC3 and ARC4. This means rather than queueing for your job to run on the batch system you request resource for an interactive sessions via the shell. When the resource becomes available an interactive shell session is created in which you can run code directly on compute resource.

This process still involves requesting resource and queueing for that resource under the [fair-share policy](batchjob:fair-share-policy) so be prepared to wait if you request a significant amount of resource.

```{warning}
We strongly discourage users from using interactive sessions for interactive code development using platforms like jupyter, spyder or Rstudio. Code development should be done before deploying code on the HPC.
```

## Interactive jobs on compute nodes

You can request an interactive session on a standard compute node by using the command `qrsh`. As with submitting a batch job you will also need to pass it options to specify how much resource you wish to request.

For instance to request an interactive session for 15 minutes with access to 2 cores each with 4 GB of memory:

```bash
$ qrsh -l h_rt=00:15:00,h_vmem=4G -pe smp 2 -pty y bash
```

This sends the request to the queue and the prompt will wait until the session can be started. When it starts the prompt will return but appear changed from our initial prompt.

```bash
[exuser@login2.arc4 ~]$ qrsh -l h_rt=00:15:00,h_vmem=4G -pe smp 2 -pty y bash

[exuser@d10s2b4.arc4 ~]$
```

The prompt changes to show that the interactive session is now running on a specific compute node on ARC4. From here you can now run code or an applications directly on the compute node.

```{note}
If you have made changed to your environment on the login nodes these will **not** be preserved when connecting to an interactive session and you will be required to rerun `module load` commands. Connecting to an interactive session does create a new login shell which means any commands in your `.bashrc` are executed when you connect.
```

## Interactive MPI jobs

For development and testing purposes, it might be convenient to run MPI jobs in interactive mode and have them launch fairly quickly. In this case it would be advisable to use the `-l placement=scatter` option.

This will likely get the job to launch fairly quickly at the expense of performance. For instance to run `mympiprogram` for 30 minutes on 4 cores with 1GB memory each from the currrent directory and using the current environment, use:

```bash
$ qrsh -l h_rt=0:30:0,h_vmem=1G,placement=scatter -pe ib 4 mpirun ./mympiprogram
```

## Interactive jobs on GPU nodes

If you want to use a GPU interactively instead of submitting a job to the GPU nodes you need to request a coprocessor and specify your shell as part of your `qrsh`, ie:

```bash
$ qrsh -l h_rt=2:0:0,coproc_k80=1 -pty y bash
```

This will give you a bash session on a k80 GPU node for two hours, using one half of the resources on that GPU node.
