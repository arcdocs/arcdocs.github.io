# Using smbclient

It is also possible to transfer files from your University ` M drive ` and from the shared ` N drive ` using the ` smbclient ` tool. This is a command line tool included by default on ARC that allows for file transfer experience similar to SFTP [(outlined below)](#sftp).

To connect to your ` M drive ` you are required to know the ds path to your M drive. This should follow the pattern ` \\ds.leeds.ac.uk\<group>\<groupNUMBER>\ `. Connecting to the shared N drive is possible using the folowing ds path `\\ds.leeds.ac.uk\shared\`.

Once you know the ds path to your M drive you can connect to it within the ` smbclient ` when on ARC using the command:

```bash
$ smbclient -U medacola //ds.leeds.ac.uk/****/****/ --directory medacola # **** signify removed content
Enter DS\\medacola\'s password:
Try "help" to get a list of possible commands.
smb: \\>
```

You are prompted to log in using your standard University of Leeds password and once successful the prompt switches to the clients prompt ` smb: \> `. The option ` --directory ` is used here to specify that we want to log into a specific ` M drive ` (if you don't include this you'll be logged in a level up from your person M drive and need to `cd USERNAME` into your personal M drive). You can get a list of all possible commands for this prompt by typing ` help ` and using this client to download files will download them into the directory you were in on ARC when you used the ` smbclient ` command. You can leave the ` smbclient ` anytime by typing ` exit ` to return to ARC.

To download files from your M drive onto the current directory you're in on ARC you'd do the following:

```bash
smb: \\medacola\\> get test.sh
getting file \\medacola\\test.sh of size 19 as test.sh (18.6 KiloBytes/sec) (average 18.6 KiloBytes/sec)
smb: \\medacola\\>
```

To upload a file from ARC to your M drive (In this instance on ARC I have a file called ` testfile ` in my current directory I want to transfer to my M drive) we use the following command on ARC:

```bash
$ smbclient -U medacola //ds.leeds.ac.uk/****/****/ --directory medacola -c 'put "testfile"'
putting file testfile as \\medacola\\testfile (0.0 kb/s) (average 0.0 kb/s)
```
