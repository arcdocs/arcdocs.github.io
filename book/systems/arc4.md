# ARC4

## Operating system
ARC4 is our latest HPC cluster here at Leeds and provides a Linux-based HPC service, based on the CentOS 7 distribution.

## Initial Hardware Configuration

### Compute

All compute nodes contain Intel Xeon Gold 6138 CPUs ('Sky Lake')

The clock rate for non-AVX instructions is 2.0GHz and for AVX and AVX-512 instructions will be a little reduced from this.

Memory bandwidth per core is 800MHz.

System will turbo where it can. Using fewer cores will mean active cores can turbo more.

There are three types of node on this cluster: **standard nodes**; **high memory nodes** and **GPU nodes**.

(arc4:standard-nodes)=
#### Standard nodes

149 nodes with 40 cores and 192GB of memory each and an SSD within the node with 170GB of storage. This provides **5960** cores of **standard compute**.

These are the default nodes for jobs and do not need to be requested explicitly.

#### High memory nodes

2 nodes with 40 cores and 768GB of memory each and a hard disk drive within the node with 800GB of storage. This provides 80 cores of **high memory compute**.

These can be requested by adding this line to submission scripts:

`#$ -l node_type=40core-768G`

(arc4:gpgpu)=
#### GPGPU nodes
3 nodes each with 40 cores, 192GB of system memory, a hard disk drive within the node with 800GB of storage and **4 x NVIDIA V100 GPUs**.
[See GPU section below](#using-the-v100-gpu-nodes) on how to access these nodes

(arc4:lustre)=
### Lustre Storage

Two fail-over pairs delivering 11GB/s via the InfiniBand network to **1.2PB** usable storage on **/nobackup**

### Network

#### InfiniBand

The compute nodes are connected with Infiniband EDR of 100Gbit/s (vs. a FDR of 56Gbit/s on ARC3) in a 2:1 blocking topology, built up from non-blocking islands of 24 nodes.

#### Gigabit
Management and general networks facilitating system boot. All other traffic carried over the InfiniBand Network.

## Other general notes

When compiling codes with the Intel compiler, the most appropriate flag to use is `-xCORE-AVX2`
Sky Lake CPUs should be better at maintaining performance when mixing AVX/non-AVX instructions in the same program.

Users with a keen eye will notice that there are a number of other queues available on the ARC4 machine which will redirect jobs to nodes that are not listed here. These are private nodes purchased for the exclusive use of certain research groups at the University. If you believe that you should be able to access these nodes, please speak to your PI or Supervisor in the first instance.

## Network Topology
There are 2 login nodes and 2 head nodes. All nodes are connected to the InfiniBand network and use it to transfer all user data.

## Lustre File System
A large amount of infrastructure is dedicated to the Lustre parallel filesystem, which is mounted on /nobackup. This is accessed over Infiniband, and is configured to deliver ~11GB/s from a 1.2PB filesystem. It is possible to tune the filesystem in a more-extreme (or conservative) manner, however this configuration achieves a sensible compromise between data integrity and performance.

## Using the V100 GPU nodes
Adding one of the following lines to a submission script will allocate:

|Required line        | Result|
|---------------------|-------|
|`#$ -l coproc_v100=1`| A single V100 card, 10 CPU cores and 48GB system memory (one quarter of the available resource on a V100 node)|
|`#$ -l coproc_v100=2`| Two V100 cards, 20 CPU cores and 96GB system memory (half of the available resource on a V100 node)|
|`#$ -l coproc_v100=3`|Three V100 cards, 30 CPU cores and 144GB system memory (three-quarters of the available resource on a V100 node)|
|`#$ -l coproc_v100=4`|Four V100 cards, 40 CPU cores and 192GB system memory (all the available resource on a V100 node)|
