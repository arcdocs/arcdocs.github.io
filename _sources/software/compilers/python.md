# Python

Python is an interpreted, high-level and general-purpose programming language managed by the Python Software Foundation. You can read more at [Python.org](https://www.python.org/).

```{warning}
We actively recommend users use the [anaconda](./anaconda) module to manage their python environments.
```

## Python on HPC

You can load Python modules on the HPC with the command:

```bash
$ module add python
```

A number of different versions of Python are available on our systems.

```{list-table}
:header-rows: 1
:widths: 10 20 10

* - System
  - Version
  - Command
* - ARC4
  - Python 3.7.4
  - `module add python/3.7.4`
* - ARC4
  - Python 2.7.16
  - `module add python/2.7.16`
* - ARC4
  - Python 2.7.5
  - `module add python/native`
* - ARC3
  - Python 3.6.5
  - `module add python/3.6.5`
* - ARC3
  - Python 3.6.0 (default)
  - `module add python/3.6.0`
* - ARC3
  - Python 2.7.13
  - `module add python/2.7.13`
* - ARC3
  - Python 2.7.5
  - `module add python/native`
```

### Python build modules

Adding the Python module also sets an environment variable `PYTHON_BUILD_MODULES`. This specifies the other HPC modules used to build the loaded python version and can be inspected by loading the appropriate module and running `echo $PYTHON_BUILD_MODULES`.
