# Logging on

Once you have an account you'll be able to connect to the University HPC systems using a secure shell (SSH). In this section we'll cover the various methods for connecting which differ depending on your operating system (Windows, macOS/Linux) and whether you're on or off campus.

The rest of this page covers setting your machine up with the appropriate software for connecting.
Other pages in this section are outlined below.

- [Connecting from campus](./logon/logon-campus) (wired network)
- [Connecting from off-campus](./logon/logon-off-campus) (this includes Eduroam)
- [Setting up X11 graphical forwarding for graphical applications](./logon/x11-graphics)
- [Details on host fingerprints when connecting](./logon/fingerprint-details)

## Setup

Before you can begin connecting to the University HPC systems you'll need to complete the following setup:

- Have requested and had confirmation that your HPC account has been created. You can find out more on our [Requesting a HPC Account page](./request_hpc_acct)
- Have an SSH client installed on your device. See below for different details depending on your operating system ([MacOS/Linux](#macos-linux-terminal) or [Windows](#installing-mobaxterm))

### MacOS/Linux Terminal

If you are a MacOS or Linux user you will probably have an SSH client already installed that can be used via the Terminal application on your device.

Open the Terminal application and you're ready to to connect. Next you'll need to read more about [Connecting on campus](./logon/logon-campus.html#connecting-from-linux-macos-systems) or [Connecting from off campus](./logon/logon-off-campus.html#connecting-from-linux-macos-systems) depending on your circumstances.

### Installing MobaXTerm

To get started you need to install MobaXTerm. You can do this by downloading the **Portable Home edition** [(Click here to go to the download page)](https://mobaxterm.mobatek.net/download-home-edition.html) which is a .zip file containing the software. You can follow the steps in the below video to help walkthrough getting set up.

<iframe src="https://mymedia.leeds.ac.uk/Mediasite/Play/7c25b8af4c7f43f7898efeba0ec6dd311d" width="100%" height="300" frameborder="0" marginwidth="0" marginheight="0" scrolling="auto" allowfullscreen="allowfullscreen" style="display:block;"> </iframe>

Once you've got MobaXTerm on your computer you're ready to learn about how to connect to the HPC systems. Next you'll need to read more about [Connecting on campus](./logon/logon-campus.html#connecting-from-windows) or [Connecting from off campus](./logon/logon-off-campus.html#connecting-from-windows) depending on your circumstances.

## Multiple login nodes

There are two login nodes on each HPC, login1 and login2.  They are identical
to each other, and identical to the normal node specification within the HPC
clusters.  When you typically login via any of the suggested methods, you'll be
assigned one or the other, and since they are functionally equivalent you don't
normally mind which you're given.  If you do need a specific node, you can
choose to target a specific login node, e.g. `login1.arc4.leeds.ac.uk`.

By having two login nodes, we're able to apply updates, and fix issues without
having to block access to the login nodes, and also provide additional capacity
for interactive development work.
