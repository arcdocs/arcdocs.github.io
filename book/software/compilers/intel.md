# Intel

The Intel compiler toolkit provides a number of compilers for different languages to help build software.

```{note}
The Intel module is loaded by default when a user logs in to ARC3 and ARC4.
```

## The Intel module on the HPC

The Intel module is loaded by default when connecting to either ARC3 or ARC4. If you find yourself in a situation where the intel compiler is not loaded you can use either the `module add` or `module switch` command to load it.

```bash
# in the situation where the gnu module is loaded
$ module switch gnu intel

# in the situation where no compilers are loaded
$ module add intel
```

There are several different versions of the Intel compiler available on ARC3 and ARC4 outlined below:

```{list-table}
:header-rows: 1
:widths: 10 20 10

* - System
  - Version
  - Command
* - ARC4
  - Intel 19.0.4 (default)
  - `module add intel/19.0.4`
* - ARC3
  - Intel 18.0.2
  - `module switch intel/17.0.1 intel/18.0.2`
* - ARC4
  - Intel 17.0.1
  - `module add intel/17.0.1`
* - ARC3
  - Intel 16.0.2
  - `module switch intel/17.0.1 intel/16.0.2`
```
