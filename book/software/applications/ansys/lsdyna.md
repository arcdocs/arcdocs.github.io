# LS-DYNA

Ansys LS-DYNA is the industry-leading explicit simulation software used for
applications like drop tests, impact and penetration, smashes and crashes,
occupant safety, and more.

More information about LS-DYNA can be found on the [Ansys Website](https://www.ansys.com/en-gb/products/structures/ansys-ls-dyna).

## Running LS-DYNA

```{note}
More details about using the old versions of Ansys for the first time and setting license server details can be found in the License Set-up for Legacy Ansys Modules section.
```

### Batch job examples

Guidance provided by Oasys suggests that SMP can scale to ~8 cores, and that
the Massively Parallel Processing (MPP) version should be used for larger problems.

Remember to replace `<port@host>` with a suitable value for your license.

### SMP Single Precision (4 cores)
```bash
#!/bin/bash
#$ -cwd -V
#$ -l h_rt=1:00:00
#$ -l h_vmem=4.8G
#$ -m be
#$ -pe smp 4
module add ansys/2023R1
export ANSYSLMD_LICENSE_FILE=<port@host>
export LSTC_LICENSE=ANSYS
lsdyna I=example.k ncpu=$NSLOTS
```

### SMP Double Precision (4 cores)
```bash
#!/bin/bash
#$ -cwd -V
#$ -l h_rt=1:00:00
#$ -l h_vmem=4.8G
#$ -m be
#$ -pe smp 4
module add ansys/2023R1
export ANSYSLMD_LICENSE_FILE=<port@host>
export LSTC_LICENSE=ANSYS
lsdyna -dp I=example.k ncpu=$NSLOTS
```

### MPP Single Precision (on a whole node)
```bash
#!/bin/bash
#$ -cwd -V
#$ -l h_rt=1:00:00
#$ -m be
#$ -l nodes=1
module add ansys/2023R1
export ANSYSLMD_LICENSE_FILE=<port@host>
export LSTC_LICENSE=ANSYS
lsdyna -dis -np $NSLOTS -lsdynampp I=example.k
```

### MPP Double Precision (on a whole node)
```bash
#!/bin/bash
#$ -cwd -V
#$ -l h_rt=1:00:00
#$ -m be
#$ -l nodes=1
module add ansys/2023R1
export ANSYSLMD_LICENSE_FILE=<port@host>
export LSTC_LICENSE=ANSYS
lsdyna -dis -np $NSLOTS -lsdynampp -dp I=example.k
```
