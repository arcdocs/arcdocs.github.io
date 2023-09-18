# General Purpose GPU

The HPC systems at Leeds also include general purpose GPU facilities for GPU-accelerated code. These differ between [ARC3](#arc3) and [ARC4](#arc4) but can be requested through the job submission script process as outlined below.

GPUs are not available on the login nodes, so a job must be submitted with the required arguments to run code that requires GPUs.  Specific guidance on the required parameters for using a GPU are listed below, but general guidance on submitting jobs to the queues can be found in the [Batch jobs](batchjob) section.

## CUDA Module

To use the GPU cards you will need to ensure that the NVIDIA CUDA toolkit module is loaded into your environment:

```bash
$ module load cuda
# This needs to be done before compiling or running GPU code
```

Note that this version of the CUDA environment will only work with certain compiler versions:

- INTEL versions 15 and 16
- PGI versions >= 16.3
- GNU version 4.8.2 (this is the gnu/native compiler)

To confirm what cards you have been allocated use the command:

```bash
$ nvidia-smi -L
```

## ARC3

The ARC3 system is the first cluster at Leeds to include GPU accelerator technologies. These include:

- 2 nodes each with 24 cores, 128GB of system memory, a hard disk drive within the node with 800GB capacity and 2 x NVIDIA K80 24Gbytes
- 6 nodes each with 24 cores, 256GB of system memory, an SSD within the node with 650GB capacity and 4 x NVIDIA P100 12Gbytes

### Usage

#### K80 GPU

To request K80 GPU resource you should use the flag:

```bash
#$ -l coproc_k80=<cards_per_compute_node>
```

Where `<cards_per_compute_node>` should be set to 1 or 2.

```{list-table}
:header-rows: 1
:widths: 10 30

* - Job script line
  - Requested resource
* - `#$ -l coproc_k80=1`
  - A single K80 card, 12 CPU cores and 64GB system memory (half the available resource on a K80 node)
* - `#$ -l coproc_k80=2`
  - Both K80 cards, 24 CPU cores and 128GB system memory (all the available resource on a K80 node)
```

#### P100 GPU

To request P100 GPU resource you should use the flag:

```bash
#$ -l coproc_p100=<cards_per_compute_node>
```

Where `<cards_per_compute_node>` should be set to 1, 2, 3 or 4.

```{list-table}
:header-rows: 1
:widths: 10 30

* - Job script line
  - Requested resource
* - `#$ -l coproc_p100=1`
  - A single P100 card, 6 CPU cores and 64GB system memory (one quarter of the available resource on a P100 node)
* - `#$ -l coproc_p100=2`
  - Two P100 cards, 12 CPU cores and 128GB system memory (half of the available resource on a P100 node)
* - `#$ -l coproc_p100=3`
  - Three P100 cards, 18 CPU cores and 192GB system memory (three-quarters of the available resource on a P100 node)
* - `#$ -l coproc_p100=4`
  - Four P100 cards, 24 CPU cores and 256GB system memory (all the available resource on a P100 node)
```

## ARC4

The ARC4 system also comes with the following GPU resources:

- 3 nodes each with 40 cores, 192GB of system memory, an SSD within the node with 128GB capacity and 4 x NVIDIA V100 32Gbytes

### Usage

#### V100 GPU

To request V100 GPU resource you should use the flag:

```bash
#$ -l coproc_v100=<cards_per_compute_node>
```

Where `<cards_per_compute_node>` should be set to 1, 2, 3 or 4.

```{list-table}
:header-rows: 1
:widths: 10 30

* - Job script line
  - Requested resource
* - `#$ -l coproc_v100=1`
  -  A single V100 card, 10 CPU cores and 48GB system memory (one quarter of the available resource on a V100 node)
* - `#$ -l coproc_v100=2`
  - Two V100 cards, 20 CPU cores and 96GB system memory (half of the available resource on a V100 node)
* - `#$ -l coproc_v100=3`
  - Three V100 cards, 30 CPU cores and 144GB system memory (three-quarters of the available resource on a V100 node)
* - `#$ -l coproc_v100=4`
  - Four V100 cards, 40 CPU cores and 192GB system memory (all the available resource on a V100 node)
```
