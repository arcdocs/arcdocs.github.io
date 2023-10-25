# OpenFoam

OpenFOAM is an open-source set of C++ based command tools which can be used to perform Computational Fluid Dynamics simulations, it is entirely based inside the terminal and has no direct user interface. Results from the simulations can be viewed by running the command `paraFoam` to launch an external viewing application. This wiki will run through how to set up a case for running OpenFoam, as well as listing some of the basic tips on performing a simulation without error, primarily using the software available inside Mechanical Engineering.

```{note}
Versions older than v1906 may behave slightly differently, such as not requiring `source $FOAM_SRC_FILE` but use of these versions is not covered by this documentation.  Usage described in this document assumes you're using v1906 on ARC4, and may require some adjustment if using other versions, or using ARC3.

It also assumes you're using the default module environment, and haven't altered compilers being used.  If you have, please adjust accordingly.
```

## Overview of case setup

An OpenFoam case will consist of 3 separate directories:

1. The '0' time folder, this is where the files which contain the boundary and initial conditions for each of the variables being calculated are stored.
2. The 'constant' folder, this contains the transport properties ditionary, the settings for the particular RANS/LES model being used and the 'polymesh' folder which stores the blockMesh file used in the mesh creation stage.
3. The 'system' folder, which contains the control dictionary which handles the time step and solver settings and the files used to control the solver schemes and tolerances of the variables.

Before setting up any of the fields or solver settings, it is important to understand which type of solver your particular case will require. OpenFoam has several different types of solvers, a complete list of which can be found inside the user guide at: http://www.openfoam.com/documentation/

Useful information on how to install the required modules and the submission of scripts to the queuing system can be found at the bottom of this page.

## Building the computational domain

Once you have decided which solver will be best for your particular case, the first thing to do is to create the computational domain and mesh it. There are two ways to go about this, the first is to use OpenFoams own application, blockmesh and the second is to import a file meshed using an external piece of software which can then be converted for use with OpenFoam.

**BlockMesh:** In my personal experience with blockMesh, it is both time-consuming and difficult to understand when starting out with this software. The lack of any kind of visual interface means that even the simplest errors are difficult to spot without viewing your mesh in an application such as paraFoam, the way in which the blocks of the mesh are defined can be found in the userguide and are not too taxing for simple and small geometries, however when modelling more complex shapes with small details requires far more effort.

The blockMesh file is located in the 'polymesh' directory of the 'constant' folder in the openFoam case, to build the mesh, simple type the command:

```
blockMesh
```

into the terminal at the top of your case directory e.g. where you can see the 0, constant and system folders. This will automatically create your mesh which can then be viewed inside paraFoam. To check the quality of the mesh, type in the command:

```
checkMesh
```

this will give you an overview of the mesh including cell numbers, types and any errors which may have occured during the building process or which may affect the simulation.

**Importing a mesh:** There are many other mesh generation applications or priograms available to choose from, some are opensource such as gmesh whilst others are part of a consumer software package such as Fluent's ICEM. OpenFoam has a wide range of tools from which you can import meshes from many of the more well-known cfd packages available on the market. In this case, I will be following an example which can be performed using software available in Mechanical enginnering, although the process is much the same for any combination of programs.

It is important to know the exact dimensions of the geometry you wish to use for your case including where the main features lie such as inlets, outlets and which faces are solid walls. Once you know this, open a new drawing file inside a conveneient CAD program, in this case it will be solidWorks. Begin by sketching the base of your computational domain, this flat plane sketch will be extruded into a 3-dimensional shape later on. If you have inlets which do not run the full width of the domain e.g. only half of a face, or a particular shape e.g. circle, these will need to be defined separately to the outer layer of the domain. Note that for features such as circular inlets on a round face, you cannot use a hole but rather define it as a cylinder and build the rest of the profile around it until the desired shape is achieved. In order for a boundary condition to be assigned later on, each feature must be a face of the geometry.

Once the flat sketch has been completed, you can extrude each section to the required height, however you must **not** select the option to merge the extrudes together otherwise this will just create a single shape and any features such as smaller inlets or circiles will disappear entirely. From this point any more complex features such as rounding or tapering, etc can be performed until you have satisfactory representation of your geometry and all its impoertant features. Save this file as a solidworks part and close the application. Check all measurements are correct before saving the part as you will **not** be able to come back and alter them from this point on without some difficulty.

Next open ICEM which can be found in the ANSYS-13.0 directory, select file on the top taskbar and find the 'workbench readers' option for importing a file; simply attempting to open/import the file by normal means will return an empty directory. Load the model through 'workbench readers' and selecting the file type to look for as 'solidworks part'. This will then appear on the main screen inside ICEM. Tutorials on how to use ICEM can be found under the 'help' taskbar and will guide you through how to effectively mesh your model.

