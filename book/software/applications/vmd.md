# VMD (Visual Molecular Dynamics)

## Description

VMD (Visual Molecular Dynamics) is a molecular visualization program
with 3-D graphics and built-in scripting for displaying, animating, and
analyzing large biomolecular systems. It is also an effective front end
visualisation and interaction package for simulations running on NAMD.

## Licensing

UIUC Open Source Licence:\
<http://www.ks.uiuc.edu/Research/vmd/current/LICENSE.html>

Users are required to agree to the terms and conditions of the licence
before access can be granted. For further information contact us.

The authors require that any published work or images created using VMD
include the following reference:

Humphrey, W., Dalke, A. and Schulten, K., "VMD -- Visual Molecular
Dynamics" J. Molec. Graphics 1996, 14.1, 33-38.

## Application Homepage

<http://www.ks.uiuc.edu/Research/vmd/>

## Basic Usage

VMD can be run as either an interactive or batch application.

### Interactive Mode
To run in interactive mode, first request an interactive session on one
of the backend compute nodes via the scheduler. If compute facilities
are available at the time of your request then a new terminal window
will be launched.

    qsh -cwd -V -l h_rt=01:00:00

will request an interactive shell with 1 hour of run-time (the `-l h_rt`
parameter). Once in the interactive shell, enter these two commands to\
start a graphical session:

    module add vmd
    vmd

After exiting VMD, enter the `exit` command in the interactive window to close the session.

### Batch Mode
As VMD has both a GUI and a text interface, scripts can be written to
automate functions such as loading molecules, creating representations,
making animations and analysing data. These commands can be entered in a
batch script and then submitted through the batch queue in the normal
way.

## Further Resources

**VMD tutorials:**\
<http://www.ks.uiuc.edu/Research/vmd/current/docs.html#tutorials>

**Youtube:**\
<https://www.youtube.com/watch?v=Fl3hmqCHYU4>\
<http://www.youtube.com/watch?v=CJEZydlXQp4>\
<http://www.youtube.com/watch?v=hChPzoEXK2Q>
