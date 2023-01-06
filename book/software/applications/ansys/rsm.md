# RSM

Remote Solve Manager is a tool within Ansys that lets you manage jobs running
on remote clusters.  Clearly this is of interest to people running Ansys on
their desktops that would like to submit jobs to the HPC, pulling the results
back to their desktop for review.

These instructions document a method that's been followed to make RSM work.  If
you believe it can be improved, please get in touch.

This example assumes you're using Ansys 2022R1, and using ARC4.

## Client installation

This has been tested from a system off campus, connected to the VPN, using
Ansys 2022R1 run from [AppsAnywhere](https://appsanywhere.leeds.ac.uk).  It
also depends on having a working install of [putty](https://www.putty.org) installed and available in
your path.

## Client configuration

### Generate a key

Run PuTTYgen.  Select Ed25519 as your chosen key type, and click Generate.  Set
a suitable key comment (I've used ansys-test) and set a password on the key.
Click save private key, and save it to a suitable location.  Save the public
key, and save it alongside the private key.

In the text box showing your public key, select all, and copy this to your
clipboard, as we'll need to add this to ARC4.

SSH into ARC4 as you would normally, edit `~/.ssh/authorized_keys`, and append
the string you copied to this file.

### Run Pagent

This agent process needs to be running to handle the authentication.  Once you
start it, if it's not already open, double click its icon in your task bar and
select Add Key.  Browse to where you saved the private key, and select it.
Enter the password you set when you created the key.  Close Pagent (which
leaves it running in the taskbar).

### Test this with putty

Run putty
Enter `arc4.leeds.ac.uk` as the host
Accept the host key (you can verify this against the fingerprint here)
Enter your username

If all has gone well, this connects using your key, and doesn't prompt for a
password.  At this point, edit your ~/.bashrc file and add these two lines:

```
module add ansys/2022R1
export AWP_ROOT221=$ANSYS_HOME/v221
```

For Ansys 2021R2, use:
```
module add ansys/2021R2
export AWP_ROOT212=$ANSYS_HOME/v212
```

### Set an environment variable

In order for Ansys to find your key, you appear to need to set a `KEYPATH`
environment variable.  Click Start, and type "environ".  You should be offered
"Edit environment variables for your account".  Click it.

Under "User variables" click the New button.  Put `KEYPATH` into the Variable
name box, and click Browse File.  Find the private key you created earlier.
Click OK, exiting that tool

### RSM Configuration

Start the RSM Configuration tool from the Start Menu, Ansys 2022 R1, RSM
Configuration 2022 R1.

Click the Add HPC Resource button, top left.

#### HPC Resource tab

Name: ARC4
HPC type: UGE (SGE)
Submit host: arc4.leeds.ac.uk
Shared memory parallel: smp
Distributed parallel: ib
UGE Job submission arguments: `-l h_rt=48:0:0`
Deselect Use SSH protocol for inter and intra-node communication (Linux only)

Select Use SSH or custom communication to the submit host
Enter you username for Account name

Click Apply

#### File Management tab

Select External mechanism for file transfer (SCP via SSH)
Set the Staging directory path to where you want to store these files on ARC.
For example, `/nobackup/alice/ansys-rsm`

Click Apply

You need to ensure that this directory exists, so if necessary, SSH onto ARC4
and create this directory at this point.

#### Queues

Click Import/Refresh HPC queues.
This should then show you all the queues it has found on ARC4.  Deselect the
one it has selected, and select the queue you want to use.  If you're not use,
use 40core-192G.q.

Click Apply.

You now have a Submit button on the row for 40core-192G.q.  Click this.

If everything's gone well above, you should now have a green tick under the
status, and you can review the generated report.  This is a sign that you've
managed to copy data to and from ARC4, and submit a job to the queue which has
run.
