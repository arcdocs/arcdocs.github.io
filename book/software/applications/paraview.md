# ParaView

## Introduction

[ParaView](http://www.paraview.org/) is a data analysis and visualisation application, developed to be able to analyse large datasets. We show here how to start the program on our facilities; however, please refer to the project documentation for details on how to use the application itself.  You can also use [X2GO](../../getting_started/x2go) when you log in and the images will render better and you will get rid of the OpenGL warnings that may appear.

Although ParaView is flexible in the way it is deployed, the simplest method of invoking it is to run these commands on a login node:

```bash
$ module add mesa paraview
$ paraview
```

This will provide the core functionality. More complicated methods are described below, offering different levels of performance. For example, the graphical interface can be run locally on a low-end workstation/laptop, while the rendering takes place in parallel on the cluster -- taking advantage of the CPU, memory and storage resources available. Although not making use of the acceleration that graphics cards provide, it can allow larger datasets that cannot fit onto a graphics card to be analysed.

## Running the ParaView graphical interface

The ParaView graphical interface can be run in several ways. Once running, the graphical interface can either be used as-is, or paired with a separate server program that can offload the rendering and storage access to one or more cluster compute nodes.

Please note that methods (1) and (2) depend on your workstation having an X server running and for you to have enabled X11 forwarding through your SSH client.

### On a cluster login node (quick start)

Recommended for very short or undemanding pieces of work. Login to the cluster and execute:

```bash
$ module add paraview
$ paraview --mesa-llvm
```

If you're not using X2Go, then depending on your own local machine, you may find that doesn't work.  Try this instead:

```bash
$ module add mesa paraview
$ paraview
```

Please note that, as they are shared between all users, it is important not to tackle very large pieces of work on the login nodes.

### On a cluster compute node

Recommended for larger pieces of work:

```
$ module add mesa paraview
$ qrsh -cwd -V -l h_rt=<hh:mm:ss> -l h_vmem=<vmem> paraview
```

In the above command, `<hh:mm:ss>` is the length of real time the program will be run for and `<vmem>` is the amount of memory required.

### On your local workstation

Recommended where the graphical interface (menu items, etc.) feels sluggish, or where the best possible performance is required.

Select a version number from the list of installed versions of the ParaView server, then download and install a copy of that version appropriate to your machine from the [ParaView website](http://www.paraview.org/). The list of installed versions is provided by the command:

```bash
$ module avail paraview-osmesa
```

Once installed and running, it can be used to connect to a ParaView server running on the cluster (see below).

## Running the ParaView server

The ParaView server does not need to be run on the same computer as the graphical interface and takes on the role of file access and graphics rendering. Warning -- there is no authentication step when connecting to a ParaView server! Between the time of start of the server and the time at which a client is connected to it, anyone logged into the cluster can connect a client to it!

Once started, it will print a line of the form:

```bash
Accepting connection(s): hostname:port
```

Please take a note of `hostname` and `port` -- they will be needed to connect the graphical interface. The hostname will include the specific login node which the server is running on.

### On a cluster login node

Recommended for very short or undemanding pieces of work. Login to the cluster and execute:

```bash
$ module add paraview-osmesa
$ pvserver --server-port=<port>
```

For `<port>`, please select a number between 10000 and 20000.

### On a cluster compute node (serial)

```
$ module add paraview-osmesa
$ qrsh -cwd -V -l h_rt=<hh:mm:ss> -l h_vmem=<vmem> pvserver --server-port=<port>
```

In the above command, `<hh:mm:ss>` is the length of real time the program will be run for and `<vmem>` is the amount of memory required. For `<port>`, please select a number between 10000 and 20000.

### On a cluster compute node (parallel)

```
$ module add paraview-osmesa
$ qrsh -cwd -V -l h_rt=<hh:mm:ss> -l nodes=<nodes> pvserver --server-port=<port>
```

In the above command, `<hh:mm:ss>` is the length of real time the program will be run for and `<nodes>` is the number of compute nodes required. Recommended to start with 1 node. For `<port>`, please select a number between 10000 and 20000.

## Connecting to a ParaView server with the graphical interface

Once a ParaView server is running, a graphical interface can connect to it. Select the menu item File-\>Connect to bring up the Choose Server Configuration box. Assuming you have not already created a suitable configuration, select Add Server for the Edit Server Configuration box.

The server configuration details depend on where the graphical interface is running (below). Once done, click Configure, leave Startup Type and Manual and click Save. Double-click on the configuration to attempt to contact the server.

### Graphical interface running on a cluster login or compute node

Please give the configuration a memorable name, and leave Server Type as Client/Server. Note that you will not be able to save the configuration unless it is given a name. The hostname from the output of pvserver should be entered into the Host field, and the number into the Port field.

### Graphical interface running on your local workstation

Please give the configuration a memorable name, leave Server Type as Client/Server, enter localhost into the Host field and 11111 into the Port field. Note that you will not be able to save the configuration unless it is given a name.

Configure your workstation's SSH client to forward local port 11111 to the hostname and port from the output of pvserver. On a Linux workstation and ParaView running somewhere on ARC4, this can be achieved via the following command:

    $ ssh -L 11111:localhost:11111 login1.arc4.leeds.ac.uk

If you need to connect to a compute node, after you have run your qrsh command, you'll get a string telling you which host it's running on e.g.:

    Accepting connection(s): d10s7b1.arc4.leeds.ac.uk:11111

You use the hostname provided there when you setup your port forward line, e.g.:

    $ ssh -L 11111:d10s7b1:11111 arc4.leeds.ac.uk
