# Using a Terminal

We can also download and upload files to HPC using commands in a Terminal. The following steps will outline the use of two commands `scp` and `rsync` that allow for file transfer from a local machine to a remote machine or vice versa.

```{note} **MobaXTerm users** <br>
If you're using MobaXTerm's local terminal make sure you've configured it properly using the steps outlined in [Logging on](../logon.html#configuring-mobaxterm-terminal).

## Using scp

The `scp` command stands for the secure copy protocol. It uses `ssh` to connect to a remote computer and copy the file or directory to that remote host. As with all linux commands it also have a number of additonal options which you can learn more about by checking its manual page by running `man scp`.

The standard format of the `scp` command is `scp /path/to/file/to/copy /path/to/location/to/copy/to` where we specify the path to the file we want to copy and then the path to the location where we want it copied to. This looks much like a standard `cp` command but the power of `scp` comes from allowing us to specify either of these paths on another remote machine. We do this by adding at the start of the path `user@remote:` for instance to get files from my personal /nobackup i'd specify `medacola@arc4.leeds.ac.uk:/nobackup/medacola`, note the comma between the path and the remote address as this won't work without the comma. Using `scp` will prompt us for our password for both remote-access and ARC4 itself as we need to log in to the remote computer to perform the copy.

1. Uploading files and directories from local machine to remote machine

    ```bash
    # we have a file called helloworld.py we want to move to ARC4
    $ ls
    helloworld.py README.md
    # we can see the file is in my current directory
    $ scp helloworld.py medacola@arc4.leeds.ac.uk:/nobackup/medacola
    helloworld.py                                            100%    0     0.0KB/s   00:00
    ```

    Uploading directories works in the same way but requires the addition of the `scp -r` option, which specifies we copy items recursively.

    ```bash
    # say we want to transfer the directory containing helloworld.py
    $ cd ..
    $ ls
    File_transfer_folder
    $ scp -r File_transfer_folder medacola@arc4.leeds.ac.uk:/nobackup/medacola
    File_transfer_folder                                            100%    0     0.0KB/s   00:00
    ```
2. Downloading files and directories from remote machine to local machine

    ```bash
    # we have a file called results.data on ARC4 we want to download to our local machine
    # from our local machine we do the following
    $ scp medacola@arc4.leeds.ac.uk:/nobackup/medacola/Project1/results.data /home/medacola/Downloads
    results.data                                          100%    0     0.0KB/s   00:00
    ```

    Downloading directories from HPC to your local machine operates in much the same way described above.

    ```bash
    # from our local machine we do the following
    $ scp -r medacola@arc4.leeds.ac.uk:/nobackup/medacola/Project1/ /home/medacola/Downloads
    results.data                                          100%    0     0.0KB/s   00:00
    ```
## Using rsync

The `rsync` command is another file transfer command that is considered more versatile than `scp` especially for large file transfers as it enables for interrupted transfers to continue from the point at which they were interrupted rather than starting from the beginning.

There are also a number of additional options that can be used with the `rsync` command, in particular these examples will make use of the options `-avn`, where `-v` is for verbose, `-a` is for archive mode, and `-n` is for dry run which allows `rsync` to do a trial run with no changes made (often useful for checking everything works).

1. Uploading files and directories from local machine to remote machine

    ```bash
    # we have a file called helloworld.py we want to move to ARC4
    $ ls
    helloworld.py README.md
    # we can see the file is in my current directory
    $ rsync -avn helloworld.py medacola@arc4.leeds.ac.uk:/nobackup/medacola
    helloworld.py

    sent 26 bytes  received 70 bytes  4.47 bytes/sec
    total size is 0  speedup is 0.00 (DRY RUN)

    # as we're happy with the above dry run we now run the command again with -n
    $ rsync -av helloworld.py medacola@arc4.leeds.ac.uk:/nobackup/medacola
    helloworld.py

    sent 26 bytes  received 70 bytes  4.47 bytes/sec
    total size is 0  speedup is 0.00
    ```
    Uploading directories works in the exact same way as above but requires you to ensure you include a trailing `/` after the directory you wish to upload.

    ```bash
    # say we want to transfer the directory containing helloworld.py
    $ cd ..
    $ ls
    File_transfer_folder
    $ rsync -av File_transfer_folder/ medacola@arc4.leeds.ac.uk:/nobackup/medacola

    receiving incremental file list
    ./
    helloworld.py
    README.md

    sent 40 bytes  received 128 bytes  6.34 bytes/sec
    total size is 0  speedup is 0.00
    ```
2. Downloading files and directories from remote machine to local machine

    ```bash
    # we have a file called results.data on ARC4 we want to download to our local machine
    # from our local machine we do the following
    $ rsync -av medacola@arc4.leeds.ac.uk:/nobackup/medacola/Project1/results.data /home/medacola/Downloads
    results.data

    sent 26 bytes  received 70 bytes  4.47 bytes/sec
    total size is 0  speedup is 0.00
    ```

    Downloading directories from HPC to your local machine operates in much the same way described above.

    ```bash
    # from our local machine we do the following
    $ rsync -av medacola@arc4.leeds.ac.uk:/nobackup/medacola/Project1/ /home/medacola/Downloads
    receiving incremental file list
    ./
    results.data

    sent 40 bytes  received 128 bytes  6.34 bytes/sec
    total size is 0  speedup is 0.00
