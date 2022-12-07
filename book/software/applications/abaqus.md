# Abaqus

## Introduction

The purpose of this guide is to get the first few models running with generic options so that you can start getting results back and have a working system that you can modify to suit the specific needs of your work. Because of this there will not be an in depth discussion of the wide range of options and commands available, however there are extensive help files available from the command line. 

Typing `help` will give a list of built-in commands, `help` will then give more specific information on that command eg. `help help` gives you information about the help command. Entering `info info` will open a help manual and `info <command>` will give specific information about that command eg. `info qsub` details the qsub command which submits a job to the queue.

## Licence Management

Abaqus is a licensed application with a limited number of license tokens. Running an Abaqus analysis requires more than one token. The number of tokens needed (T) is given by the formula T = int(5 x N^0.422) where N is the number of cpu cores. More simply, for common job sizes the numbers are:

  |Number of cores  |Tokens required  |
  |-----------------|-----------------|
  |1                |5                |
  |4                |8                |
  |8                |12               |
  |12               |14               |
  |16               |16               |
  |24               |19               |
  |32               |21               |
  |64               |28               |

**Good practice** would recommend not to run 5 jobs using 12 CPU cores each (that would require 70 license tokens, i.e. over half the available number of tokens).

For information, Abaqus scales efficiently to 4 processors, relatively well to 8 processors but poorly further. Trying to run a job over more that 8 to 12 CPU cores won't increase the performances (and running over more than the number of CPU cores per node will even decrease the performance).

## Preparation

First of all you will need an account on the facility and a suitable piece of software to access it. I will be using WinSCP to do this so keep in mind that if you are using an alternative this may have an effect.

Running an Abaqus job from the command line, which is how you perform an analysis, uses an input file with the extension `.inp`. This can be created from your model file in the Abaqus CAE by right clicking the job in the model tree and selecting `Write Input`.
This can also be done from the job manager. This will create a file called `<job_name>.inp` which is what Abaqus will use.

When logged in you will have a home directory (WinSCP should send you here automatically). If you select the open directory option above the remote directory window and select `Add` in the `Session bookmarks` tab it will save a bookmark to this directory which make it easier to navigate around. When working on the facility you should use the /nobackup directory as it has more working space and faster data speeds. Make a new directory in /nobackup and place the input file you wish to analyse in there (also bookmark this directory as well).

## Setting Up a Job

There are two sections to a job submission, the first describes the job to the queue system and the second tells Abaqus to perform the analysis and gives it the information it needs. The information for both is contained in a script file held in your /nobackup directory. This script file is a text file with the extension .sh and can be created by right-clicking in the remote directory window and selecting `New` and `File`.

In this script starting the line with a hash ( `#` ) symbol followed by a space comments out the line so that it will be skipped when the program is run. This allows you to leave notes within the code or save lines that you do not want active at the time but may need later. Starting with a hash-dollar (`#$` ) and then a space tells the system that this is a command to set up the queue. Having nothing preceding the line means that it will be used by Abaqus to set up the analysis.

For a simple script that will run an analysis on a single core use the following, note that the lines have been numbered for clarity but these numbers are not a part of the code:

```bash
#$ -l h_rt=<run_time>
#$ -l h_vmem=<amount_of_RAM_queue>
#$ -m be
#$ -cwd  -V
module add abaqus
export LM_LICENSE_FILE=<license_port>@<license_server>:$LM_LICENSE_FILE
export ABAQUSLM_LICENSE_FILE=$LM_LICENSE_FILE
abaqus memory=<amount_of_RAM_abaqus> input=<input_file> job=<job_name> int
```

`<run_time>` is the amount of time you are requesting from the queue, entered in the format `hh:mm:ss` . If the job finishes before this it is fine but if the job takes longer it will cancel when this time runs out so be sure to give more time than you think you will need to avoid jobs failing midway through, keep in mind however that requesting more time makes scheduling the jobs more difficult and the maximum run time is 48 hours.

`<amount_of_RAM_queue>` is the amount of memory you are requesting from the queue for each core (one in this example). Entered in megabytes in the format `<number>M` or gigabytes as `<number>G` so that to request 1000Mb you would type `1000M` or for 1Gb `1G` The default allocation is 1Gb. Note that Abaqus seems to use between 1-2Gb to run so this needs to be taken into account as well.

`-m be` Requests that an email be sent you your account when the job begins and finishes.

`-cwd -V` requests that the working directory is your current directory, so run this from the directory you created in /nobackup, and sends the results to the same place.

ARC3 has 24 cores per node and 128GB memory, ARC4 has 40 cores per node and 192GB memory.

`<amount_of_RAM_abaqus>` is the total amount of memory that you wish to allow Abaqus to use. When running on a single core this will be the same as the `<amount_of_RAM_queue>`, when running on multiple cores it will be that value multiplied by the number of cores you are running the analysis on. This is entered in a slightly different format than before, in the format `<number>mb` to specify the amount in megabytes. Therefore for 1000Mb enter `1000mb` .

```{note}
`<amount_of_RAM_abaqus>` is the amount of memory Abaqus will devote to the solver. There are other memory overheads required by Abaqus. Thus, you will need to define `<amount_of_RAM_abaqus>` to be less than the total memory requested from the queues to allow for this. For instance if you request two cores at `2Gb` each, then set `memory=3000m` for example, which would allow `1Gb` for memory overheads.
```

