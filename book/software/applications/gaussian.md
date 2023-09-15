# Gaussian

## Accessing Gaussian

If you require access to Gaussian, please [contact us asking to be added to the
Gaussian group](https://bit.ly/arc-help). Your request must include the phrase:

***I agree to abide by the licensing conditions for academic use and citation
as published by Gaussian Inc. and which may be varied from time to time.***

Our licensing agreement with Gaussian Inc allows for the use of their programs
ONLY for academic research purposes. It is not permitted to use the software
for commercial development or software application being developed for
commercial release is permitted.

In addition, it is not permitted to compare the performance of Gaussian
programs with competitor products (i.e. Molpro, Jaguar, etc).

The source code CANNOT be used or accessed by any individual involved in the
development of computational algorithms that may compete with those of Gaussian
Inc.

The source code or binaries CANNOT be copied or made available for use outside
of The University of Leeds.

Our license agreement with Gaussian, Inc. requires that all academic work
created using the Gaussian package cite the use of Gaussian.

The required and proper citation information may be found on the Gaussian
website at:\
<https://gaussian.com/g09citation/>

## Program Technical Support

The most recent version of the Gaussian manual, which has detailed explanations
of the program options, a range of examples, and instructions regarding scratch
file saving, memory allocation, running in parallel, etc. is available at:

<https://gaussian.com/man/>

## Initial setup

To set up Gaussian, at the command prompt, enter:

    $ module add gaussian

### Using Scratch for Temporary Files

Gaussian uses the environment variable GAUSS_SCRDIR to write scratch files
during its run.  Normal Gaussian runs will be undertaken on the compute nodes.
If you do not specify this variable, files are written to /tmp which can
quickly fill up, causing problems for you job and other users.  If you're
wanting to use fast local disk you're better off using \$TMPDIR by adding this
to your submission script before running g09:

    export GAUSS_SCRDIR=$TMPDIR

For details on how you request more local storage, see our page on
[local storage](../../usage/scratch).

Sometimes, the Gausssian temporary files can be large and the
\$TMPDIR directory will not be large enough.\ In this case we advise setting
the GAUSS_SCRDIR to a directory on /nobackup instead:

    export GAUSS_SCRDIR=/nobackup/your_directory

As /nobackup is a parallel filesystem it should offer better performance than
other network drives on the system although this will be slower than using the
compute node 'scratch disks'.

When jobs finish, please delete any scratch files since they can consume a
considerable amount of disk space. In general, the only scratch file necessary
to save from any given Gaussian job is the .chk file (for restart purposes).
Other scratch files, such as read-write files ( .rwf ), integral files ( .int),
and second derivative files ( .d2e ) need not be saved. Automatic deletion of
all files but the scratch file is easily accomplished by appropriate placement
of the following command in the link 0 section of the Gaussian input file (its
use is described in detail in the Gaussian manual):

    %NoSave

## Running the code

### Launching on the login nodes

Gaussian can be launched by entering g09 on the command line followed by the
input filename:

    $ g09 inputfile

**Only very short runs should be launched on the login nodes.** Compute
intensive runs should be executed through the batch queues (see below).

For further information on the usage of Gaussian, please consult the
[online documentation](https://gaussian.com/man/).

### Launching through the batch queues

To run through the batch queues, construct a script requesting the resources
required for the job. It may be appropriate to consider both memory usage and
CPU time limits for the job.

A sample script follows:

    #$ -cwd
    #$ -l h_rt=1:00:00
    #$ -l h_vmem=1G
    module add gaussian
    export GAUSS_SCRDIR=$TMPDIR
    g09 formaldeyhde.com

This will request 1 hour of runtime on a single processor with 1GB memory, this
is the default amount of memory so the line `#$ -l h_vmem=1G` does not really
need to be included.

### Running in Parallel (Shared Memory)

The Gaussian executable is configured for shared memory parallel execution.

Unlike most shared-memory codes, Gaussian uses its own thread management, it is
therefore important to set both the Gaussian input file (link 0 command:
`%NprocShared=np`) **and** the job submission script to use an identical number
of execution threads. The OMP\_NUM\_THREADS variable should only be set to 1 or
not at all (the default) for Gaussian to work correctly.

A sample script is:

    #$ -cwd
    #$ -l h_rt=1:00:00
    #$ -l h_vmem=1G
    #$ -l h_stack=100M
    #$ -pe smp <np>
    module add gaussian
    export GAUSS_SCRDIR=$TMPDIR
    export OMP_NUM_THREADS=1
    g09 formaldeyhde.com

This will request \<np\> processors, each with 1GB memory.

On ARC3 the maximum size of job is 24 cores and a total of 128GB on a standard
node or 768GB on a high memory node.  On ARC4 this increases to 40 cores and a
total of 192GB on a standard node or 768GB on a high memory node.

To instruct Gaussian to start \<np\> threads, `%NProcShared=\<np\>` should be set
in the Gaussian input file.

It is possible to combine the submission script and input file into a single
script so that the np in the submission script always matches `%NProcShared=\<np\>`
in the Gaussian input file:

    #$ -cwd
    #$ -l h_rt=1:00:00
    #$ -l h_vmem=1G
    #$ -pe smp 8
    module add gaussian
    export GAUSS_SCRDIR=$TMPDIR
    export OMP_NUM_THREADS=1
    cat < formaldeyhde.com
    %NprocShared=${NSLOTS}
    %mem=200MB
    %rwf=/scratch/formaldehyde
    %NoSave
    %chk=formaldehyde
    # b3lyp/6-31g scf=(tight,maxcycle=1000)

    formaldehyde single point DFT calculation, Cs symmetry

    0 1
     C                 -1.54150194    0.53359683    0.00000000
     H                 -1.00833820   -0.39410809    0.00000000
     H                 -2.61150194    0.53359683    0.00000000
     O                 -0.91446151    1.62464718    0.00000000

    EOF

    g09 formaldeyhde.com
    rm ${GAUSS_SCRDIR}/*

The above script can be submitted to the batch queues through the qsub command:

    $ qsub

When it runs, it creates the input file, formaldehyde\\.com, and then runs the
job, such that the .log file and .chk file are saved in the current working
directory. The .rwf files are written to local disk on the compute node where
the job runs, and deleted upon completion of the job.

While Gaussian may be run on several processors, note that the maximum number
of processors and maximum available memory is often not appropriate, and may
even slow performance.

In practice, Gaussian does not appear to scale well over more than 4-6
processors, depending on the job type. The Gaussian manual includes a section
that discusses efficiency, and offers recommendations regarding memory
allocation for various types of serial and parallel jobs run at different
levels of theory with different basis sets.

### Running in Parallel (Distributed Memory)

Whereas parallel runs of Gaussian using the method above are limited by the
number of CPUs in a compute node, it is also possible to make use of a larger
number of CPUs across distributed nodes by using the Linda parallel execution
environment.

This requires adding some additional instructions to both the job submission
script and the input file.

Submission script for ARC3:

    #$ -V
    #$ -cwd
    #$ -l h_rt=30:00:00
    #$ -l nodes=2,ppn=1,tpp=24
    #$ -N Pt33-31et.com

    # set prefix to be your input filename
    prefix=Pt33-31et
    export GAUSS_SCRDIR=$TMPDIR

    # prepare a valid MACHINEFILE and set it to be used:
    echo "%LindaWorkers="`awk -vORS=, '{print $1}' $PE_HOSTFILE | sed 's/,$/\n/'` > ${prefix}-LINDA.com
    cat ${prefix}.com >> ${prefix}-LINDA.com

    export GAUSS_LFLAGS=' -opt "Tsnet.Node.lindarsharg: ssh"'

    # run Gaussian 09
    module add gaussian/G09.D01
    g09 < ${prefix}.com
    rm ${GAUSS_SCRDIR}/*

This will set up:

-   A 30hr runtime job
-   Using all the cores on 2 nodes

The corresponding link 0 section of the input file would therefore be:

    %nprocshared=16
    %mem=32GB
    %chk=Pt33-31et.chk
    # opt freq ub3lyp/lanl2dz scrf=(solvent=water) geom=connectivity
    scf=(intrep,xqc)

    Pt31-35et

Note that:

-   %nprocshared has the same value as tpp

### Managing temporary files

Gaussian creates large temporary files in the \$GAUSS\_SCRDIR. To prevent this
directory filling up, it is best to clear it out at the end of the run. An
example script which runs Gaussian, then clears the temporary files is:

    #$ -cwd
    #$ -l h_rt=23:00:00
    #$ -l h_vmem=1G
    module add gaussian
    export GAUSS_SCRDIR=$TMPDIR
    g09 CH3CH2CHCOOCH3_opt.com
    rm ${GAUSS_SCRDIR}/*

## Using Gaussview

Gaussview is installed for the preparation of Gaussian input files and viewing
of output.

It may be better to install this application on a local workstation, rather
than viewing the graphics over the network.

An X-server should be running on the local machine & your SSH connection should
have X11 forwarding enabled to use the Gaussview GUI.  Documentation for
gaining ssh access to the ARC systems is in the web pages that describe how to
login in from each of the 3 main operating systems - [How to connect and log on to ARC3/ARC4](../../getting_started/logon).

Note the X-server needs to have 3D OpenGL extensions, most Linux/Mac X servers
will have this functionality, however older versions of Exceed may not support
this. Gaussview appears to work with Cygwin X-server, but has made Xming crash.
ARC3 also has [X2Go](../../getting_started/x2go) installed and this handles
X-Windowing so that normally it provides a smooth images/animations with a no
lag between frames and handles graphics communications without producing errors
to your shell.

### Launching on the front end

The Gaussian module sets up an alias to Gaussview gv:

    $ gview

#### Note for macOS users

Gaussview does not work via X forwarding for macOS users using XQuartz
2.7.11 and will cause an error such as the following to appear:

    libGL error: No matching fbConfigs or visuals found
    libGL error: failed to load driver: swrast
    [xcb] Unknown sequence number while processing queue
    [xcb] Most likely this is a multi-threaded client and XInitThreads has not been called
    [xcb] Aborting, sorry about that.
    gview.exe: xcb_io.c:259: poll_for_event: Assertion `!xcb_xlib_threads_sequence_lost' failed.

To resolve this problem you will need to uninstall XQuartz 2.7.11 and install
an earlier version XQuartz 2.7.8 ([Click here to download the .dmg file](https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.8.dmg)).  You will
then need to run the following command in your macOS Terminal **(Not on ARC)**:

    $ defaults write org.macosforge.xquartz.X11 enable_iglx -bool true

You should then be able to open gview over X forwarding.

### Launching through the batch queues

If your use of Gaussview is compute intensive, you are encouraged to submit it
as an interactive job to the batch queues. The following line can be used for
this:

    $ qrsh -V -cwd -l h_rt=1:00:00 gview

This will ask for 1 hour of runtime.

### Launching Gaussian jobs from within gview

This is possible, however you are encouraged to save the gaussian input file
and submit the job to the queues via the command line.
