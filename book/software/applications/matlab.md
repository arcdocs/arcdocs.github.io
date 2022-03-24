# MATLAB

Matlab is installed on the HPC clusters and is licensed for academic use only.

## Setting up the environment

All required environment variables can be set by loading the Matlab module, to do this type the command:

```bash
$ module add matlab
```

Matlab is now centrally licenced and managed so there is no need to set a licence server before using it.

## Running on the login nodes

Matlab can be launched by entering the `matlab` command in the terminal. This will start a matlab session either in the terminal or in a new window (if you have connected with [X-forwarding](../../getting_started/logon.html#graphics-forwarding-x11)). Please note that this method should not be used for long computational use.

## Running through the batch scheduler

The batch scheduler allows both interactive and batch jobs to be submitted during which users will have exclusive access to the resources they request.

### Running through an interactive shell

The following will launch Matlab interactively, displaying the full GUI:

```bash
$ qrsh -V -l h_rt=hh:mm:ss matlab -desktop -singleCompThread
```

In the above command `hh:mm:ss` is the length of time the shell will exist for, `-V` exports the the current environment.

The parameter `-singleCompThread` ensures that Matlab will run only on a single thread, since the default multiple threaded behaviour can cause problems.

For example, to request a matlab interactive session for 6 hours:

```bash
$ qrsh -V -l h_rt=6:00:00 matlab -desktop -singleCompThread
```
Alternatively, the following will launch an interactive session in a matlab session that is within the existing terminal:

```bash
$ qrsh -pty y -V -l h_rt=6:00:00 matlab -nodesktop -singleCompThread
```

Where, `hh:mm:ss` is the length of time the interactive session will exist for.

### Batch Execution

To run matlab in batch-mode you must first generate a list of commands for matlab to process in a `.m` file.

```matlab
% MATLAB M-file example to approximate a sawtooth
% with a truncated Fourier expansion.
nterms=5;
fourbypi=4.0/pi;
np=100;
y(1:np)=pi/2.0;
x(1:np)=linspace(-2.0*pi,2*pi,np);
for k=1:nterms
twokm=2*k-1;
y=y-fourbypi*cos(twokm*x)/twokm^2;
end;
plot(x,y);
print -deps matlab_test_plot.ps;
quit;
```

Please note that the last line must be: `quit;`.

A script must then be created that will request resources from the queuing system and launch the matlab executable. Below is an example submission script (`runmatlab.sh`) for this matlab job:

```bash
# Set a 10 min limit
#$ -l h_rt=0:10:00
# Load matlab module
module add user
module add matlab
# run matlab script in the current directory (cosplot.m)
# -nodisplay flag should be given to suppress graphics
matlab -nodisplay -batch cosplot
```

```{note}
To ensure the correct license variables are set we include `module add user` within the job submission script.
```

This can be submitted to the batch scheduler system using:

```bash
$ qsub runmatlab.sh
```

The output file `matlab_test_plot.ps` can be viewed with Ghostscript using the command `gs matlab_test_plot.ps`.

## Parallel Matlab jobs

Recent versions of Matlab support three methods of making use of multiple CPU cores:

1. Multi-threaded support in various Matlab routines and toolboxes
2. Multiple "worker" support (on a single host)
3. Multiple "worker" support (on multiple hosts)

````{admonition} Tip
If you use a mix of threads and workers, you may find performance suffers unless you ignore certain scheduler hints.  Add this line to your job script before running Matlab:
```
unset GOMP_CPU_AFFINITY KMP_AFFINITY
```
````

### Multi-threaded support

This is the simplest method of allowing Matlab to use more than one CPU core. Many functions and toolboxes, for example `fft()` and various linear algebra routines, automatically make use of multiple cores where available.

To do this, we would recommend adding the flag `-l nodes=1,ppn=1` to your qsub command and job scripts. This will ask for an entire compute node. Note that this will **NOT** speed up Matlab while it is not using functions that are able to take advantage of multiple cores.

Please see the Matlab product documentation for details on what functions are multithreaded.

### Multiple "worker" support (on a single host)

Matlab can launch multiple copies of itself, called workers, that are able to communicate and share work between them. This functionality is called the Parallel Toolbox and you may need to adjust code to work properly in this fashion. For example, `for` loops that can be run in parallel may be distributed across all workers by use of the `parfor` Matlab command.

To do this, launch a parallel job, for example by adding the `-pe smp 8` flag to the qrsh or qsub commands from above. This requests 8 cores on a single compute node and stores the number of cores granted in the `NSLOTS` environment variable. Once it has started, execute the Matlab command `parpool('local', 8)` or, more generally, `parpool('local', str2num(getenv('NSLOTS')))`, which in this case would launch 8 workers.

According to Matlab's documentation, there may be a limit on the number of workers that can be requested in this way; however, this has been tested on ARC3 on up to 24 cores.

### Multiple "worker" support (on multiple hosts)

The multiple workers in the Parallel Toolbox can be spread across multiple hosts in order to make use of a greater number of cores and/or memory: Matlab calls this the Distributed Computing Server. Although this is very similar technology, Mathworks license it differently: at the time of writing we can only support a maximum of 32 distributed workers - please get in touch with the reserach computing team via our [contact form](https://it.leeds.ac.uk/it?id=sc_cat_item&sys_id=7587b2530f675f00a82247ece1050eda) if you have any queries about this.

The same code that can make use of the Parallel Toolbox can also make use of Distributed Computing Server; however, there are currently a few setup steps required and the method of launching it is different.

```{note}
These instructions were put together using Matlab 2017b.
```

Setup steps:

1. *Configure Matlab to use an appropriate MPI.* Execute the following commands:
    - `$ mkdir ~/matlab`
    - `$ cp $SGE_ROOT/$SGE_CELL/common/leeds/pe/matlab/mpiLibConf.m ~/matlab/`
2. *Configure Matlab to submit batch jobs.* Launch Matlab on a login node and:
    - From the toolbar, select: *HOME -> Parallel -> Manage Cluster Profiles*
    - Select *Import*
    - Select file `/services/sge_prod/default/common/leeds/pe/matlab/Gridengine.settings`

*(these steps should become redundant in future installations of Matlab
on ARC)*

To use:

- Launch Matlab on a login node and *NOT* from inside a job.
- Launch a 32 worker distributed pool with the following Matlab command: `pool = parpool('Gridengine', 32);`
- This causes Matlab to submit a 32 core job. Once it has started running, you will be able to type further commands.

By default, a Gridengine parpool requests one core and 1G RAM per worker for 48 hours. Control over the type of job can be achieved by editing the cluster profile within Matlab. For example, to change the job runtime (`h_rt`), memory per worker (`h_vmem`) or add arbitrary qsub flags (`qsub_args`):

1. From toolbar, select: *HOME -> Parallel -> Manage Cluster Profiles*
2. Click on *Gridengine* (on left hand side)
3. Click on *Properties* tab (on right hand side)
4. Click on *Edit* button (bottom right)
5. Scroll to the *AdditionalProperties* box in the *SCHEDULER INTEGRATION* section.
6. Select the value for *h_rt*, *h_vmem* or *qsub_args* and modify accordingly.
7. Click on *Done* button (bottom right)

#### Hybrid multiple workers and multithreading parallelisation

It may be useful to try combining both Matlab's multithreading and Distributed Computing Server features (for example, your Matlab code spends all its time in a parfor loop and each trip through that loop spends all of its time in multithreaded routines like fft()): if appropriate, this would make the best use of our limited Distributed Computing Server licenses.

To do this:

- Use the above method for changing *h_rt* to edit the cluster profile but instead change *use_np_syntax* to *true*. This will cause entire compute nodes to be allocated to the pool.
- Repeat steps 1-4 again, but then change the value for *NumThreads* (instead of modifying the *AdditionalProperties* box). This will tell Matlab to multithread and it will also cause *NumThread* cores to be allocated to each worker.
- Since entire compute nodes are allocated, please select 'sensible' values for the number of workers and the number of cores per worker to make good use of the allocated resources. For example, on ARC3's 24 core compute nodes, the number of workers in the pool multiplied by *NumThreads* should be a multiple of 24.

#### Troubleshooting Distributed Computing Server:

- *No matter how many workers I ask for, parpool reports there is only 1 worker!* MPI has probably not been configured correctly and Matlab is running multiple workers that cannot communicate with each other. Ensure you have copied mpiLibConf.m (see above) and restart Matlab.
- *When the pool is shutdown, the job goes into an error state ("Eqw").* Matlab often deletes the files associated with the jobs it submits before the jobs themselves are deleted. If this happens, please qdel the job manually.

## GPU Matlab jobs

Matlab can take advantage of GPU hardware. To do this, first launch Matlab inside a job where GPU resources have been requested (see
[here](../../usage/gpgpu)). Within Matlab, the `gpuDevices` command will provide details of the available GPU(s):

```matlab
    >> gpuDevice

    ans = 

      CUDADevice with properties:

                          Name: 'Tesla P100-PCIE-12GB'
                         Index: 1
             ComputeCapability: '6.0'
                SupportsDouble: 1
                 DriverVersion: 9
                ToolkitVersion: 8
            MaxThreadsPerBlock: 1024
              MaxShmemPerBlock: 49152
            MaxThreadBlockSize: [1024 1024 64]
                   MaxGridSize: [2.1475e+09 65535 65535]
                     SIMDWidth: 32
                   TotalMemory: 1.2786e+10
               AvailableMemory: 1.2401e+10
           MultiprocessorCount: 56
                  ClockRateKHz: 1328500
                   ComputeMode: 'Default'
          GPUOverlapsTransfers: 1
        KernelExecutionTimeout: 0
              CanMapHostMemory: 1
               DeviceSupported: 1
                DeviceSelected: 1
```

Please see the main Matlab product documentation for writing code to use GPUs.

Multiple GPUs can also be taken advantage of; however, this must be in conjunction with the Parallel Toolbox feature (see the above section on parallel jobs and the Matlab website) as a single worker can only use one GPU at a time.

## Compiling Matlab

To run a large number of matlab jobs simultaneously it may be necessary to use the matlab compiler to create a stand-alone application. This will also avoid using too many license tokens. For a full description of the compiler please look at the in-program help or the [Matlab compiler user guide](http://www.mathworks.co.uk/help/toolbox/compiler/index.html).

### Code preparation

***Script*** m-files cannot be compiled directly, first they have to be converted to ***function*** m-files. In general, this is a case of wrapping the main section of code within a function. For more details look at [converting script m-files](http://www-rohan.sdsu.edu/doc/matlab/toolbox/compiler/ch03get9.html) section in the user guide.

### Compiling

The Matlab compiler makes use of the GNU C compilers and as the Intel compiler is loaded by default you shouldswitch to the correct version of GNU compiler via the command:

```bash
$ module switch intel gnu
```

The compiler can be invoked from within Matlab or directly from the command line via the tool `mcc` . However, to get the code to compile in single threaded mode the compiler should be invoked directly from the command line. In general this would take the form:

```bash
mcc -R -singleCompThread  -m your_program.m
```

It is very important that you include the option `-R singleCompThread` when you use `mcc` to compile matlab code. Otherwise matlab will run in multi-threaded mode and cause problems when running through the batch queues.

This compilation will yield two files of interest:

- `your_program`, which is the compiled code.
- `runyourprogram.sh`, which is the wrapper to run your compiled code.

### Running the application

Once the matlab module is loaded, you can run your stand-alone application via the wrapper and specifing the correct path to various Matlab components. This can easily be done via the environment variable `$MATLAB_HOME`. An example job script for submission to the batch queue would look like:

```bash
# Export current environment  
#$ -V
# Set a 6 hour limit
#$ -l h_rt=6:00:00
# Load matlab module
module add matlab
#set the path to Matlab runtime, via $MATLAB_HOME, run program via wrapper
./run_your_program.sh $MATLAB_HOME
```
