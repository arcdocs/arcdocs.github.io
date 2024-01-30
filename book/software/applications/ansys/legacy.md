# Additional steps for using legacy Ansys modules the first time

Before running the old versions of Ansys module (older than 19.2) for the first time, there is a per-user setting that chooses whether commercial (default) or academic licenses should be used.

**For research purposes you should normally be using the academic licenses, unless you are untertaking commercially funded research.**

**Check with your supervisor if you need clarification on this.**

You will need a SSH connection with X-forwarding enabled to configure this setting. For more information on how to connect to the ARC systems and to enable X-forwarding visit the [Logging on page](../../getting_started/logon/x11-graphics).

If you have not already done so, set the license server and port using the details provided by your supervisor:

```bash
$ export ANSYSLMD_LICENSE_FILE=<port>@<host>
```

Next, ensure that you have the Ansys module loaded for the particular version you wish to configure its licenses, e.g.:

```bash
$ module add ansys/17.1
```

For legacy Ansys versions, you need to launch the license administration interface. The simplest way to do this is to start cfx:

```bash
$ cfx5
```

and select `Tools -> ANSYS Client Licensing Utility` from the menu.

This will present you with the following window:

![Configuring a license for Ansys using the license manager.](../../../assets/wp/2016/01/ansys_license.jpg)

Select "set license preferences for user abcxyz"

In the next window, select the product you wish to configure (e.g. 12.1)

![Selecting the right license preferences.](../../../assets/wp/2016/01/ansys_license1.jpg)

In the next window that appears, select the radio button that says Use academic licenses:

![Finally select the academic license option.](../../../assets/wp/2016/01/ansys_license3.jpg)

Select **OK**, then exit the license manager.

This will configure Ansys (both Fluent and CFX) to use Academic licenses for all future use.
