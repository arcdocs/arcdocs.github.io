# VisIt

## Introduction

[VisIt](https://visit.llnl.gov) is a data analysis and visualisation
application, developed to be able to analyse large datasets. We show
here how to start the program on our facilities; however, please refer
to the project documentation for details on how to use the application
itself.

Although VisIt is flexible in the way it is deployed, the simplest
method of invoking it is to run these commands on a login node:

    $ module load visit
    $ visit

This will provide the core functionality. More complicated methods are
described below, offering different levels of performance. For example,
the graphical interface can be run locally on a low-end workstation or
laptop, while the rendering takes place in parallel on the cluster --
taking advantage of the CPU, memory and storage resources available.
Although not making use of the acceleration that graphics cards provide,
it can allow larger datasets that cannot fit onto a graphics card to be
analysed.

## Running VisIt on the ARC Systems

Please note that these methods depend on your workstation having an X
server running and for you to have enabled X11 forwarding through your
SSH client.

### On a cluster login node (quick start)

Recommended for very short or undemanding pieces of work. Login to the
cluster and execute:

    $ module load visit
    $ visit

Please note that, as they are shared between all users, it is important
not to tackle large pieces of work on the login nodes.

### On the cluster compute nodes

Recommended for larger pieces of work:

    $ module load visit
    $ qrsh -cwd -V -l h_rt=<hh:mm:ss> -l h_vmem=<vmem> visit

Or, where using more than one cpu is useful, to launch visit in parallel

    $ module load visit
    $ qrsh -cwd -V -l h_rt=<hh:mm:ss> -l h_vmem=<vmem> -pe ib <num> visit -np <num>

In the above commands, `<hh:mm:ss>` is the length of real time the program
will be run for, `<vmem>` is the amount of memory required per core (e.g.
"1G" for 1 GB RAM), and `<num>` is the number of cores required (please note
it appears twice in the command).

## Running VisIT on your workstation, offload storage and processing to the ARC systems

Recommended where the graphical interface (menu items, etc.) feels
sluggish, or where the best possible performance is required.

Select a version number from the list of installed versions of visit,
then download and install a copy of that version appropriate to your
machine from <https://visit.llnl.gov>. The list of installed versions
is provided by executing the following command on the cluster:

    $ module avail visit

If installing on a Windows platform, you will be asked to select the
desired network configuration and given a choice of a number of
institutions. Please select `None` .

### Configure for remote execution

Once installed, start the program and then exit it: this will create a
number of directories.

Then, download the files corresponding to the cluster you wish to use:

{download}`host_arc3 <../../assets/downloads/software/applications/visit/host_arc3.xml>`

{download}`host_arc4 <../../assets/downloads/software/applications/visit/host_arc4.xml>`

On a Linux, Unix or Mac platform, please save these files to your
`.visit/hosts/` directory,
found within your home directory.

On a Windows platform, please save these files to the application
directory. Depending on whether VisIT was installed by an administrator
for all users or just for your account, this may be found under
`Computer->C:->Profile Files/LLNL/VisIt <ver>/hosts` or
`Computer->C:->Users->YourUsername->AppData->Local->Programs->LLNL->VisIT
<ver>->hosts`

Start VisIt once again and select the menu item `Options->Host Profiles...` This will open a
window, which should contain an entry on the left hand side for each of
the host files saved earlier. For each host in turn:

1. Log into the cluster. Find the location of VisIT by loading the
module for the version you want and examining a variable.

    module load visit/
    echo $VISIT_HOME

2. Highlight the hostname by clicking on it. On the right hand side,\
look for the configuration item `Path to VisIt
installation` . If you cannot
see it, click on the `Machines` and `Host Settings` tabs. Enter the location string found in step (1) above.

3. Close the window with the `Dismiss` button

4. Save settings with the `Options->Save Settings` menu item

### Launch remote execution

1. With VisIt running on your workstation, select menu item `File->Open file...` to open the `File open` window.

2. There will be a drop-down text box marked `Host` . Click on its arrow, which should show a
list including `localhost`
(your workstation) and each of the clusters you configured in the steps
above. Select the cluster you wish to use.

3. The `File open` window
should now show files on the cluster. Select a file visit understands
and press `OK`

4. A Select options for `<clustername>` should appear. Select `serial (login
node)`S for a single process
on a login node (please note that login nodes are shared between all
users of the cluster -- it should only be used for short or undemanding
pieces of work), or `mpi (batch queue)` to launch visit on the cluster's compute nodes through
the batch queue system. When
launching through the batch queues, specify the number of cores required
into `Num procs` , the length
of time the resources are required into [Time limit] and any other batch queue options into
`Bank` (the default value,
`-l h_vmem=1G` requests 1G
RAM per requested process).

Once VisIt has launched onto the login node or the batch queue has
started running, use VisIt normally.

To double-check what resources are in use, select the menu item
`File->Compute Engines...`

## Developing plugins with VisIt

When developing plugins to extend the software it is probably useful to
use the same development environment used to build VisIt, in order to
minimise compatibility problems between different C++ compilers, etc. If
we have compiled a particular version of VisIt ourselves instead of
using the version from the VisIt website, loading the
`visit` module will set
environment variable `VISIT_BUILD_MODULES` to contain the list of modules used build it. For
example:

    $ module load visit
    $ echo $VISIT_BUILD_MODULES
    gnu/native openmpi mkl qt
