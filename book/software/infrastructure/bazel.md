# Bazel

Bazel is an open-source build and test tool similar to Make, Maven, and Gradle. It uses a human-readable, high-level build language. Bazel supports projects in multiple languages and builds outputs for multiple platforms. You can read more about it at [bazel.build](https://bazel.build/).

## The Bazel module on the HPC

The Bazel module can be loaded into your environment with the following command on ARC3:

```bash
$ module add bazel
```

The Arm forge module is available only on ARC3:

```{list-table}
:header-rows: 1
:widths: 10 20 10

* - System
  - Version
  - Command
* - ARC3
  - Bazel 0.19.1
  - `module add bazel/0.19.1`
* - ARC3
  - Bazel 0.12.0
  - `module add bazel/0.12.0`
* - ARC3
  - Bazel 0.7.0
  - `module add bazel/0.7.0`
```
