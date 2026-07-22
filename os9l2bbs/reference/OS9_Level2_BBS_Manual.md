# OS-9 Level II BBS Manual

Release 3.00
Copyright (c) 1988 Keith J. Alphonso
Licensed to Alpha Software Technologies

## License Agreement

OS9L2BBS and the accompanying documentation are governed by the terms of the following
license agreement.

You, the user, are granted a paid-up license to use OS-9 Level II BBS and accompanying
documentation for an unspecified amount of time. You in no way become the owner of the package,
nor do you have the right to sell or resell the package. You are allowed to make copies of this
package for archival use only; any other copying is a violation of this agreement.

Help keep the price of software down...DON'T PIRATE!

## Disclaimer

Although this software package is designed to prevent the accidental loss of data, the deletion
of important files is still possible.

The author of this software is in no way responsible for the loss of time, money, or data as a
direct or indirect result of the use of this software package.

OS-9 Level II BBS
Release 3.00

Copyright (c) 1988 Keith J. Alphonso
Licensed to: Alpha Software Technologies
All rights reserved

## Introduction

OS9L2BBS is a set of commands and utilities that, when used together, create a sophisticated
Bulletin Board System. In this manual, a basic knowledge of OS-9 is assumed. If you do not know
how to use OS-9, or if you are confused about any references that this manual makes to OS-9, please
refer to your OS-9 manual for assistance. For the most part, you must understand how to use the OS-9
directory tree structure; how to edit, examine, and create text files; and how to use the `CMDS`
directory.

Also included in the package is a Bulletin Board disk. This disk contains a complete bulletin board
setup for you to examine and use as you please. The board can be used "as is", modified, or
completely changed for your board; we leave the creativity up to you. We do, however, suggest that
you create your own menus and board design as this gives your board a personal touch. If you have
problems, use this setup as a reference. By looking at the various files and how they interact you can
get a better idea of how the system works.

## Overview

OS9L2BBS is not a single program, but a set of commands that can be used in conjunction
with the OS-9 Level II Operating System to create a very sophisticated Bulletin Board System. To
efficiently use OS9L2BBS you should be able to use the OS-9 operating environment to your advantage.

The way a typical BBS, set up with this software, should run is as follows:

