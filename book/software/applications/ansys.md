# Ansys

Versions of Ansys Fluent and CFX are installed for Leeds researchers who have access to either their own or a departmental license. This supports the Infiniband interconnect so can be used for jobs of \>24 (for ARC3) or \>40 (for ARC4) processors in size.

Information on Ansys can be found on the [Ansys Website](http://www.ansys.com/en-GB).

## Setting up the license

The license is obtained by setting the `ANSYSLMD_LICENSE_FILE` variable. To set it in bash do:

```bash
$ export ANSYSLMD_LICENSE_FILE=<port>@<host>
$ export LSTC_LICENSE=ANSYS
```

If accessing for the first time, there is an additional step (see the next section on this page) required to choose whether you are using commercial or academic licenses. To get the values of `<port>@<host>` specific to your group/department please contact the Client IT Team via [Service Now](https://it.leeds.ac.uk/it).

To make Ansys Fluent and CFX available for use:

```bash
$ module add ansys
```

The command above loads the default version of Ansys (i.e. Ansys 17.2 on ARC3, and Ansys 2023R1 on ARC4).

To load a specific version of Ansys, specify this on the module command:

```bash
$ module add ansys/2022R1
```

### [Running Ansys Command-Line Interface](./ansys/ansyscli)

Ansys Command-Line Interface specific information can be found by clicking the link above.

### [Running Chemkin](./ansys/chemkin)

Chemkin specific information can be found by clicking the link above.

### [Running CFX](./ansys/cfx)

CFX specific information can be found by clicking the link above.

### [Running Fluent](./ansys/fluent)

Fluent specific information can be found by clicking the link above.

### [Running LS-DYNA](./ansys/lsdyna)

LS-DYNA specific information can be found by clicking the link above.

### [Using the Remote Solve Manager](./ansys/rsm)

Ansys RSM specific information can be found by clicking the link above.

### [Additional steps for using old versions of Ansys the first time](./ansys/legacy)

License set-up for old versions of Ansys on ARC.
