# Graphics forwarding (X11) from a Terminal

```{note}
For Windows users, graphical forwarding is automatically configured by MobaXTerm when [connecting using a session](logon-campus:creating-an-ssh-session)
```

Secure shell allows X display (GUI) traffic to be tunnelled (and encrypted) through the SSH connection. Provided your local display is set up correctly, the -Y flag can be used to allow trusted X11 forwarding:

```bash
$ ssh -Y exuser@arc4.leeds.ac.uk
```

## macOS Users

The latest versions of macOS do not have an X11 client installed so this will need to be downloaded and installed seperately.
X11 for Mac can be obtained from the [XQuartz](http://www.xquartz.org/index.html).
This is a dmg file so will prompt you with the correct instructions for installation.

After installation you will need to add the following line to your `~/.ssh/config` file.

```
XAuthLocation /opt/X11/bin/xauth
```

The value for `XAuthLocation` should be the full path to the `xauth` executable installed by XQuartz. The path provided is the default location it is installed to.
