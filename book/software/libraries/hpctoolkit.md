# HPCToolkit

HPCToolkit is an integrated suite of tools for measurement and analysis of program performance on computers ranging from multicore desktop systems to the nation's largest supercomputers. By using statistical sampling of timers and hardware performance counters, HPCToolkit collects accurate measurements of a program's work, resource consumption, and inefficiency and attributes them to the full calling context in which they occur. HPCToolkit works with multilingual, fully optimized applications that are statically or dynamically linked. Since HPCToolkit uses sampling, measurement has low overhead (1-5%) and scales to large parallel systems. HPCToolkit's presentation tools enable rapid analysis of a program's execution costs, inefficiency, and scaling characteristics both within and across nodes of a parallel system. HPCToolkit supports measurement and analysis of serial codes, threaded codes (e.g. pthreads, OpenMP), MPI, and hybrid (MPI+threads) parallel codes.



Read more about HPCToolkit on their [website](http://hpctoolkit.org/).





## Licensing

Distributed under a permissive license described on their [GitHub page](https://github.com/HPCToolkit/hpctoolkit/blob/master/README.License).



## The HPCToolkit module on the HPC

The HPCToolkit module can be loaded into your environment with the following command:

```bash
$ module add hpctoolkit
```

The HPCToolkit module is available on ARC3 and ARC4:

```{list-table}
:header-rows: 1
:widths: 10 20 10


* - System
  - Version
  - Command

* - ARC3
  - hpctoolkit 2016.12
  - `module add hpctoolkit/2016.12`

```
