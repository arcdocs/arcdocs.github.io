# MUST

MUST detects usage errors of the Message Passing Interface (MPI) and reports them to the user. As MPI calls are complex and usage errors common, this functionality is extremely helpful for application developers that want to develop correct MPI applications. This includes errors that already manifest - segmentation faults or incorrect results - as well as many errors that are not visible to the application developer or do not manifest on a certain system or MPI implementation.



Read more about MUST on their [website](https://www.i12.rwth-aachen.de/go/id/nrbe).





## The MUST module on the HPC

The MUST module can be loaded into your environment with the following command:

```bash
$ module add must
```

The MUST module is available on ARC3:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC3
  - must 1.5
  - `module add must/1.5`

```
