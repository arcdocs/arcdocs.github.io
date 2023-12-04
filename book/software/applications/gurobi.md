# Gurobi

The [Gurobi](https://www.gurobi.com/) mathmatical optimisation solver is
available to use on HPC. You can find the official documentation on their
[website](https://www.gurobi.com/documentation/9.1/).

## Gurobi module

To access the Gurobi solver you need to load the `gurobi` module. You can do
this with the command:

```bash
$ module add gurobi
```

This sets a number of environment variables which ensure any Gurobi APIs know
how to communicate with the solver, these include:

```bash
GUROBI_HOME
GRB_LICENSE_FILE
GUROBI_R_PKG
```

### Python setup

To use Gurobi in a python script you will need to install the Gurobipy package.
You can do this using either `pip` or `conda` with the following commands:

```bash
# installing with pip
$ pip install --user -i https://pypi.gurobi.com gurobipy

# installing with conda
$ conda install -c gurobi gurobi
```

You can then use the Gurobi Python API by adding the line `import gurobi` to
your python script and calling functions from the module.

### R setup

```{note}
The Gurobi R package is currently only tested as working with R version 4.0.3
```

To use Gurobi with the R language you need to install the R `gurobi` package
and the R package
[`slam`](https://cran.r-project.org/web/packages/slam/index.html). This is
**not** on CRAN so to install this on ARC3/ARC4 you must install the package
using one of the following methods:

```R
# install Gurobi and slam within the R console
> install.packages("slam"))
> install.packages(c(Sys.getenv("GUROBI_R_PKG"))
```

```bash
# install Gurobi and slam from the shell
$ R -e "install.packages('slam')"
$ R -e "install.packages(c('$GUROBI_R_PKG'))"
```

Once you have installed the package you can then load it within the R
environment using the line `library(gurobi)`. Once the package is loaded you
can use Gurobi R API functions to use the solver.

#### Installing R 4.0.3 via Anaconda module

You can install R 4.0.3 on the HPC by using the Anaconda module via the conda
package manager. In its simplest form you can do this with the following
commands:

```bash
# add the anaconda module
$ module add anaconda

# create a conda environment in which we install R 4.0.3 from
# the conda forge channel
$ conda create -n R403 -c conda-forge r-base=4.0.3

# to enter the environment and use R 4.0.3
$ source activate R403
```

### Matlab setup

To configure MATLAB to use the Gurobi module you will need to have loaded the
Gurobi module and within the MATLAB command window run the following commands:

```matlab
% change directory into the Gurobi matlab directory
cd(getenv("GUROBI_HOME")+"/matlab")

% run the gurobi_setup.m file to configure MATLAB
gurobi_setup

```

This adds the Gurobi MATLAB directory to your MATLAB path in your current
MATLAB session. To permanently save this directory to your MATLAB path you can
use the following commands after performing the above:

```matlab
% save your current (updated) MATLAB path in your home directory
savepath(getenv("HOME")+"/pathdef.m")

```

Once you have run `gurobi_setup` you should now have access to the Gurobi
MATLAB API and can run Gurobi specific functions.