The guidelines to ensure that your model is ready for importing to OpenFoam are as follows:

1. Does every face have the correct name assigned to it e.g. inlet, outlet, walls, etc?
2. Has the mesh been blocked correctly?
3. Has sufficient density been selected for your simulation?
4. Have all pre-mesh checks been passed including quality histograms, etc?

If your geometry is meshed to the correct standard then it can be exported for use in OpenFoam, there is an optional step to set the boundary conditions at this stage as you can perform this task once the mesh is in OpenFoam format. but it may be easier to set up at this stage.

## Setting boundary conditions for export and changing filetype

From the taskbar in ICEM, select the 'boundary conditions' option under x and assign each feature the appropriate condition e.g. pressureOutlet, velocityInlet, solidWall, etc, these conditions will be passed through to openFoam along with the model geometry and mesh, this means that the initial conditions files in the '0' directory will be set up ready for use and should not require any alteration after this point.

To save your model ready for export, it must be in the Fluent_V6 format, solver settings and the like can remain at default and there is no need to check any additional options in the save boxes. This single model file can now be transferred into your OpenFoam case directory. To convert the file for use, type the command:

```
fluent3DMeshToFoam
```

It is a good idea at this point to run checkMesh to ensure that the process has gone smoothly and there have been no errors which may affect the simulation. This mesh can now be viewed in paraFoam.

## Control dictionary settings

When the geometry has been set up, either by importing or manual generation, the settings for the case need attention. What solver you are using for the case must be entered in the controlDict file located in the "system" folder. This will typically be the first line underneath the header, a practical example of this can be found in the tutorials section of the OpenFoam installation (tutorials can be viewed on your own local installation). Most of the other settings in the controlDict file can remain untouched however should you want to alter the timestep and how often the results of t your simulation are written to disk, the following options will be of interest:

**deltaT** -- this controls the timestep and is how much time elapses in seconds between each set of calculations performed. A lower timestep results in far better accuracy but takes longer to run, a reasonable value to begin with is 1e-04 or 1e-05. As a rule of thumb, an estimated value can be (1/Reynolds Number of the flow).

**writeControl** -- there are two settings for this option, either: runTime or timeStep. runTime means that the writeInterval is specified in seconds and the given value will be how long, in seconds, it will be between each set of results written to disk. e.g. if deltaT is set to 1e-05 and writeInterval is set to 1e-04, the results will be written to disk every 10 steps. timeStep will mean that an integer should be specified as to how many steps it will be between each recording e.g. a value of 3 will write the results every 3rd timestep.

**writeInterval** -- the steps/time between each set of results being written to disk.

There is one final option which may be relevant when moving into compiling your own or modifying solvers and models, in order to add your files to the directory so that they can be recognised by OpenFOAM, the following line must be added into the controlDict below the runTimeModifiable line:

```
libs ("libs.so")
```

where "relevant extension" leads to the correct library for the application e.g. libsuserRAS\\.so, for your own compiled RAS turbulence models.

## RAS/LES properties and transportDict

Depending upon whether you are using a RAS or LES based models, there are several files which must be present in the "constant" folder. The first of the these is general to either type of case and is called "transportDict". This contains the properties for the type of transport model relevant to the solver and the required properties of the fluid under examination. e.g. a simple example for a newtonian model requires the kinematic viscosity property in order to run:

```
transportModel Newtonian;

nu                    nu [0 2 -1 0 0 0 0] 15.345e-6
```

The type of model must be specified along with the name of the fluid property, its correct dimensionSet and a value. The dimensionSet allows OpenFOAm to determine the units of the quantity in question.

The second file will either be: RASProperties or LESProperties depending upon the type of simulation required, in essence they accomplish the same job which is to identify which model should be used with the solver along with any required coefficients not present elsewhere in the code. A typical file structure will be as follows:

### RASProperties

```
RASModel          kOmegaSST
printcoeffs          off;
turbulence          on;
```

### LESProperties

```
LESModel            Smagornisky;
printCoeffs           off;
delta                    vanDriest;
```

The option to turn off turbulence is only present in the RAS Model as this will run in a laminar state disregarding all turbulent calculations within the solver. The deltas option in LES allows the user to define which settings to use with the solver, other options include: prandtl, CubeRootVol and smoothCoeffs depending upon what is necessary for the LES simulation. Note that for other types of solvers, files representing the details of which chemical models/combustion properties may also be required for the case to be set up correctly; these are just two examples of the more common problems which may be encountered.

## fvSchemes and fvSolutions

Before the setting up of the boundary and initial conditions for each of the fields to be solved, they must be declared and assigned a solver scheme along with any required model settings. The **fvSchemes** file contains the schemes which will be used to solve the model equations and each term present in the transport equations must be assigned a scheme. Depending upon the choice, they can improve stability or the solution so it is important to choose an appropriate scheme for the term being solved. If the name of the discretisation scheme should be entered incorrectly than error will be encountered when trying to run the simulation along with a list of the available schemes.