`<input_file>` is the name of the .inp input file you wish to analyse, therefore if the name of the file is `analysis1.inp` you enter `analysis1.inp` here.

`<job_name>` is the name of the job, the output files will be named `<job_name>.<extension>`.

`<nobackup_directory>` is the path of the directory you created in /nobackup. For example if you made a directory on /nobackup called `username` the value for would be `/nobackup/username` . Note that the double quotation marks surrounding the directory path are to be typed in.

`<license_port>` is the port where the Abaqus license you are using is located and `<license_server>` is the server for the same license. These details depend on the departmental license you are using and should be available by making a general request to IT.

## Parallel Processors

To make use of several cpu cores to run your analysis use a script file in the form:

```bash
#$ -l h_rt=<run_time>
#$ -l h_vmem=<amount_of_RAM_queue>
#$ -m be
#$ -pe smp <number_cores>
#$ -cwd  -V
module add abaqus
export LM_LICENSE_FILE=<license_port>@<license_server>:$LM_LICENSE_FILE
export ABAQUSLM_LICENSE_FILE=$LM_LICENSE_FILE
abaqus memory=<amount_of_RAM_abaqus> cpus=$NSLOTS input=<input_file> job=<job_name> mp_mode=threads int
```

`<number_cores>` is the number of cores you are requesting to be used for the analysis. `$NSLOTS` is an environmental variable, that is automatically set to equal `<number_cores>` , and is used to pass the number of cores to abaqus. Note that there will now be a difference between the two memory requests, as described above.

```{note}
`<amount_of_RAM_abaqus>` is the amount of memory Abaqus will devote to the solver. There are other memory overheads required by Abaqus. Thus, you will need to define `<amount_of_RAM_abaqus>` to be less than the total memory requested from the queues to allow for this. For instance if you request two cores at `2Gb` each, then set `memory=3000m` for example, which would allow `1Gb` for memory overheads.
```

## Submitting a Job

To then submit a job you use the command line in WinSCP or the comparable program that you are using. Enter `qsub <script_file_name>` where the `<script_file_name>` is the name of the file created above that holds the settings for the job. Therefore if this file is called `job_submission.sh` then you would type `qsub job_submission.sh` . If the submission is successful the command line response should confirm this and give a job ID. The status of your jobs can be queried with the line `qstat -f` . When the job starts and ends you should receive a confirmation email and the results of the analysis will be placed into your /nobackup directory.

## Example Script

Just to provide an example script with some numbers in place, for a
model requesting 12Gb of memory and 4 hours to run an analysis of the
file `input.inp` :

```bash
#$ -l h_rt=4:00:00
#$ -l h_vmem=1500M
#$ -m be
#$ -pe smp 8
#$ -cwd  -V
module add abaqus
export LM_LICENSE_FILE=<license_port>@<license_server>:$LM_LICENSE_FILE
export ABAQUSLM_LICENSE_FILE=$LM_LICENSE_FILE
abaqus memory=12000mb cpus=$NSLOTS input=input.inp job=input mp_mode=threads int
```

## User Defined Fortran subroutines

To include user defined Fortran subroutines, e.g. `exampleroutine.f` , you will need to prepend the licence for the compiler to the licence path, `export LM_LICENSE_FILE=<license_port>@<license_server>:$LM_LICENSE_FILE` .

For example:

```bash
#$ -l h_rt=4:00:00
#$ -l h_vmem=1500M
#$ -m be
#$ -cwd  -V
module add abaqus
export LM_LICENSE_FILE=<license_port>@<license_server>:$LM_LICENSE_FILE
export ABAQUSLM_LICENSE_FILE=$LM_LICENSE_FILE
abaqus memory=12000mb input=input.inp job=input user=exampleroutine int
```

This ensures that **both** Abaqus and the system default Intel Fortran compiler are able to access their relevant licence servers.

## Scratch disk space

By default abaqus uses the fast local storage of nodes for scratch space.  1Gbyte per core is allocated as standard, but you can increase this as required.  For example, to allocate 4Gbytes per core:

```bash
#$ -l disk=4G
```

Details on exactly how much local storage is available for your jobs can be found on the [Scratch](../../usage/scratch) page.

If you need more than is available on a local node, you can use /nobackup.  You do this with the scratch parameter to abaqus, e.g.:

```bash
mkdir -p /nobackup/$USER/scratch
abaqus memory=12000mb input=input.inp job=input user=exampleroutine scratch="/nobackup/$USER/scratch" in
```

## Checkpointing

Users sometimes find that their jobs take longer than the 48 hours permitted by the scheduler to complete. Providing that your model does not automatically re-mesh (for example, after a fracture), you may be able to make use of Abaqus' built-in checkpointing function.

This will create a **restart** file (.res file extension) from which a job that is killed can be restarted.

1. Activate the restart feature by adding the line:

    ```
    *restart, write
    ```

    To the top of your input file and run your job as normal. It should produce a restart file with a `.res` file extension.

2. Run the restart analysis with

    ```bash
    abaqus job=jobName oldjob=oldjobName ...
    ```

    Where `oldJobName` is the initial input file and `newJobName` is a file which contains only the line:

    ```
        *restart, read
    ```
