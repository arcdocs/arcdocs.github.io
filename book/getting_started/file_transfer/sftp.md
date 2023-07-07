# Using SFTP

University HPC also allows for the SSH File Transfer Protocol (SFTP) client to be used for file transfer. MobaXTerm, macOS and most Linux distributions come with an SFTP client pre-installed as part of the SSH client so you should be able to use SFTP from the get go. SFTP works in the same way as `scp` but provides for a more expanded experience transfering files (allowing you to change directory and list directory contents).

You can connect to HPC (in this example ARC4) using SFTP as follows:

```bash
# remember to use your username!
$ sftp USERNAME@arc4.leeds.ac.uk
sftp>
```

This will prompt for passwords and once logged in will change the prompt to `sftp>`. From here we can download list the current directory we're in on the remote end with `ls` and download files into the directory on our local machine where we executed the `sftp` command with the `get` command.

```bash
sftp> ls
project test_file.sh super_function.py
sftp> get test_file.sh
Fetching /home/home01/issev001/test_sub.sh to test_sub.sh
/home/home01/issev001/test_sub.sh                     100%  174     1.8KB/s   00:00
```

You can find more SFTP commands by using the `help` or `?` command within the `sftp>` prompt.

## SFTP graphical clients

If you'd rather use a graphical application to handle file transfers you can use a number of free programs that handle SFTP connections.

- [Cyberduck](https://cyberduck.io/) - macOS and Windows
- [FileZilla](https://filezilla-project.org/) - Windows, macOS and Linux

We do not provide support for these applications so please ensure you read the documentation carefully, especially around configuring for work off campus.
