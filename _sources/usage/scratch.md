# Temporary/Scratch Storage on Compute nodes

Each HPC compute node contains a limited amount of dedicated storage and its capacity and performance is different for each type of node. As this storage is local to the compute node, it can offer more predictable performance than writing to the high performance filesystem, [`/nobackup`](../getting_started/nobackup) , which is shared between all compute nodes

On our previous clusters, such storage is available for use by jobs – mostly under `/scratch` and via the directory name contained in the `$TMPDIR` environment variable, but also a small amount under `/tmp`. However, jobs could not reserve the local space they need and so could fail unexpectedly if another job running on the same node was also writing to local disk.

On ARC3 and ARC4, if a job wishes to use the compute node disk, this should be explicitly requested by the job.

## Usage

Summary:

- Use of `/tmp` should be **avoided**, as it is relatively small and space usage is uncontrolled
- Use of `/scratch` should be **avoided**, as this is now the same storage as `/tmp`
- `$TMPDIR` within a job refers to a per-job directory which has been assigned dedicated storage for the job

### ARC3 local disk specifications

```{note}
ssd - refers to a solid state disk, which has excellent performance characteristics for reading and writing <br>
hdd - refers to a mechanical hard disk with a spinning platter, which has good performance characteristics for large sequential reads or writes only
```

```{list-table}
:header-rows: 1
:widths: 10 10 10 10 10

* - Node Type
  - Number of nodes
  - Memory
  - Local Disk Capacity
  - Local Disk Type
* - Standard
  - 165
  - 128GB
  - 100GB
  - ssd
* - High Memory
  - 2
  - 768GB
  - 800GB
  - hdd
* - GPGPU K80
  - 2 – each with 2 NVIDIA K80 GPUs
  - 128GB
  - 800GB
  - hdd
* - GPGPU P100
  - 6 – each with 4 NVIDIA P100 GPUs
  - 256GB
  - 800GB
  - hdd
```

### ARC4 local disk specifications

```{list-table}
:header-rows: 1
:widths: 10 10 10 10 10

* - Guide to the Nodes on ARC4 Node Type
  - Number of nodes
  - Memory
  - Local Disk Capacity
  - Local Disk Type
* - Standard
  - 149
  - 192GB
  - 128GB
  - ssd
* - High Memory
  - 2
  - 768GB
  - 800GB
  - ssd
* - GPGPU
  - 3 – each with 4 NVIDIA V100 GPUs
  - 192GB
  - 128B
  - ssd
```

### Requesting local disk

[`qsub`](./batchjob) options for requesting local disk on ARC3 and ARC4:

```{list-table}
:header-rows: 1
:widths: 10 30 10

* - Option
  - Description
  - Default
* - `-l disk=<bytes>`
  - Sets the limit of the local disk available under `$TMPDIR` (per core)
  - 1G per core
* - `-l disk_type=*|ssd|hdd`
  - Specifies the type of local disk that files under `$TMPDIR` will be written to. There are 3 options:

    1. \* which is the default and specifies any type of disk
    2. ssd – which explicitly specifies solid state disk
    3. hdd – which explicitly specifies hard disk drive.

    Reading and writing will be much quicker to a solid state drive and this option should be used if you have lots of read and write operations.
  - \*
* - `-l disk_out=<directory>`
  - Specifies the directory to which the contents of `$TMPDIR` will be copied to at the end of a job. As `$TMPDIR` will be deleted at the end of the job, this could be useful if you need to keep its contents, for example if you are check pointing.

    The files will be copied to directory `<directory>/<job_id>.<task_id>`
    (where task_id = 1 if the job is not part of a task array.)

    Please note that, for distributed parallel jobs, only the `$TMPDIR` on the compute node where the job script runs is saved.
  - No copy by default.
* - `-l disk_usejobname`
  - When used in conjunction with the `-l disk_out=<directory>` option, the directory name that `$TMPDIR` is copied to at the end of the job is changed to `<directory>/<job_name>` , where `<job_name>` can be specified with the `-N <job_name>` option.
  - false
```