The command [`Tsmon`](#tsmon) should be run with the port name as a parameter. When [`Tsmon`](#tsmon)
recognizes a caller it will automatically run two programs, [`BBS.login`](#bbslogin) and [`Monitor`](#monitor). [`BBS.login`](#bbslogin) will first list the
`motd` file to the caller, and then prompt him to log in. [`Monitor`](#monitor) will simply monitor the carrier detect
status on the port. Once the user logs in, [`BBS.login`](#bbslogin) will run the program specified for that user in the
`BBS.users` file. Note that this can be any program, even a shell for sysop and superuser passwords.
This program can be either a single command or a script filename. If it is a script filename, the
command file should call the [`Menu`](#menu) program. The [`Menu`](#menu) program is the cornerstone of the system.
This command displays a menu text file, then waits for users to input options. When the [`Menu`](#menu)
program is finished, [`BBS.login`](#bbslogin) will list the `eotd` file to the caller and hang up.

If you do not know how to create and use script files, you should read your OS-9
documentation. A script file is, quite simply, a file that contains a list of commands to be executed one
after the other, like a program. To run a script file, all you have to do is type the name of the file. The
biggest problem that you will encounter with script files is that the file becomes the primary input
device. This means that if a program in a script file requires input it will take it from the file. This can
be rectified, however, by putting `</1` after every command in the file. This will cause it to take its
input from the terminal.

## Software Installation

To install OS-9 Level II BBS using the complete built-in set of menus, follow these steps:

### Users with Two Disk Drives

1. Format two new disks (`Format /d0`).
2. Back up the original system disks (`Backup /d0 /d1 #56k`).
3. Put the backup *OS-9 Level II BBS System* disk in drive 0.
4. Type the following:

```text
chd /d0
chx /d0/cmds
Install2
```

### Users with Three Disk Drives

1. Format three new disks (`Format /d0`).
2. Back up the original system disks (`Backup /d0 /d1 #56k`).
3. Put the backup *OS-9 Level II BBS System* disk in drive 0.
4. Type the following:

```text
chd /d0
chx /d0/cmds
Install3
```

### Users with a Hard Disk Drive

1. Format two new disks (`Format /d0`).
2. Back up the original system disks (`Backup /d0 #56k`).
3. Put the backup *OS-9 Level II BBS System* disk in drive 0.
4. Type the following:

```text
chd /d0
chx /d0/cmds
InstallH
```

**Note:** This installation procedure produces a working BBS system onto your backup disks.
It is recommended that you back up these disks regularly.

## Hardware Installation

Some hardware installation is necessary to run a bulletin board system. You should familiarize
yourself with the hardware aspect of setting up a BBS system. There are many good books on
telecommunications. The following instructions should help you get up and running as quickly as
possible.

Materials needed:

- Auto-answer modem
- RS-232 Pak
- 25-pin RS-232 cable
- Multi-Pak Interface

1. Install the RS-232 Pak in slot 1 of the Multi-Pak.

2. Connect one end of the RS-232 cable to the RS-232 Pak.

3. Connect the other end of the RS-232 cable to the modem (see the modem manual for
further instructions).

4. Connect the modem to the telephone line.

(See the modem manual for further instructions.)

The modem is now connected to the computer.

**Note:** You should make sure that the following conditions are met.

1. Make sure that the following pins are connected on the RS-232 Cable: 2, 3, 8, 20.

2. Make sure that the modem is set so that the carrier detect line reflects the status of the
phone line. (This is usually accomplished through a DIP switch on the modem or a
command sent to the modem).

3. Make sure that the modem is set so that it returns to command mode and hangs up the phone
on loss of DTR. (This is usually accomplished through a DIP switch on the modem or a
command sent to the modem.)

## File List

The following is a list of all files and commands that come on the OS9L2BBS distribution disk, and
a small description of each.

### System Setup Commands

| Name | Description |
| --- | --- |
| [`Tsmon`](#tsmon) | Autobaud terminal monitor |
| [`BBS.login`](#bbslogin) | Login program |
| [`Monitor`](#monitor) | Carrier-detect monitor |
| [`Menu`](#menu) | Menu program |
| [`New_user`](#new_user) | Program to collect new-user information |
| [`BBS.build`](#bbsbuild) | Simple file creator |
| [`BBS.list`](#bbslist) | Simple file-list command |
| [`BBS.validate`](#bbsvalidate) | New-user validation program |
| [`BBS.form`](#bbsform) | Creates user forms |
| [`BBS.stat`](#bbsstat) | Views user statistics |
| [`At`](#at) | Event-scheduler program |
| [`Prompt`](#prompt) | Creates user prompts |
| [`ViewBBS`](#viewbbs) | Allows the BBS to be viewed while running |
| [`Ansicode`](#ansicode) | ANSI graphics-code generator |
| [`AnsiEd`](#ansied) | ANSI graphics editor |
| [`AnsiFilt`](#ansifilt) | ANSI graphics-to-OS-9 filter |
| [`Suser`](#suser) | Sets the user number |
| [`pause`](#pause) | Waits for a keypress |

### Chat Mode Commands

| Name | Description |
| --- | --- |
| [`BBS.chat`](#bbschat) | Chat request |
| [`Answer`](#answer) | Answers a chat request |

### Conference Mode Commands

| Name | Description |
| --- | --- |
| [`BBS.who`](#bbswho) | Shows who is currently online |
| [`BBS.page`](#bbspage) | Pages another user |
| [`BBS.conf`](#bbsconf) | Enters conference mode |
| [`BBS.conf.who`](#bbsconfwho) | Shows who is in conference mode |

### Message Retrieval Commands

| Name | Description |
| --- | --- |
| [`BBS.create`](#bbscreate) | Creates a message base |
| [`BBS.post`](#bbspost) | Posts a message |
| [`BBS.convert`](#bbsconvert) | Converts messages from release 2.0 |
| [`BBS.delete`](#bbsdelete) | Deletes a message |
| [`BBS.pack`](#bbspack) | Packs a message base |
| [`BBS.read`](#bbsread) | Reads a message |
| [`BBS.reply`](#bbsreply) | Replies to a message |
| [`BBS.forward`](#bbsforward) | Reads messages forward from a selected message |
| [`BBS.new`](#bbsnew) | Reads new messages |
| [`BBS.scan`](#bbsscan) | Scans message headers |
| [`BBS.search`](#bbssearch) | Searches messages |

### Mail Retrieval Commands

| Name | Description |
| --- | --- |
| [`BBS.mail.post`](#bbsmailpost) | Posts mail |
| [`BBS.mail.check`](#bbsmailcheck) | Checks mail status |
| [`BBS.mail.read`](#bbsmailread) | Reads mail |
| [`BBS.mail.readD`](#bbsmailreadd) | Reads and deletes mail |
| [`BBS.mail.delete`](#bbsmaildelete) | Deletes mail |

### File Retrieval Commands

| Name | Description |
| --- | --- |
| [`BBS.upload`](#bbsupload) | Prompts for an upload protocol |
| [`Uloada`](#uloada) | Uploads using ASCII |
| [`Uloadx`](#uloadx) | Uploads using XMODEM |
| [`Uloadxc`](#uloadxc) | Uploads using XMODEM CRC |
| [`Uloady`](#uloady) | Uploads using YMODEM |
| [`BBS.download`](#bbsdownload) | Prompts for a download protocol |
| [`Dloada`](#dloada) | Downloads using ASCII |
| [`Dloadx`](#dloadx) | Downloads using XMODEM |
| [`Dloadxc`](#dloadxc) | Downloads using XMODEM CRC |
| [`Dloady`](#dloady) | Downloads using YMODEM |
| [`DLD.validate`](#dldvalidate) | Validates new uploads |
| [`DLD.add`](#dldadd) | Adds new files without uploading them |
| [`DLD.unvalidate`](#dldunvalidate) | Unvalidates old uploads |
| [`DLD.search`](#dldsearch) | Searches for a download |
| [`DLD.list`](#dldlist) | Lists downloads |
| [`DLD.read`](#dldread) | Reads file information |

These commands are further explained in the following pages.

## System Setup Commands

### `Tsmon`

**Syntax:** `Tsmon [-m] <port>`

[`Tsmon`](#tsmon) is the first command run to start the execution of the board. The [`Tsmon`](#tsmon) command
monitors a port (such as `/t2`) for an `<enter>` keypress. If a character is received that isn't an `<enter>`,
[`Tsmon`](#tsmon) assumes that the baud is set wrong and switches baud rates. It then waits again for an
`<enter>`. [`Tsmon`](#tsmon) will continue cycling like this through baud rates until it gets an `<enter>` keypress.
The baud rates cycle as follows:

1. 1200 baud
2. 2400 baud
3. 300 baud
4. 1200 baud

Once [`Tsmon`](#tsmon) receives an `<enter>` character it sends a message stating what baud, parity, and stop
bits are operating. [`Tsmon`](#tsmon) then automatically runs two commands, [`BBS.login`](#bbslogin) and [`Monitor`](#monitor). If the `-m` option
is specified, the [`Monitor`](#monitor) command will not be executed. These commands are explained further in the
section for that command. [`Tsmon`](#tsmon) should be run as a background task as follows:

```text
Tsmon /t2 &
```

That way the board runs completely in the background. If [`Tsmon`](#tsmon) is run in the foreground, it will not
allow you to use that window any longer. For this reason it is suggested that you run [`Tsmon`](#tsmon) in the
background.

You can run the board in a window for debugging. To do this enter the following commands:

```text
iniz /w7
display 1 >/w7
Tsmon -m /w7 &
```

**Note:** I used `/w7` here because it automatically defaults to 80 columns. You can use any window you
like. Once you have run this command, simply press `<CLEAR>` until you see the window, then press
`<ENTER>`. The board should respond with `1200 baud 8 bits no parity`. You can now access the
board as if you were online.

Another feature of [`Tsmon`](#tsmon) is its modem setup feature. With this feature you can have [`Tsmon`](#tsmon)
reset your modem every time someone logs off. When [`Tsmon`](#tsmon) is first run, and every time a user is
logged off, it will look for a file called `modem.set` in the current working directory. If the file does not
exist, this feature is ignored. If the file does exist, [`Tsmon`](#tsmon) sends whatever information is in that file to
the modem AT THE BAUD RATE THE PORT WAS XMODED TO. This means that if you use [`Tsmon`](#tsmon)
you MUST Xmode your port to the modem's baud rate. This file should contain any commands that
you need to send to your modem to have it initialized. My `modem.set` looks as follows:

```text
ATS0=1
```

This is because I don't always run the BBS, but when I do, it automatically sets it to answer on the first
ring.

**Note:** 2400 baud users MUST have this file and must have at least the text `AT` in the file. This is due
to the fact that 2400 baud modems will not automatically jump to their highest rate.

### `BBS.login`

**Syntax:** `BBS.login`

The [`BBS.login`](#bbslogin) program allows you to maintain a list of users and their passwords and user numbers.
This program is automatically run by [`Tsmon`](#tsmon) and need not be run by the sysop. This is the program
that prompts the person logging in for his name and password.

The [`BBS.login`](#bbslogin) program requires several files to run. The first file it looks for is `motd`. This file is
listed to the user's screen immediately after he calls. It should be used as a welcome message, and
should provide any instructions necessary for logging in. A default `motd` file is provided, but it is
suggested that you create your own. You can use any editor to create this file. This file should be
in the same directory as [`Tsmon`](#tsmon) is run from, usually `/dd/bbs`.

The [`BBS.login`](#bbslogin) program next looks for a file called `BBS.users`. This file contains the name, password,
program to run, and user number for every user of the bulletin board. This file is a simple text file that
can be created and edited by any editor. The format of each line in this file is as follows:

```text
user name,password,program,number[,time]
```

Here, user name is the user's name, password is the user's password, program is the name of a
program or script file to run, number is a number that you assign to each user (you should assign
yourself as sysop (user 0)), and finally the time (which is optional) is the time the user is allowed on the
system PER DAY. If this parameter is omitted or is set to 0, the user will not have a time limit and can
access the system as long as he wants.

Note that the program to run can be a script file. I would suggest this as you could have the
file list special messages and bulletins that you create, read and check mail, and then run the [`Menu`](#menu)
program. Here is a sample command file:

```text
-x
BBS.list bulletins
chd mailroom
BBS.mail.read
chd ..
BBS.list sysop_message
Menu BBS.menu BBS.cmds </1
```

This command file would list the file called `bulletins`, read the mail, list a file called `sysop_message`
and run the [`Menu`](#menu) program. The `-x` option stops the board from hanging up if an error occurs.

Another file that [`BBS.login`](#bbslogin) looks for is a file called `Userlog`. If the file does not exist, [`BBS.login`](#bbslogin) creates
it and records the user's name and login time. This allows you to maintain a list of all callers
and the time they called.
[`BBS.login`](#bbslogin) also prints the person's name and the time they called on the printer (if connected).
The last file that [`BBS.login`](#bbslogin) looks for is a file called `eotd`. This file is displayed after the command that
was executed is finished. In the case of the [`Menu`](#menu) program, this happens when a specific option (that
you define) is pressed. This file should contain an appropriate sign-off message of your choosing.

Still another file that [`BBS.login`](#bbslogin) looks for is `/dd/bbs/BBS.userstats`. If this file does not exist, [`BBS.login`](#bbslogin)
will create it. If it does exist, [`BBS.login`](#bbslogin) will look for the current user's entry in the file. If the current user's
entry is not found, an entry is created for him. Note that this means that you NEVER have to modify
the userstats file; it will be maintained automatically. [`BBS.login`](#bbslogin) will then store the time and run the
program you specified. When you exit from [`Menu`](#menu), [`BBS.login`](#bbslogin) will update the amount of time remaining
for the next login. This allows users to only access the board for a preset amount of time each day.
If a time of 0 is given, or no time at all is given, the user will not have a time limit and can access the
board as long as he likes. Notice that this is compatible with release 2.0 of the BBS, so you do not
have to change your `BBS.users` file from release 2.0 if you don't want to give time limits.

### `Monitor`

**Syntax:** `Monitor`

The [`Monitor`](#monitor) program will monitor the carrier detect status of the port. If the carrier detect is lost
the program will kill all processes started by its parent process and any of its children. This means
that if someone hangs up, any processes started by that person will be killed.

**Note:** This program is automatically run by [`Tsmon`](#tsmon) and need not be run by the system operator. This
program is also very hardware-dependent. It works with the Deluxe RS-232 Pak from Radio Shack as
well as many *compatible* paks (including the Orion Technologies TELEpak).

### `Menu`

**Syntax:** `Menu <menu file> <command file>`

The [`Menu`](#menu) command allows the sysop to create his own menus to be used by the users of his
bulletin board. This command is the cornerstone of the whole BBS system. It allows the sysop to
define what keys will be pressed to execute what commands. It also allows the sysop to define all of
his own menus. The menu is a text file that is *echoed* or sent to the user's screen. This file can even
contain special graphics characters, such as the popular ANSI standard.

The [`Menu`](#menu) command requires two files as follows:

A menu file, which is simply a text file that will be listed to the user's screen. This file can be created
using any editor (`edit`, `Scred`, `Tsedit`, [`BBS.build`](#bbsbuild), or [`AnsiEd`](#ansied) for ANSI graphics). Control codes can also
be inserted into this file for special effects. The control codes will appear as dots when you type them
in. To clear the screen the control code is `<CNTRL><L>`. To ring the bell the code is
`<CNTRL><G>`. You can experiment to find other special codes.
Example menu file:

```text
<CNTRL><L>
Files menu
L> List files
U> Upload a file
D> Download a file
```

The next file required is a commands file, which is a text file that instructs the [`Menu`](#menu) program how
to use options. Each line in this file contains either a single letter option followed by the OS-9
command line to execute, or a user priority condition followed by a single letter option and the
OS-9 command line to execute. The user priority condition is in the form `<#####`, `>#####`, or
`=#####`, where `#####` is a five-digit user number. The user number MUST be five digits. If the
number is less than five digits, it must be padded with zeros. The `<`, `>`, and `=` symbols stand for less than,
greater than, and equal to respectively. If the user priority is specified, the [`Menu`](#menu) program first checks
that the user can access the option, then if the user's number meets the specified condition (`<`, `>`, or
`=`), he is allowed to execute the option.

Anything that is legal on a command line is legal on these lines, including semicolons, memory
modifiers, I/O redirection, etc. On the last line of this file you should put a slash (`/`) and the prompt that
you want to use.

Example commands file:

```text
L dir downloads
u Uloadx
d Dloadx
#00000 s shell
>01000 v DLD.validate
/Enter your choice:
```

The command file has some special commands that can be used instead of regular commands.
These special commands are:

```text
chd <dirname>
chx <dirname>
chm <menu file> <command file>
ex
```

These commands must be on a line by themselves; they cannot be executed with any other
commands.

The change directory command (`chd`) changes to the specified directory, reads in the new menu
file (in the new directory) and this becomes the new menu. This allows you to have sub-menus simply
by putting them in sub-directories and giving them the same name. If you look on the sample disk you
will see that this is how the menus are set up. Changing directories therefore changes menus as well.
With this system you can easily remember how your system is set up by looking at how your
directories are set up.

The change execution directory command (`chx`) will change the current execution directory and
redisplay the current menu.

The change menu command (`chm`) will change the menu file names. This allows you to have
more than one menu in each directory.

The exit command (`ex`) exits from the [`Menu`](#menu) program and returns to the calling program. If the
calling program was [`BBS.login`](#bbslogin), the user will be disconnected after receiving the `eotd` file.

Example special commands:

```text
c chd coco
o chd os9
=00000 s chd SYSTEM
m chd /dd/bbs
8 chm BBS.menu_80_col BBS.cmds
4 chm BBS.menu_40_col BBS.cmds
g ex
/Enter Your Choice?
```

Another feature of the [`Menu`](#menu) program is timekeeping. The [`Menu`](#menu) program, when it is first run,
checks the time remaining. It then keeps track of this time and will log the user off when his time is
up. The time remaining is set up by the [`BBS.login`](#bbslogin) command using the value given in the `BBS.users` file
(see [`BBS.login`](#bbslogin) for more information).

### `BBS.build`

**Syntax:** `BBS.build <filename>`

The [`BBS.build`](#bbsbuild) command is a simple file creator/editor similar to the editor used for posting
messages. This editor is provided to the sysop to add his own features to the board. The [`BBS.build`](#bbsbuild)
command will not edit an old file; it will only create a new one.

One example use for this command is to create feedback to the sysop on his printer. To do this,
simply have `f BBS.build /p` as a menu option. This will allow someone to type data directly onto the
printer.

### `BBS.list`

**Syntax:** `BBS.list <filename>`

The [`BBS.list`](#bbslist) command is a simple file list command similar to the `List` command that comes
with OS-9. The important difference is that the person online can press the `<SPACE>` bar and abort
the listing. This allows a person to cancel a long listing.

### `BBS.validate`

**Syntax:** `BBS.validate`

The [`BBS.validate`](#bbsvalidate) command allows you to easily add entries to your `BBS.users` file. This
command will prompt you for all necessary information for a new user, including his alias (to update
the `/dd/bbs/BBS.alias` file). This command can be used as an alternative to using a text editor to add
new users.

### `BBS.form`

**Syntax:** `BBS.form <formpath> <pathname>`

The [`BBS.form`](#bbsform) command allows you to design your own forms for users to fill out. This
command is useful for getting information from your system users. It can be used to get the necessary
information from new users. Note that this is used in the [`New_user`](#new_user) menu for that purpose. The first
file, the `<formpath>`, is a text file that describes the format of the form. You create this file with any
text editor. All you have to do is enter one question on each line of this file. This question will be sent
to the user's terminal and he will be allowed to type a response. The question asked and the user's
response are then sent to `<pathname>`, the second parameter. Note that this can be `/p` as well as
a file. If the specified file does not exist, it is created; if it does exist, it is appended to.

### `BBS.stat`

**Syntax:** `BBS.stat`

The [`BBS.stat`](#bbsstat) command allows users to view their user statistics. This command outputs each
user's statistics in an easily readable format. The user statistics are maintained in a file called
`/dd/bbs/BBS.userstats` and this file must exist for the [`BBS.stat`](#bbsstat) command to work. This file does NOT
need to be created by you. It will be automatically created by [`BBS.login`](#bbslogin). This file will be updated by the
BBS commands. The following statistics are maintained: last logged in, times logged in, number of
files uploaded and downloaded, the number of messages left and read, and the amount of time
remaining for this login.

### `At`

**Syntax:** `At yy/mm/dd hh:mm <command line>`

The [`At`](#at) command allows you to execute commands at a given date and time. The
`<command line>` parameter is any valid OS-9 command line (that you would type at the `OS9:` prompt).
The date is specified in OS-9 format, year/month/day hour:minute (note that the time uses the 24-hour
clock). If a date of 00/00/00 is specified, the event will occur EVERY day at the specified time. Note
that this is useful for things like automatically deleting the daily userlog at 12:00 midnight every night
(whether you're there or not). It is also useful for packing message bases late at night when the BBS
traffic is low.

Example:

```text
At 00/00/00 00:00 del /dd/bbs/userlog
```

**Note:** The time 00:00 is midnight in 24-hour time.

### `Prompt`

**Syntax:** `Prompt <command> 'Parameter Prompt' <other parameters>`

The [`Prompt`](#prompt) command is a very powerful command that allows you to create prompts for your
BBS. You can prompt the user for parameters to be passed to a command. For instance, suppose
you wanted a co-sysop menu to include the `DIR` command, but didn't want to give shell access to the
co-sysop. You could implement this in the menu commands file as follows:

```text
d prompt dir 'Enter sig name:*/files
```

This would list the files directory in the SIG specified. This command is provided as a convenience to
the sysop and can increase the power of the BBS's menus.

### `ViewBBS`

**Syntax:** `ViewBBS`

The [`ViewBBS`](#viewbbs) command allows you to view the board while it is running IF YOU HAVE
INSTALLED THE PROPER DRIVERS! In order for this command to work, you MUST have installed the
`/Td` device as well as the `/Wb` window (included). This command will effectively do a `<CLEAR>` to
`/Wb`. See the section on the `/Td` driver for more information.

### `Ansicode`

**Syntax:** `Ansicode <codes>`

The [`Ansicode`](#ansicode) command allows you to send ANSI code sequences through the BBS. ANSI
codes are used to control colors, etc., on ANSI terminals. Some of the more important codes are listed
below.

| Code | Meaning | Code | Meaning |
| --- | --- | --- | --- |
| `01m` | Boldface on | `04m` | Underline on |
| `05m` | Blink on | `07m` | Reverse video on |
| `08m` | Invisible on | `00m` | Reset graphics |
| `30m` | Foreground black | `40m` | Background black |
| `31m` | Foreground red | `41m` | Background red |
| `32m` | Foreground green | `42m` | Background green |
| `33m` | Foreground yellow | `43m` | Background yellow |
| `34m` | Foreground blue | `44m` | Background blue |
| `35m` | Foreground magenta | `45m` | Background magenta |
| `36m` | Foreground cyan | `46m` | Background cyan |
| `37m` | Foreground white | `47m` | Background white |

Example:

```text
Ansicode 33;44m
```

Notice how the codes can be stacked; this command would set the foreground to yellow and the
background to blue.

### `AnsiFilt`

**Syntax:** `AnsiFilt <inputfile> or <command> ! AnsiFilt`

[`AnsiFilt`](#ansifilt) is a filter that converts ANSI codes into their OS-9 screen code equivalents. You can
use it either by redirecting its input or by piping the output of
another command through it. This command is useful for testing the BBS's menus.

Examples:

```text
AnsiFilt <BBS.menu_am
Ansicode 33;44m ! AnsiFilt
```

Note that the second example allows you to check the results of the [`Ansicode`](#ansicode) command so that you
can see how it will look.

### `AnsiEd`

**Syntax:** `AnsiEd [<inputfile>] [<outputfile>]`

[`AnsiEd`](#ansied) is an ANSI graphics editor that allows you to create great-looking screens and menus
with ANSI graphics. A complete description of how [`AnsiEd`](#ansied) works appears later
in the [ANSI Editor](#ansi-editor) section of this manual.

### `Suser`

**Syntax:** `Suser <number> [<command line>]`

[`Suser`](#suser) allows you to change the current user number. This allows you to check for mail, etc.,
without being user 0. Note that this command can only be run by the sysop (user 0). If no
command line is specified, a shell will be started.

### `New_user`

**Syntax:** `New_user`

[`New_user`](#new_user) collects a prospective user's name, city, state, telephone number, requested alias,
and requested password. It displays the completed application for confirmation and saves it for the sysop
to validate later.

### `pause`

**Syntax:** `pause ["<message>"]`

[`pause`](#pause) displays the supplied message, or `Press any key to continue...` when no message is
given, and waits for one keypress. Scripts should redirect standard input to the caller's terminal.

## Chat Mode Commands

### `BBS.chat`

**Syntax:** `BBS.chat`

The [`BBS.chat`](#bbschat) command allows a person on a remote terminal to communicate with someone
(usually the sysop) at the local BBS site. The [`BBS.chat`](#bbschat) command will cause a bell to ring on the local
BBS's terminal. If no one answers the bell (see the [`Answer`](#answer) command), the person issuing the chat
request will be informed that the sysop is not available.

**Note:** The [`BBS.chat`](#bbschat) command requires that the local terminal have at least one unused window available
(this is needed to ring the bell).

### `Answer`

**Syntax:** `Answer`

The [`Answer`](#answer) command is used to answer a corresponding chat request. Simply enter [`Answer`](#answer), and
you will be able to communicate with the person online. When you are finished chatting, you can
terminate the chat session by pressing `<ALT><X>`. The person issuing the chat request cannot
terminate the chat. If no one answers the chat request within 10 rings, the chat is terminated.

## Conference Mode Commands

### `BBS.who`

**Syntax:** `BBS.who`

The [`BBS.who`](#bbswho) command gives a list of the users currently online. This command can be used
in a menu to allow users online to see who is currently on the system. This command can be used
together with [`BBS.page`](#bbspage) to initiate conference modes. This command is also useful to the sysop when
he wants to know who is online.

**Note:** This command requires that the file `/dd/bbs/BBS.alias` exist.

### `BBS.page`

**Syntax:** `BBS.page`

The [`BBS.page`](#bbspage) command allows a user to send a brief one-line message to another user that
is logged in at the same time (but on a different port). The command prompts the user for the person
to page. The program then checks to see if that user is currently online. If that user is online, he will
get the message at the next available time. Note that this may take a few seconds. The user initiating
the page will be informed to wait.

**Note:** This command requires that the file `/dd/bbs/BBS.alias` exist.

### `BBS.conf`

**Syntax:** `BBS.conf`

[`BBS.conf`](#bbsconf) is a system command used to create a *conference mode*. When [`BBS.conf`](#bbsconf) is run
by two separate people at the same time, each user can see what the other types. This is similar to
the conference mode on DELPHI and other multi-user systems. Once the program is run, you will be
prompted for a handle. This handle will be displayed before each line of text as you type. If you press
`<CTRL><X>` while in conference mode, a list of users currently in conference will be displayed. If you
press `<CTRL><Z>`, conference mode will be exited. Each user in conference mode should have a
different user number. If more than one person is in conference with the same number, only one may
see the messages.

**Note:** This command requires that the file `Conf.dat` be in the commands directory and that the file
`/dd/bbs/BBS.alias` exist.

### `BBS.conf.who`

**Syntax:** `BBS.conf.who`

[`BBS.conf.who`](#bbsconfwho) is a system command that displays a list of the users currently in conference
mode (running [`BBS.conf`](#bbsconf)). This allows users to see who is in conference without actually entering the
conference mode.

**Note:** This command requires that the file `/dd/bbs/BBS.alias` exist.

## Message Retrieval Commands

### `BBS.create`

**Syntax:** `BBS.create`

The [`BBS.create`](#bbscreate) command creates the files necessary to start a message base. By executing this
command, you create a message base with no messages. If a message base already exists, [`BBS.create`](#bbscreate)
will return an error. This command should be run in each subdirectory that is intended to be used for
a message base.

### `BBS.post`

**Syntax:** `BBS.post`

The [`BBS.post`](#bbspost) command will add a new message to an existing message base in the
current directory (see [`BBS.create`](#bbscreate)). The person issuing this command (usually a BBS user) will be
prompted for a message subject. After the subject of the message is entered, the user will be
prompted for whom the message is addressed. Note that the user can address a message to all
users by simply pressing `<ENTER>` at this prompt. After entering whom the message is addressed to,
the user will be allowed up to 100 lines to enter his message. The post facility uses a simple,
user-friendly editor for posting this message. This editor will word-wrap at the end of each line.

**Note:** This message base is not completely compatible with release 2.0. Release 2.0 does not allow
a message to be addressed to a specific user. A utility for converting message bases is provided with
the board. This utility ([`BBS.convert`](#bbsconvert)) will convert a release 2.0-compatible message base to a release
3.0-compatible message base. See the [`BBS.convert`](#bbsconvert) command for more information.

**Note:** This command requires that the file `/dd/bbs/BBS.alias` exist with a list of user names or aliases
and their numbers.

Example:

```text
Sysop,0
The main man,1
Joe Smoe,2
```

This allows messages to be posted by alias names instead of real names. If you wish to use the real
name as the alias, that's fine.

**Note:** This command also updates the `/dd/bbs/BBS.userstats` file.

### `BBS.convert`

**Syntax:** `BBS.convert [<dirname>]`

The [`BBS.convert`](#bbsconvert) utility is specifically for those people who own release 2.0 of this system and
are upgrading to release 3.0. If you do not own release 2.0 of this system, disregard this command.
If you do own release 2.0 of this system, you should update your message bases. Note that it is not
ABSOLUTELY necessary, but if you don't, all previously posted messages will be addressed to random
users (possibly unknown). When you run [`BBS.convert`](#bbsconvert) it addresses all previously posted messages to
`All Users`. Here are some examples:

```text
BBS.convert /dd/bbs/sigs/coco
```

**Note:** The `<dirname>` parameter is optional; the current directory is assumed.

### `BBS.delete`

**Syntax:** `BBS.delete`

The [`BBS.delete`](#bbsdelete) command allows someone to delete his own messages. The sysop is allowed to
delete anyone's messages. If someone tries to delete someone else's message he will be given the
message `You cannot delete that message.` When the [`BBS.delete`](#bbsdelete) command is issued, it gives the total
number of messages and asks which message number to delete. If that person owns the message
or is the sysop (user 0), then the message will be deleted.

**Note:** When a message is deleted, it still occupies space until it is packed (see the [`BBS.pack`](#bbspack)
command).

### `BBS.pack`

**Syntax:** `BBS.pack <dirname>`

The [`BBS.pack`](#bbspack) command removes all deleted messages from the specified message base. When
a message is deleted, it is really only flagged for deletion. To be completely removed, the message
base must be packed. This is done in order to save time for the BBS user. Packing a large message base
requires a lot of time; I therefore recommend that packing be done during
off-hours (early in the morning, late at night, etc.) to reduce user inconvenience. If the directory
name parameter is omitted, the message base in the current directory (if any) will be packed.

**Note:** A message base should be packed when it has a significant amount of deleted messages or
when more disk space is needed.

### `BBS.read`

**Syntax:** `BBS.read`

The [`BBS.read`](#bbsread) command allows someone to read messages previously posted (see the [`BBS.post`](#bbspost)
command). The [`BBS.read`](#bbsread) command will tell the user how many current messages exist, what his
current message number is, and prompt him for which message number to read. The user can also specify
that he wants to read the next message, the previous message, or the next thread message (the next message with
the same subject as the current message) or reply to the current message. The message will then be
listed. The user can then continue entering message numbers, or enter `q` to quit.

**Note:** This command also updates the `/dd/bbs/BBS.userstats` file.

**Note:** This command requires the `/dd/bbs/BBS.alias` file to exist.

### `BBS.reply`

**Syntax:** `BBS.reply`

[`BBS.reply`](#bbsreply) composes a response to the current message and keeps the reply in the same
thread. It is invoked by [`BBS.read`](#bbsread), uses the original subject, and updates the message base
and the caller's statistics.

### `BBS.forward`

**Syntax:** `BBS.forward`

The [`BBS.forward`](#bbsforward) command works much the same as the [`BBS.read`](#bbsread) command, except that it reads
all messages following a certain message number.

**Note:** This command also updates the `/dd/bbs/BBS.userstats` file.

**Note:** This command requires the `/dd/bbs/BBS.alias` file to exist.

### `BBS.new`

**Syntax:** `BBS.new`

The [`BBS.new`](#bbsnew) command automatically reads all messages with a number higher than the last
message read by that user. The [`BBS.read`](#bbsread), [`BBS.forward`](#bbsforward), and [`BBS.new`](#bbsnew) commands keep track of the
last message read by each user. The [`BBS.new`](#bbsnew) command can then read any message not previously
read.

**Note:** This command also updates the `/dd/bbs/BBS.userstats` file.

**Note:** This command requires the `/dd/bbs/BBS.alias` file to exist.

### `BBS.scan`

**Syntax:** `BBS.scan`

The [`BBS.scan`](#bbsscan) command is used to read the headers of all messages in the message base. When
the [`BBS.scan`](#bbsscan) command is executed it tells the user how many messages exist. It then prompts for the
first message number to scan. The message number, person who posted the message, date, and
message subject are then displayed for those messages with a number higher than the number
entered.

### `BBS.search`

**Syntax:** `BBS.search`

The [`BBS.search`](#bbssearch) command is used to search for a certain message subject. When the
[`BBS.search`](#bbssearch) command is executed, it prompts the user for the text to search for. The text is then
searched for in the message subjects. A listing of what message subjects contain that text is then
displayed.

The text does not have to be the entire message subject; it can be only a part. For example,
if you wanted to find all messages dealing with modems, you could enter `modem` as the text to find.
All message subjects containing the word `modem` would then be found.

## Mail Retrieval Commands

### `BBS.mail.post`

**Syntax:** `BBS.mail.post`

The [`BBS.mail.post`](#bbsmailpost) command allows a BBS user to send mail to another BBS user. When the
command is invoked, it prompts for the name of the person to whom the mail should be sent. If
the person's name entered is found in the `/dd/bbs/BBS.alias` file, the user is then prompted to enter
the message subject. Once this is entered the user is given a maximum of 100 lines to leave his
message. The [`BBS.mail.post`](#bbsmailpost) command uses the same user-friendly editor as [`BBS.post`](#bbspost) and [`BBS.build`](#bbsbuild).
Once the message is entered, the mail is stored. When the receiver asks to read mail, he will
receive the message. Mail is private; therefore, only the person receiving the mail can read his mail.
The sysop can, however, list the entire mail file if he pleases. The sysop can also use the [`Suser`](#suser)
command to set the user number and check a specific user's mail.

**Note:** [`BBS.mail.post`](#bbsmailpost) requires `/dd/bbs/BBS.alias`, which contains a list of all users' names or aliases
and their user numbers. Example:

```text
Sysop,0
The main man,1
Joe schmoe,2
```

This allows alias names to be used instead of regular names, but still allows the sysop to maintain a list
of real names.

### `BBS.mail.check`

**Syntax:** `BBS.mail.check`

The [`BBS.mail.check`](#bbsmailcheck) command allows a BBS user to see if the mail he sent has been received.

The [`BBS.mail.check`](#bbsmailcheck) command immediately tells the user what messages have not yet been received.
A user can only check the mail that he has sent.

### `BBS.mail.read`

**Syntax:** `BBS.mail.read`

The [`BBS.mail.read`](#bbsmailread) command allows a BBS user to read any mail that has been sent to him. The
message will be listed along with who sent it. The user will then be asked if he wishes to reread the
message (in case it scrolled off his screen). If not, the command will continue with the next message,
and so on.

**Note:** The messages will not be deleted with this command (see [`BBS.mail.delete`](#bbsmaildelete) and [`BBS.mail.readD`](#bbsmailreadd)).

### `BBS.mail.readD`

**Syntax:** `BBS.mail.readD`

The [`BBS.mail.readD`](#bbsmailreadd) command is exactly like the [`BBS.mail.read`](#bbsmailread) command, except that if any
messages were present, [`BBS.mail.delete`](#bbsmaildelete) is automatically called to delete them.

### `BBS.mail.delete`

**Syntax:** `BBS.mail.delete`

The [`BBS.mail.delete`](#bbsmaildelete) command will delete any mail sent to the user WITHOUT READING IT. This
command should only be executed after the mail has been read (this can be done automatically with
[`BBS.mail.readD`](#bbsmailreadd)).

## File Retrieval Commands

### `BBS.upload`

**Syntax:** `BBS.upload [<dirname>]`

[`BBS.upload`](#bbsupload) is an integrated file upload system. It prompts the user to enter the desired upload
protocol. The program then runs the appropriate upload program. If the file is uploaded
without error, the user is prompted for a one-line description of the file. This description is then placed
in a list file for later validation. This program requires that the programs [`Uloadx`](#uloadx), [`Uloadxc`](#uloadxc), and [`Uloady`](#uloady)
be in the current execution directory.

**Note:** This command also updates the `/dd/bbs/BBS.userstats` file.

### `Uloada`

**Syntax:** `Uloada [<filename>]`

[`Uloada`](#uloada) uploads a file using a simple ASCII protocol. With this protocol, you simply send the
information as an ASCII text file. When you are finished uploading, simply type `<CTRL><T>` and
the upload will be terminated.

### `Uloadx`

**Syntax:** `Uloadx [<filename>]`

[`Uloadx`](#uloadx) uploads a file using the XMODEM protocol as implemented by Ward Christensen. This
program is automatically run by [`BBS.upload`](#bbsupload) and need not be run by the sysop. If the filename is not
specified, the user is prompted for one.

### `Uloadxc`

**Syntax:** `Uloadxc [<filename>]`

[`Uloadxc`](#uloadxc) uploads a file using the CRC version of the XMODEM upload program. This command
is automatically run by [`BBS.upload`](#bbsupload) and need not be run by the sysop. If the filename is not specified,
the user is prompted for one.

### `Uloady`

**Syntax:** `Uloady [<filename>]`

[`Uloady`](#uloady) uploads a file using the YMODEM protocol. This command is automatically run by
[`BBS.upload`](#bbsupload) and need not be run by the sysop. If the filename is not specified, the user is prompted
for one.

### `BBS.download`

**Syntax:** `BBS.download [<dirname>]`

[`BBS.download`](#bbsdownload) is an integrated file download system. It prompts the user to enter the desired download
protocol. The program then runs the appropriate download program.

**Note:** This command also updates the `/dd/bbs/BBS.userstats` file.

### `Dloada`

**Syntax:** `Dloada [<filename>]`

[`Dloada`](#dloada) is a download system command that allows the user to download files using the ASCII
protocol. With this protocol, the ASCII text is simply sent through the BBS and the user can use a
capture buffer to receive the information.

### `Dloadx`

**Syntax:** `Dloadx [<filename>]`

[`Dloadx`](#dloadx) is a download system command that allows the user to download files from the board
using the XMODEM protocol implemented by Ward Christensen. If the filename is not specified, the
user is prompted for one. This command is automatically run by [`BBS.download`](#bbsdownload).

### `Dloadxc`

**Syntax:** `Dloadxc [<filename>]`

[`Dloadxc`](#dloadxc) is a download system command that allows the user to download files from the board
using the CRC version of the XMODEM protocol. This command is automatically run from
[`BBS.download`](#bbsdownload) and need not be run by the sysop. If the filename is not specified, the user is prompted
for one.

### `Dloady`

**Syntax:** `Dloady [<filename>]`

[`Dloady`](#dloady) is a download system command that allows the user to download files from the board
using the YMODEM protocol. This command is automatically run from [`BBS.download`](#bbsdownload) and need not be
run by the sysop. If the filename is not specified, the user is prompted for one.

### `DLD.validate`

**Syntax:** `DLD.validate [<dirname>]`

[`DLD.validate`](#dldvalidate) is a download system command that allows the system operator to validate
uploads. When this program is run, the user is given a list of files not yet validated for download. The
user can then either validate the file, download the file, or go on to the next file. If the user decides
to validate the file, he will be prompted for a one-line description of the file (64-character maximum), a list
of keywords on which the file can be searched, and a paragraph description of the file. The BBS users
can then use this information to find and access the file. If `<dirname>` is not specified, the current
directory is assumed. This is true of all upload/download commands.

### `DLD.unvalidate`

**Syntax:** `DLD.unvalidate [<dirname>]`

[`DLD.unvalidate`](#dldunvalidate) removes a file's validated status from the download library in the
specified directory, or the current directory when none is given. It updates `DLD.lst` without deleting
the file itself.

### `DLD.add`

**Syntax:** `DLD.add [<dirname>]`

[`DLD.add`](#dldadd) is a download system command that allows the sysop to post downloads without
having them be uploaded. This allows the sysop to add new files to the current database without
having to upload them.

### `DLD.search`

**Syntax:** `DLD.search [<dirname>]`

[`DLD.search`](#dldsearch) is a download system command that allows users to search for files to download
using keywords. These keywords are the keywords entered by the sysop when he validates the
program. When this command is run, the user is prompted for a keyword to search for. The user will
then be given a list of all fields that are associated with that keyword.

### `DLD.list`

**Syntax:** `DLD.list [<dirname>]`

[`DLD.list`](#dldlist) is a download system command that allows users to list all files currently validated for
downloading in the specified directory. When the command is run, the user is given a formatted listing
of all files currently available.

### `DLD.read`

**Syntax:** `DLD.read [<dirname>]`

[`DLD.read`](#dldread) is a download system command that allows users to read the paragraph description
of a file validated for download. When this program is run, the user will be prompted for the name of
the file to read. If the file has been validated for download, the paragraph description entered by the
sysop will be displayed.

## Menu System

OS-9 Level II BBS Release 3.0 comes with a complete set of menus already created and ready
to run. You can change these menus as you like, or create completely new ones! Have fun adding
new sections to your board and making it better. You should take special notice of how the menu
system is currently set up, as this will help you to create your own additional menus. For more
information on menus, refer to the [`Menu`](#menu) command explanation.

In an effort to help you understand how the menu structure works, the following is an
explanation of the sample menu setup.

There are three individual sets of menu files in each directory that comes with the system. There
are also three special sets of menu files in the BBS directory for special features. These menus are
defined as follows:

| Menu File | Commands File | Description |
| --- | --- | --- |
| `BBS.menu_32` | `BBS.cmds` | User with a 32-column screen |
| `BBS.menu_80` | `BBS.cmds` | User with an 80-column screen |
| `BBS.menu_am` | `BBS.cmds` | User with ANSI graphics |
| `BBS.menu_sl` | `BBS.cmds_sl` | Menu for selecting the menu type |
| `BBS.menu_sys` | `BBS.cmds_sys` | Sysop menu |
| `BBS.menu_new` | `BBS.cmds_new` | New-user menu |

The `BBS.menu_32`, `BBS.menu_80`, and `BBS.menu_am` are the menu text files for various terminal
types. Note that all of these menu text files use the same (`BBS.cmds`) commands file. This is because
they all execute the same options; they just look different!

The other three menus are explained as follows:

`BBS.menu_sl` allows users to select what type of menus to use when they log in. It lists the three
types: 32-column, 80-column, and ANSI graphics. This allows users to log in from different terminals
and not run into problems because of the wrong terminal type.

`BBS.menu_sys` allows the sysop to log in and perform various sysop functions from a remote
location. Note that these files DO NOT have the public read attribute set. This helps to prevent
other users from using this menu, as only user 0 can read this menu.

`BBS.menu_new` is a special menu for new users. This menu allows only limited access to the BBS and
is used mainly for new user validation. A line in your `BBS.users` file should give access to this menu
for new users.

The `BBS.cmds` file uses user numbers to determine priority. A user number less than 1000 is
determined to be a normal user. Any number greater than 1000 is considered an elite user and is
allowed access to the elite-user menu. This standard is compatible with that set forth in release 2.0
of this system. Note that this is only a standard and is in NO WAY ENFORCED! If you want to
change your user numbering system, possibly to include many different levels of users, this is
completely up to you. The [`Menu`](#menu) command provides you with MAXIMUM flexibility in this area; you
can set up as many user levels as you like!

The way you set up the board is completely up to you. I suggest adding your own
special touch to give the board a personal feel.

## Creating and Changing the Bulletin Board

If you do not wish to use the built-in menu structure, you can create your own menu structure.
The procedure for doing this is described below. You may want to read this section even if you intend
to use the built-in structure, as it will give you more insight into how the system works.

### Make a Boot Disk

The first thing that must be done to create the new BBS system is to create a boot disk. You can
do this using either `Cobbler`, `OS9gen`, or `Config`, all of which are provided with your OS-9 Level II disk.
The only thing you have to make sure of is that your boot disk has the proper ACIA drivers to run the
`ACIAPAK` that you have, and that it has the proper `/dd` descriptor for your default disk drive. The
board requires that these two devices be available.

### Create the Directory Structure

The next thing that has to be done is to create the directory structure for the board. The board
requires at least two directories on your disk to run. These are the `CMDS` directory and a directory on
your default drive (`/dd`) named `BBS`. Other directories and drives can be used as you please, but here
are some ideas that you can use.

Usually you would want to either create a new directory or use another disk drive to hold the user
mail. You can name this directory anything you want; I named mine `MAILROOM`. Any time you want
to deal with mail, you should change to this directory (`chd`).

Another directory that you might want to create is a directory to put the main message base. This
can also reside on another disk if you like. I named my major message base directory `BOARD`, but
the naming is strictly up to you.

Another possibility for message retrieval is to create several Special Interest Group directories. You
might want to put these on a different disk drive, or possibly on the same drive as the main
message base; this is entirely up to you. I called mine `CoCoSIG` and `OS9SIG`.

Uploads and downloads will also have to be put somewhere. There are several ways of doing this
as well. You could have a directory under each Special Interest Group for that group's files, or you
could have one large file storage section for all files, or some combination of both. I created one
directory for all files called `FILES`.

### Copy Commands to the Disk

The next step is to copy the commands from the distribution disk to your boot disk. To do this
you can use the `Dsave` command that comes with OS-9, or if you have the OS-9 toolkit ($19.95), you can
use the `Wcopy` command. I would recommend purchasing the toolkit, as it will save you a lot of labor
in managing the board.

### Build the MOTD File

You are now ready to build the `motd` file. This file is listed on the user's screen when he logs in
and must exist in the directory that [`Tsmon`](#tsmon) is run from. You can put whatever text you want in this file,
but it should contain the name of your board and any instructions necessary to log in.

### Build the EOTD File

You should now build the `eotd` file. This file is listed on the user's screen when he logs off. You
can put whatever text you want in this file, but it should give a friendly logoff message.

### Build the Menu Files

This is the most difficult and laborious process in creating the board, but is also the one that allows
you to be the most creative.

You should create a menu file in each directory that you want users to be able to access. In that
menu you should have options for every action that you want to take place in that directory. Options
can be any OS-9 command, BBS command, or even your own programs.

You can name the menu files anything that you want, but I suggest that you use names that have
meaning to you. Any menus in subdirectories MUST have the same name as menus in a previous
directory that calls it. This means that your menu structure should follow your directory structure and
the menu files should all have the same name, but be in different directories. For example, if you
named your menu `BBS.menu` (as I did), and your command file `BBS.cmds` (as I did), then every
directory that you want to call should have those two files in it. You then call the new menu by simply
running the `chd` command to change to the new directory. The [`Menu`](#menu) program will then automatically use the new
menu files.

To actually create the menu, you can use any editor that you have available (`Build`, `Edit`, `Scred`,
`Tsedit`, or even [`BBS.build`](#bbsbuild)). You should create the menu file exactly as you would like it to appear to
the user, with the addition of control commands for screen formatting (see [`Menu`](#menu) for more information).

Once the menu file is created, you must create the command file. This also can be done with any
available editor. The command file should have, on each line, a single letter option followed by the
command line to execute for that option. The command file can be any OS-9 command, BBS
command, command file, or anything else that would be valid in an OS-9 command file. The only
difference is the special commands (see [`Menu`](#menu) for more information). These special commands must
be on a line by themselves. Typically the commands that you would put in a message base would be
[`BBS.post`](#bbspost), [`BBS.delete`](#bbsdelete), [`BBS.forward`](#bbsforward), [`BBS.scan`](#bbsscan), [`BBS.new`](#bbsnew), etc.

These two menu files must be created for every subdirectory that you want to have. These
subdirectories then become submenus that perform different functions.

### Create All Message Bases

You must now go to every directory that will contain a message base and execute [`BBS.create`](#bbscreate).
This will initialize the message base so that new messages can be posted. If this is not done, any calls
to [`BBS.post`](#bbspost) will return an error.

### Create User List Files

The next step in setting up the board is to construct the user list files. These files have to be
`BBS.users` and `/dd/bbs/BBS.alias`. The `BBS.users` file must be in the same directory as [`Tsmon`](#tsmon) is run
from. I suggest using `/dd/bbs` to avoid confusion. The `BBS.users` file must have the user name IN
CAPS, the user password IN CAPS, the command to execute (usually [`Menu`](#menu) or a command file), and
the user's unique number. You must assign each user a number. Once you have created the user
file you must create the alias file. This file contains the user's name or alias followed by a comma
and the user's number. This is the name that the user will be referred to when posting mail and
messages. If you do not want to use aliases, simply put the user's real name for his alias (this name
does not have to be in caps).

### Attribute All User Files

Once you have all of these files created, you must use `attrib` to give public read access to any file
that a user will need to access. This does NOT include `BBS.users`, `motd`, or `eotd`. It does however
include all menu files. If you have the OS-9 toolkit ($19.95), you can use the `Wattr` command to attribute
all files quickly.

### Create a Startup File

Although it isn't necessary, you should create a startup file on your boot disk. This startup file
should set the time, change to the BBS directory, and run `Tsmon <port> &`. That way all you need
to do to run the board is place the proper disks in their drives and press reset. The board should now
be ready to run. If you have problems step through the creation process again and make sure that
you have created all of the proper files.

**Note:** A major source of problems is files with incorrect attributes. Make sure all files have appropriate attributes.

## Maintaining the Bulletin Board

Once the board is set up it should be a fairly simple task to maintain it. There are only a few
things that the sysop should make sure he takes care of when operating the board.

### Set the Date and Time

The sysop should always set the date and time properly when he boots the system. All
message files and mail files use the system date to determine when messages get posted. If the
system date is wrong, it could confuse the users of the board.

### Read the User Feedback

The best source of information about the board will come from its users. There may be
problems with the board (such as files having the wrong attributes) that you never noticed. As a sysop,
it is your responsibility to read your mail, messages, and feedback as often as possible.

### A Word About Uploads

As a sysop, it is also your responsibility to maintain the files section of your board. It is a good
idea to check out all programs that are uploaded before posting them for download. This way you can
help prevent the spread of viruses and Trojan horse programs.

### Initiating New Users

You should set up some way of initiating new users onto your board. This can be achieved
by putting a special login in the users file called `NEW USER`. You should also assign some
appropriate password. You can then give the instructions for new users in the `motd` file. The new
user login should run the [`New_user`](#new_user) command. This command will get all of the person's information
and store it in a file or on the printer. See [`New_user`](#new_user) for more information.

## ANSI Editor

**Syntax:** `AnsiEd [<inputfile>] [<outputfile>]`

`<inputfile>` is an ANSI graphics file to be loaded for editing.

`<outputfile>` is the ANSI graphics file to write when editing is finished.

The ANSI graphics editor allows you to create colorful and dynamic ANSI color screens on your
CoCo III. ANSI codes are a set of special codes used to format output on a computer terminal screen.
The ANSI codes include codes for changing colors, positioning the cursor, and setting character
attributes (such as underlining and blinking). To use ANSI Editor, you do not need to know the
codes; they will be generated automatically.

ANSI Editor has a special *Animation* feature that allows you to do special effects with ANSI
codes. This allows you to have dynamic color displays that move and change. This special feature,
however, makes the editing somewhat more difficult.

To implement the animation effects, two buffers are used: a screen buffer and an output buffer.
The screen buffer can be edited at will; the output buffer cannot be edited. To enable you to put
information in either of these buffers, the editor has two modes, `EDIT` mode and `RECORD` mode. In
addition to this, the editor has a way to put the screen buffer into the output buffer. This allows you
to edit information on the screen until you get it looking right, then send it to the output buffer. When
you save a file, the screen is automatically put into the output buffer before saving. In `RECORD`
mode, every key that you press gets converted to its ANSI code equivalent and put into the output
buffer. In `EDIT` mode, you can move about the screen and change it at will; the information will not
be sent until you tell it to.

In order to use this editor well, you MUST be able to distinguish between the two buffers and
use them to your advantage. Information in the output buffer should be considered already sent;
information in the screen buffer should be considered information yet to be sent.

When loading files, you will always be prompted whether you want the file read into the output
buffer or the screen buffer. If the file has some sort of animated effect, it MUST be loaded into the
output buffer if you wish to retain the animation. This means that once an animation effect is saved,
it cannot be edited.

An editing session may go as follows. First, create an animation effect (using `RECORD`
mode). An example of this animation effect is a border that comes down from the top of the screen
to surround a menu. Once the animation effect has been created, change to `EDIT` mode and fill
in the rest of the picture. When everything looks good, save the image to a file. This file will then have
the ANSI codes needed to do both the animation and the rest of the screen.

It should be noted that information going to both the record buffer AND the screen buffer gets
displayed on the screen. In most cases this will work fine, but it is possible
to get strange results if you are not careful. For instance, suppose you load an animation effect into
the output buffer. You then switch to `EDIT` mode, clear the screen, and begin editing an image. When
you save this image the screen will NOT (I repeat NOT!) be cleared after the animation effect! The
clearing of the screen in `EDIT` mode clears your screen and clears your `EDIT` buffer, but does NOT
send a clear screen code to the file. If you want to send a clear screen code to the file you must first
turn on `RECORD` mode, then clear the screen. As you can see, this could cause some confusion if you
are not careful.

Now that I have explained how the editor uses its buffers, let's see what editing
features it has.

### Editor Functions

#### `[ALT][G]` - Set Graphics

This function allows you to set the various graphics parameters of the screen. This is the
command used to change colors and attributes (underline, etc.). This is the most commonly
used function. When in `RECORD` mode, the ANSI codes used for each function will be sent to
the output buffer; in `EDIT` mode, the current editing attributes will be changed. When you
press `[ALT][G]` you will get a menu with the following options.

- `[R]` — Reset graphics; turns off ALL attributes and sets the colors to white on black.
- `[O]` — Bold on; turns on boldface.
- `[U]` — Underscore on; turns on underlining.
- `[L]` — Blink on; turns on blinking.
- `[V]` — Reverse video on; turns on reverse video.
- `[I]` — Invisible on; makes all characters invisible.
- `[F]` — Set foreground color; displays a menu of all colors and their numbers.
- `[B]` — Set background color; displays a menu of all colors and their numbers.
- `[0]` — Done; returns you to the main editing screen.

#### `[ALT][R]` - Record Mode

This function changes from `EDIT` mode into `RECORD` mode. The first thing that
happens when this key is pressed is that an ANSI code to position the cursor is sent to the
output buffer. Then it switches to `RECORD` mode. In `RECORD` mode, every key you press is
converted into its ANSI code equivalent. This includes all color change, cursor movement, and
character codes.

#### `[ALT][E]` - Edit Mode

This function changes from `RECORD` mode into `EDIT` mode. In `EDIT` mode, you can
move around the screen wherever you please. No information will be sent to the output buffer
until you either execute the *save* function or the *put screen into buffer* function. Note that
what you are editing is the screen buffer. Not all information on the screen is in the screen
buffer. Some information may still be on the screen that is in the output buffer, but is not in
the screen buffer.

#### `[ALT][C]` - Clear the Screen

This function clears the screen. If you are in `RECORD` mode, the screen is cleared and a
clear screen code is sent to the output buffer. If you are in `EDIT` mode, the screen is
cleared AND the screen buffer is cleared.

#### `[ALT][N]` - Clear to End of Line

This function clears from the current cursor position to the end of the current line. If you are
in `RECORD` mode, the line is cleared and a clear line code is sent to the output buffer.
If you are in `EDIT` mode, the line is cleared AND the line in the screen buffer is cleared.

#### `[ALT][S]` - Save Cursor Position

This function stores the current cursor position for later retrieval. If you are in `RECORD`
mode, the position is saved and a save cursor code is sent to the output buffer. If you are in
`EDIT` mode, the current cursor position is saved, but there is NO change in the status of the
screen buffer. In `EDIT` mode, this function is used for convenience only.

#### `[ALT][A]` - Restore Cursor Position

This function restores the cursor position previously saved with the Save cursor position function
(above). In `RECORD` mode, the position is restored and the restore cursor code is sent to
the output buffer. In `EDIT` mode, the cursor is simply restored to its saved position.

#### `[ALT][P]` - Put Screen into Buffer

This function saves the information currently in the screen buffer to the output buffer. The
information is scanned, starting from the top of the screen and moving from left to right down
the page. If no information was typed into a position, that position will be skipped. Cursor
positioning characters will be used to move the cursor to the proper locations on the screen.
By using these cursor positioning characters information already on the screen will NOT be
disturbed. This allows you to fill in spaces not already filled by some sort of animation effect
without disturbing the characters made with the effect.

#### `[ALT][L]` - Load from File

This function will load information from an ANSI graphics file into either the screen buffer or the
output buffer. The information will be displayed on the screen as it is read in. Note that the
information read in does NOT have to be a file created with ANSI Editor; it can be any text file.
If the file has ANSI codes in it, they will be converted and displayed properly on the screen.
If the file has any animation effects, and you want to retain these effects, you must read the
file into the output buffer. If you read a file with animation effects into the screen buffer, only
the final result of the animation will be retained in the buffer.

#### `[ALT][K]` - Save to File

This function will save information from the editor to a file. Before the information is saved, the
screen buffer will be put into the output buffer; the output buffer will then be written to disk.
You will be prompted to enter the filename to save to. The output from this function can be
listed to any ANSI-compatible terminal, and the result will be what you created with the editor.
This file can be used to make dynamic displays for your BBS system, or for your own use. This
file can also be loaded into the editor later for further editing.

#### `[ALT][Z]` - Zap Buffers

This function allows you to ZAP all or part of one of the buffers. You will be asked if you want
to zap:

- `[S]` — The ENTIRE screen buffer
- `[R]` — The ENTIRE record buffer
- `[D]` — The character under the cursor in the screen buffer
- `[T]` — The character last typed in `RECORD` mode

**Note:** For the `[T]` option, the last character typed MUST have been a regular ASCII character (a letter
or symbol), not a special ANSI character sequence (arrows, set graphics, save position, etc.). If you
try to zap an ANSI sequence, you will get unpredictable results. BE CAREFUL!

#### `[ALT][X]` - Save and Exit

This function first saves the current file being edited (see the save option above), then exits back
to the system.

#### `[ALT][Q]` - Quit Without Saving

This option exits the editor and returns you to OS-9. This option does NOT save any
information.

### The Display

The ANSI Editor screen has two sections: the screen display and the status line. The screen
display shows what the final screen result should look like. Note that this display may be different from
the final result (see the discussion on the use of buffers). The status line of the display shows some
helpful information about the current position of the screen.

The first part of the status line shows the current X and Y coordinates of the cursor on the
screen. This is useful when moving about the display and for centering, etc.

The next part of the status line is the current mode of operation. This will say either `EDITING`
or `RECORDING`, according to whether you are in `EDIT` mode or `RECORD` mode.

The next thing on the status line is the current character. This is the current character IN
THE SCREEN BUFFER. This is NOT necessarily the current character on the screen. This allows you
to see directly into the screen buffer.

Next are the current attributes. This gives a list of the attributes currently set. These are the
attributes that will be used whenever you enter a character.

Finally, the current colors in use are given. These are the colors that are currently active. These
colors will be used whenever you enter a character.

### Usage Examples

There are several different ways to use ANSI Editor. It can be used to create animation effects,
or it can be used simply to generate screens.

The simplest case is when you simply want to generate a screen with no animation. The only
problem with this is that when you create a screen there is no way to make sure that the person
receiving the screen has a clear screen. To make sure that you clear his screen you must first
record a clear screen character. To do this, you should first start ANSI Editor, then put it in
`RECORD` mode, then press `[ALT][C]` to clear the screen. You can then put it in `EDIT` mode and create
your screen. When you have your screen looking the way you want it, simply save it to a file. That's all
there is to it!

**Note:** The reason that the clear screen code is not automatically sent is so that you can combine
several ANSI graphics files into one file. If a clear screen code were always inserted before your screen
automatically you would not be able to do this.

A more complex graphic would include some animation effects. To generate these, follow this
example. Start ANSI Editor. Put it in `RECORD` mode, then type in whatever animation effect you
want (including a clear screen if desired). If you want to reposition your cursor on the screen, you can
use the arrow keys, but this has a side effect. Wherever you move, the end result will have the same
move. In other words, if you press right arrow 10 times, then down arrow five times, the final result will
have ten move-right characters followed by five move-down characters. This is fine if you want this effect,
but if you simply want to move to another part of the screen (without seeing the cursor move) simply
switch to `EDIT` mode, move the cursor to the new location, and switch to `RECORD` mode again.
You will now be in the new location IMMEDIATELY. Once you are finished making the animation effect,
you can switch to `EDIT` mode, fill in whatever needs to be filled in, then save. Now you will have
the animation effect followed by the screen fill. Note that the screen will fill in AROUND the animation
effect. It will not overwrite or rewrite the animation effect.

You may want to combine files in creating your graphics. To do this simply load in the files
one after another. They will all be combined into one file when you save. You can read them into the
output buffer or the screen buffer. This allows you to maintain animation effects while still being able to edit
what the final output looks like.

I hope you enjoy using ANSI Editor. Your friends and fellow BBS users will enjoy the dynamic
screens that you create.

## Viewing the BBS Online

### Installing the Necessary Drivers

Special drivers are included with release 3.0 of OS9L2BBS to enable you to see what your BBS
users are doing and to interact with them. These special drivers are on the *BBS Commands Disk* in
a directory called `MODULES`. These modules MUST be included in your `OS9Boot` file if you want to
see the board online. To install the new drivers, follow these instructions:

1. Put a blank, formatted diskette in drive 1.
2. Put your system BOOT disk in drive 0.
3. Enter the following commands:

   ```text
   chd /d0
   chx /d0/cmds
   OS9gen /d1
   ```

4. When the disk stops spinning, enter:

   ```text
   /d0/OS9Boot
   ```

5. When the disk stops again, remove the BOOT disk from drive 0 and insert your *BBS Commands Disk*.
6. Enter:

   ```text
   /d0/modules/DDriver
   ```

7. When the disk stops, press:

   ```text
   <CTRL><BREAK>
   ```

8. When the disk stops again, enter:

   ```text
   dsave /d0 /d1 ! shell
   ```

You will see commands begin to be automatically typed and executed. This will copy all files from drive
0 to drive 1. It may take a LONG time, so go get something to drink and wait.

When the disk stops spinning, you have a new boot disk. Put the new disk in drive 0 and press the
RESET button.

When the disk has booted, the new drivers will be installed.

**Note:** This is your new system BOOT disk. Keep it in a safe place and use it to boot whenever you
want to run the BBS. If you get a BOOT FAILED error with this new BOOT disk, your boot file may be too big. Try eliminating
some of the modules you don't need by configuring a new disk with `CONFIG`.

If you would like to use `CONFIG` to generate a completely new disk, you can copy the needed modules
from the `MODULES` directory on the *BBS Commands Disk* to the `MODULES` directory on the `CONFIG`
disk. These modules are `DblDrv.dr`, `Td.dd`, and `Wb.dw`. Each of these modules is explained on
the next page.

### The Double Driver

The double driver is a special device driver that drives two devices: an `ACIAPAK` device and a `CC3IO` device.
The driver then reads all of its input and sends all of its output to the devices called `/Td` and `/Wb`.
These two device descriptors are included in the `MODULES` directory. `/Td` becomes the new `ACIAPAK`
descriptor (replaces `/t2`) and `/Wb` is a special window that acts like any other window (`/w1`, `/w2`, etc.).
The only difference is that `DblDrv`, the device driver, will try to access `/Wb` when it accesses `/Td`. If it
cannot, it will return an error.

Note that ALL reads and writes to `/Td` are passed through `/Wb` and `/Td`, but set-status and get-status
calls are sent directly to `ACIAPAK`. What this means is that some things don't work in the window that
do work on the port. One of these is [`Tsmon`](#tsmon). [`Tsmon`](#tsmon) will NOT accept input from the window to
establish baud rate. It will also NOT accept characters from the window while in chat or conference
mode. This turns out to be perfectly reasonable in that someone in the window should not be allowed
to interfere with [`Tsmon`](#tsmon) and should not need to interfere with the chat or conference modes.

The modules in the `MODULES` directory are described as follows:

- **`DblDrv.dr`** — The double device driver.
- **`Td.dd`** — The `ACIAPAK` device descriptor.
- **`Wb.dw`** — The `CC3IO` device window descriptor.
- **`DDriver`** — All three modules merged into one file (for convenience).

If you wish to use `/Td` with another driver (other than `ACIAPAK`), this is okay. All that needs to
be done is to patch `DblDrv.dr` where it says `ACIAPAK` to the name of your driver. Everything else
should be the same. I purposely left plenty of room in the `DblDrv` driver for longer names, so if the
device driver you want to use is longer, it can still be patched. If you don't know how to do the
patch yourself, call us at the number given below and we can give you the patch over the phone.

### Viewing the BBS

Viewing the BBS while someone is online is very simple: run the [`ViewBBS`](#viewbbs) command,
and a window will pop up displaying what the user is doing. Note that you would think that because
the BBS runs in a window, you would be able to `<CLEAR>` to that window. But because of the way
OS-9 handles windows, this is NOT the case. The window will only be accessible through the `<CLEAR>` key some of
the time. This is a problem with OS-9 and NOT with the BBS system. Using the [`ViewBBS`](#viewbbs) command
will always show you the window.

## Troubleshooting

There are many problems that can arise in setting up a bulletin board system. Here are some
tips to help when things don't seem to be working properly.

**Problem:** People report that they press `<ENTER>` and nothing happens.

**Solution:** Make sure that the DCD (Data Carrier Detect) DIP switch on the modem is set to reflect
the status of the phone line (not forced on).

**Problem:** User gets the `xxx baud 8 bits no parity` message, but then the computer seems to lock
up.

**Solution:**

- Make sure that the `motd` file is in the directory that [`Tsmon`](#tsmon) was run from.
- Make sure that the `CMDS` directory contains the [`BBS.login`](#bbslogin) command.
- Make sure that the file `BBS.users` is in the directory that [`Tsmon`](#tsmon) was run from.
- Make sure that there is enough remaining memory.

**Problem:** The user gets in, but at a certain menu they get logged off.

**Solution:** Check the attributes of the menu files (make sure they have public read access).

**Problem:** A certain menu option does not run (returns to menu).

**Solution:** That menu option is returning an error; make sure it runs by running it *standalone*.
Make sure there is enough free memory to run the program.

**Problem:** People report that they cannot post messages. Everything seems okay, but the
message doesn't get posted.

**Solution:** Make sure that the file `/dd/bbs/BBS.alias` exists and contains the correct aliases
(verify them against the `BBS.users` file).

**Problem:** When someone hangs up without logging off, they stay logged in when the next user
calls.

**Solution:** Make sure the carrier detect line on the modem is set to reflect the status of the phone
line (not forced on).

I hope these tips will help you solve most problems. If you cannot solve a problem with these tips,
phone support is available at (601) 266-2773. We regret that we cannot pay for the phone call, but
we feel that keeping the price of software down is important to you.