The **fvSolution** file contains the solver scheme, preconditioner and tolerance for each field, alteration of these values can result in either better or worse convergence for the solution along with its accuracy, the tighter the tolerance, the more accurate the value but may take longer to solve or even fail to converge properly. The other set of commands present in the file deal with the controls relevant to the solver such as the relaxation factors (SIMPLE) or the number of correction steps (PISO), These controls must be set correctly for the solver to run, in many cases, the default values can be set to those found in the tutorials section for the relevant solver. A further rule of thumb is that the relaxation factors for pressure and velocity (p/u) in SIMPLE cases should total to a value of 1, frequently this is (0.3/0.7).

## Initial Fields and their boundary conditions

Once the mesh has been successfully created and the settings for the solver established along with the run-time, the initial values for all the fields being solved need to be assigned to the appropriate location on the model. All values for the initial time step will be located in the time folder marked:

```
0
```

A typical example of the kind of information required is presented below:

```
dimensions     [ 0 0 0 0 0 0 0 ];
```

This is the dimensionSet where the units of the value are input. The bar containing the zeroes represents each of the following criteria in turn:

[ Mass, Length, Time, Temperature, Quantity, Current, Luminous Intensity ] all in their respective SI units, for example, if you wanted to set the units of velocity as metres per second (m/s) the bar would be set as

```
dimensions  [ 0 1 -1 0 0 0 0 ]
```

