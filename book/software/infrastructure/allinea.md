# Allinea

Allinea is a debugging tool for C, C++ and Fortran 90 produced by Allinea Software Ltd. who are now owned by ARM.

```{note}
You can also use the [Arm Forge module](./arm-forge) for a more recent version of the Allinea tool
```

## Allinea – serial and parallel debugging and profiling

Allinea’s DDT and MAP applications are installed: these are primarily provided to help parallel application writers to debug or profile their applications (that is, to correct or to discover how the application is performing). They are useful for serial, MPI, OpenMP and CUDA codes.

DDT, the debugger, offers a compelling alternative to attaching gdb sessions to individual processes. It offers a simple GUI allowing a clean visual overview of the entire parallel program.

MAP, the profiler, offers a low-overhead method to obtain information of MPI, CPU and memory use over a program’s run.

To use, please first execute:

```bash
module load allinea
```

Although basic usage is covered below, please refer to the Allinea documentation. A copy of this is held on the system (at `$ALLINEA_HOME/doc/userguide.pdf` once the allinea module is loaded)

Website is: https://www.arm.com/products/development-tools/server-and-hpc/forge

## Licensing

Please note that we have a limited number of DDT and MAP license tokens (32 as of October 2014). Each running GUI consumes 1 token. Each rank of a running MPI process being debugged or profiled also consumes 1 token.

Once the GUI or application exits, those tokens are returned and able to be used by others.
Launching the GUI

To launch the GUI for the parallel debugger:

```bash
ddt
```

To launch the GUI for the parallel profiler:

```bash
map
```

## Submit interactively to the batch queues

The normal procedure is to launch the GUI on the login node and then use it’s functionality to automatically submit the job to the queue. DDT will wait for the job to start and then automatically attach itself to the running processes.

Launch the DDT or MAP GUI and click on **Run**. Fill out the job details, such as:

- The application binary
- Ensure Submit to Queue is checked
- The runtime of the job (via the Parameters… button to the right of Submit to Queue )
- For MPI codes:
  - Ensure MPI is checked
  - The Number of processes
  - The number of Processes per Node
  - The MPI Implementation . We currently recommend Open MPI (Compatibility) for OpenMPI and Auto-Detect for Intel MPI and MVAPICH2. Click on Change.. -> MPI/UPC Implementation to alter.
- For OpenMP codes:
  - Ensure OpenMP is checked
  - The number of OpenMP threads

Once ready, click on Submit.

The GUI will show the output from qstat in a new window and start at the appropriate time.

If you need access to a particular set of resources for debugging purposes at a specific time, please [contact us](https://it.leeds.ac.uk/it?id=sc_cat_item&sys_id=7587b2530f675f00a82247ece1050eda) to discuss arranging an *advanced reservation*.
Submit non-interactively to the batch queues

## Create a job submission script of the form and submit to the batch queue with qsub command

For MAP:

```bash
#$ -l h_rt=1:0:0
#$ -l np=16
module load allinea
map -n $NSLOTS
```

For DDT (can be used for using tracepoints and memory debugging, etc.):

```bash
#$ -l h_rt=1:0:0
#$ -l np=16
module load allinea
ddt -n $NSLOTS -offline myjob.txt
```

## Further support

Allinea provide a range of training and support materials, including:

A Youtube channel
