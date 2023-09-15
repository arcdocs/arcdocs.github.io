# ARC3

## Operating system
ARC3 is the third phase of the ARC service here at Leeds and provides a Linux-based HPC service, based on the CentOS 7 distribution.

## Initial Hardware Configuration

### Compute

All compute are Broadwell E5-2650v4 CPUs: Clock rate for non-AVX instructions is 2.2GHz and for AVX instructions is 1.8GHz. memory bandwidth per core is 800MHz/core System will turbo where it can. Using fewer cores will mean active cores can turbo more. The are 3 types of node.

(arc3:standard-nodes)=
#### Standard nodes

252 nodes with 24 cores and 128GB of memory each and an SSD within the node with 100GB of storage. This provides **6048** cores of **standard compute**. These are the default nodes for jobs and do not need to be requested explicitly.

#### High memory nodes
4 nodes with 24 cores and 768GB of memory each and a hard disk drive within the node with 800GB of storage. This provides 96 cores of **high memory compute**.
These can be requested by adding this line to submission scripts:

`#$ -l node_type=24core-768G`

(arc3:gpgpu)=
#### GPGPU nodes

2 nodes each with 24 cores, 128GB of system memory, a hard disk drive within the node with 800GB of storage and **2 x NVIDIA K80s**.

6 nodes each with 24 cores, 256GB of system memory, a hard disk drive within the node with 800GB of storage and **4 x NVIDIA P100s**

#### Intel Xeon Phi nodes
2 nodes each with a single Intel **Xeon Phi Knight’s Landing** processor, 96GB system memory, 16GB MCDRAM and a 800GB hard drive.

(arc3:lustre)=
#### Lustre Storage

Two fail-over pairs delivering 4GB/s via the InfiniBand network to 836TB usable storage on /nobackup

### Network

#### InfiniBand
The compute nodes are connected with Infiniband FDR of 56Gbit/s (vs. a QDR of 40Gbit/s on ARC2) in a 2:1 blocking topology, built up from non-blocking islands of 24 nodes.

#### Gigabit
Management and general networks facilitating system boot. All other traffic carried over the InfiniBand Network.

## Other general notes

When compiling codes with the Intel compiler, the most appropriate flag to use is:

`-xCORE-AVX2`
Broadwell CPUs should be better at maintaining performance when mixing AVX/non-AVX instructions in the same program.

Users with a keen eye will notice that there are a number of other queues available on the ARC3 machine which will redirect jobs to nodes that are not listed here. These are private nodes purchased for the exclusive use of certain research groups at the University. If you believe that you should be able to access these nodes, please speak to your PI or Supervisor in the first instance.

## Network Topology
There are 2 login nodes and 2 head nodes. All nodes are connected to the InfiniBand network and use it to transfer all user data.

## Lustre File System
A large amount of infrastructure is dedicated to the Lustre parallel filesystem, which is mounted on /nobackup. This is accessed over infiniband, and is configured to deliver ~5GB/s from a 836TB filesystem. It is possible to tune the filesystem in a more-extreme (or conservative) manner, however this configuration achieves a sensible compromise between data integrity and performance.

## Using the K80 GPU nodes
Adding one of the following lines to a submission script will allocate:

|Required line       | Result|
|--------------------|-------|
|`#$ -l coproc_k80=1`|A single K80 card, 12 CPU cores and 64GB system memory (half the available resource on a K80 node)|
|`#$ -l coproc_k80=2`|Both K80 cards, 24 CPU cores and 128GB system memory (all the available resource on a K80 node)|

## Using the P100 GPU nodes
Adding one of the following lines to a submission script will allocate:

|Required line        | Result|
|---------------------|-------|
|`#$ -l coproc_p100=1`|A single P100 card, 6 CPU cores and 64GB system memory (one quarter of the available resource on a P100 node)|
|`#$ -l coproc_p100=2`|Two P100 cards, 12 CPU cores and 128GB system memory (half of the available resource on a P100 node)|
|`#$ -l coproc_p100=3`|Three P100 cards, 18 CPU cores and 192GB system memory (three-quarters of the available resource on a P100 node)|
|`#$ -l coproc_p100=4`|Four P100 cards, 24 CPU cores and 256GB system memory (all the available resource on a P100 node)|

## Using the Xeon Phi KNL nodes
Add this line:

`#$ -l node_type=256thread-112G`
to a submission script to allocate this node to a job.

**Note:** These nodes should only be used for code that has been optimised to run on a Xeon Phi.

Each node contains an single KNL device which has 64 cores (each core has 4 hyperthreads). There is 96G of system memory plus 16G of fast MCDRAM.

System memory is configured in quadrant mode.

MCDRAM can be configured in one of three different ways, e.g. to launch a 64 thread OpenMP job:

|Required line| Result|
|-------------|-------|
|`#$ -l nodes=1,tpp=64,node_type=256thread-112G,mcdram_mode=cache`|Transparent cache|
|`#$ -l nodes=1,tpp=64,node_type=256thread-112G,mcdram_mode=memory`|System memory|
|`#$ -l nodes=1,tpp=64,node_type=256thread-112G,mcdram_mode=half`|Half transparent cache and half system memory|

When compiling for the KNL using the Intel compiler, make sure you use the `-xMIC-AVX512` compile flag.

As there are more ways to configure these systems than there are nodes, please check the output of qstat -g c (looking for the lines starting with 256thread-112G), to see how they are currently configured. Please get in touch if you wish to evaluate the performance of Knights Landing in a mode that is unavailable.
