# GNU

The GNU compiler is a compiler system produced by the GNU Project supporting various programming languages, you can read more about it at the [GNU project web page](https://gcc.gnu.org/).

## The GNU module on the HPC

By default when users log into the HPC the [Intel compiler](./intel) is loaded. You can switch compilers to use the GNU compiler with the following command:

```bash
$ module switch intel gnu
```

There are several different versions of the GNU compiler available on ARC3 and ARC4 outlined below:

```{list-table}
:header-rows: 1
:widths: 10 20 10

* - System
  - Version
  - Command
* - ARC4
  - GNU 8.3.0
  - `module switch intel gnu/8.3.0`
* - ARC4
  - GNU 6.3.0
  - `module switch gnu/6.3.0`
* - ARC4
  - GNU 4.8.5
  - `module switch intel gnu/native`
* - ARC3
  - GNU 7.2.0
  - `module switch intel gnu/7.2.0`
* - ARC3
  - GNU 6.3.0
  - `module switch gnu/6.3.0`
* - ARC3
  - GNU 4.8.5
  - `module switch intel gnu/native`
```