Any unit which is not required is left as a 0. A more complete list of dimensions and their respective units can be found inside the OpenFoam user guide. It is worth noting that these exist to ensure that the values are represented in the correct magnitude/units and will cause an error if there is a mis-match between units in calculations, although it does not affect the solution numerically, it identifies that there is an inconsistensy which will have an effect. This dimension checking can be turned off in the control files located in the OpenFoam installation directory inside its control Dictionary, for a more detailed description and advice with regards to this matter, see this entry on the [OpenFoam wiki](http://openfoamwiki.net/index.php/Main_FAQ#How_does_one_turn_off_the_dimensional_checking.3F).

```
internalField uniform 0;
```

This field assigns a value to all the cells not included in any of the boundary patches (discussed next), the keyword "uniform" means all the cells will share the identical scalar or vector value placed after it. Such examples will include:

```
internalField uniform (10 0 0)
```

Typcially used when defining a velocity, this value will assign a magnitude of 10 to the x-direction and values of 0 to the y and z directions. These values only come into play during the '0' timestep, after which new values for all the internal cells and the boundary patches will be calculated. However it is still important to choose a sensible value for each variables, frequently a value of zero can be assigned (values such as kinetic energy in a stationary starting environment) as a starting point which the simulation will quickly alter in further timesteps should it be required.

```
boundaryField
{
Walls
{
type    fixedValue;
value   uniform 0;
}
}
```

Each patch within the model must be assigned an appropriate boundary condition and value, typical boundary patches will include inlet(s), outlet(s) and any solid walls on the outside of the domain. The common boundary conditions include:

**fixedValue uniform (vector/scalar)** = a single value will be assigned to all cells included within this patch but will not change with time, unlike the internalField cells. Example for velocity at the outer walls of a domain is shown above.

**zeroGradient** = no set value will be assigned to a cell and the value can change with time, typically present at an outlet or domain walls.

**fixedValue 0** = a value set at 0 which can be used to represent an impermeable surface through which no flow can occur at or through. Typically used as a setup condition for velocity at domain walls.

More complex boundary conditions including functions which vary with time (e.g. pulse inlet) and gradient scales can be implemeted either through those functions desribed in the manual/tutorial cases or through the extra utility: swak4Foam, references to which can be found [here](http://openfoamwiki.net/index.php/Contrib/swak4Foam)

It is important to note that each field which is being solved e.g. pressure, velocity, will require its own file in the '0' time directory before the simulation will run correctly. Attempting to run this with an incomplete setup will provoke an error message, frequently telling the user what is missing from the directory in question.

## Running a simulation and viewing the results

In order to begin a simulation, simply move to the directory in which all 3 directories relevant to the case are present and type the name of the solver you wish to run in the terminal e.g.

```bash
$ simpleFoam
```

and the case should begin to run, at the time specified in the controlDict, a set of results will be written to a folder with the title of that particular timestep. This will contain multiple files, each with the values of a variable for every cell in the model. To view this data, type in the command:

```bash
$ paraFoam
```

This will launch the viewing application recommended for use with OpenFoam, paraView. Pressing the green 'play' button on the taskbar will run through each set of results mapped onto the mesh, various data extraction tools can then be employed for analysis.

## General advice and starting tips

To begin with, run the tutorial cases (incompressible flow) for a few time steps and then examine the results. Attempt to alter the settings in the initial conditions for velocity/pressure to get a feel what alterations provoke which errors or how they affect the flow. Do not try and code anything from scratch for either simple model setups or your own solvers, try and find a tutorial case similar to what you require, copy and paste the 3 directories over to your own folder and alter step by step.

When coding your own solvers/models compile using wmake/wmake libso as necessary and make sure to add the appropriate library to controlDict file otherwise your files will not be recognised. The easiest to use incompressible flow solvers, depending upon requirements are: icoFoam, pisoFoam and SimpleFoam.

Some compressible solvers may not be entirely complete/have a number of errors and may require modification before correctly working, check the [CFD-online forums](http://www.cfd-online.com/Forums/openfoam/) for references/advice in
these matters.

Velocity should be set at uniform (0 0 0) for solid domain outer walls.

Values at outlets should be set at zeroGradient with the exception of pressure, a special condition Inlet/Outlet may be required to eliminate reverse flow in some cases.

Pressure should be zeroGradient except outlet when pressure gradient throughout domain is zero. Values for kinetic energy and epsilon should be allocated a very small value at walls (e.g. 1e-24) to improve stability.

A typical value of a timestep should be around 1e-04/05 seconds.

A finer mesh is a better mesh, coarse meshes can produce poor results.

Ensure that when calculating values for boundary conditions that all units you use are in SI form and are declared as such in OpenFOAM. If the units do not match the scale of your domain (e.g. m/s vs a domain in mm) the results will be inaccurate.

An initial estimate for the length scale/turbulence intensity may be required before certain boundary conditions can be correctly assigned a value.

## Running OpenFOAM

OpenFOAM is a free, open source CFD software package; this does not require a license to use.

### Setting up the environment

The openfoam installed on our systems is compiled with a gnu compiler rather than the intel one which is the default in your environment. Before you can load the openfoam module you will need to switch compilers.

```bash
$ module swap intel gnu/6.3.0
$ module add openfoam/v1906
```

The environment is not yet fully loaded. To check what you need to do you can run the command:

```bash
$ module help openfoam/v1906
```

For v1906, next run the following command to access the openFoam command line variables:

```bash
$ source $FOAM_SRC_FILE
```

### Launching on the front end

Visualisation of OpenFOAM results can be done using paraFoam at the command prompt. You need to have an openfoam case file to do this fully:

```bash
$ paraFoam
```

If you're visualising large data sets this should not be done on thelogin nodes, since this can use a considerable amount of RAM and CPU. Instead, this should be done using an interactive job with SGE.

### Using Sun Grid Engine

Sun Grid engine allows both interactive and batch jobs to be submitted during which users will have exclusive access to the resources they request.

#### Running through an interactive shell

The following will launch paraFoam interactively, displaying the full GUI:

```bash
$ qrsh -cwd -V -l h_rt=<hh:mm:ss> paraFoam
```

In the above command, `<hh:mm:ss>` is the length of real-time the shell will exist for, `-cwd` indicated the current working directory and `-V` exports the the current environment.  For example, to run paraFoam for 1 hour:

```bash
$ qrsh -cwd -V -l h_rt=1:00:00 paraFoam
```

This will run paraFoam within the terminal from which it was launched.

#### Batch Execution

To run OpenFOAM in batch-mode you first need to setup your case.

A script must then be created that will request resources from the queuing system and launch the desired OpenFOAM executables; script `runfoam.sh`:

```bash
#!/bin/bash
# Run in current working directory and import the current environment
#$ -cwd -V
# Set a 6 hour limit
#$ -l h_rt=6:00:00
# Load OpenFOAM module
module swap intel gnu/6.3.0
module add openfoam/v1906
source $FOAM_SRC_FILE
# Run actual OpenFoam commands
blockMesh
icoFoam
```

This can be submitted to the queuing system using:

```bash
$ qsub runfoam.sh
```

#### Parallel Execution

If you've configured your OpenFOAM job to be solved in parallel, you need to submit it differently. It uses OpenMPI under the hood, so this is an example of a suitable submission script:

```bash
#$ -l h_rt=00:10:00
#$ -l h_vmem=2G
#$ -l np=40
#$ -cwd -V
module swap intel gnu/6.3.0
module add openfoam/v1906
source $FOAM_SRC_FILE
mpirun interFoam -parallel
```

This will request 40 cores and exclusive access to the nodes. On ARC4, this results in a single node being allocated, with a full node's memory split between those 16 cores.

If more memory per core is required, then reduce the number of processes per node to split the available memory netween those active processes. For example,

```bash
#$ -l np=40,ppn=10
```

Will give 40 cores as before, but this time with 10 processes per node and so 4 nodes overall. The available memory per node is therefore allocated across four nodes rather than one and so four times the memory would be available per core compared to the previous example.
