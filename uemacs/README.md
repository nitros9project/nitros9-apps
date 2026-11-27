# MicroEMACS for OS-9

The Bob Santy/Bob Larson MicroEMACS port, distributed by Jim Omura in 1986.
The original distribution message is preserved below.

## Building

Cross-build from this directory with C3 and LWTOOLS on `PATH`:

```sh
make NITROS9DIR=/path/to/nitros9
```

Set `C3BASE` to the C3 installation. The build produces `umacs` for ANSI
terminals and `umacsc` for CoCo terminal control codes. Run `make clean`
to remove generated objects and commands.

## Original distribution message

```text
From: jimomura@lsuc.UUCP (Jim Omura)
Newsgroups: net.micro.6809
Subject: MicroEMACS OS-9 Part 1 of 7
Message-ID: <1197@lsuc.UUCP>
Date: Sun, 4-May-86 12:51:35 EDT
Article-I.D.: lsuc.1197
Posted: Sun May  4 12:51:35 1986
Date-Received: Sun, 4-May-86 15:07:58 EDT
Reply-To: jimomura@lsuc.UUCP (Jim Omura)
Organization: Barrister & Solicitor, Toronto
Lines: 414
Summary:



     These files are the best I could do to get 'microEMACS' for OS-9
'here'.  This is the now legendary Bob Santy/Bob Larson port which time
and luck have conspired to keep out of the hands of most OS-9'ers.
As it is, it's being brought to you from Usenet, to my Color Computer,
to BIX, to Bob Santy, to Bob Larson, to me, to BIX again, to my
Spectravideo CP/M machine, to 'lsuc', to the net.  That's only part
of the story and doesn't even go into the *days* I wasted just trying
to upload it from my Color Computer to 'lsuc' and other fiascos.

     Please, someone, use it.  That's make me feel much better about
the whole mess.

                                           Cheers! -- Jim Omura
```
