# OS-9 Level II BBS architecture

This document describes how the Alpha Software Technologies OS-9 Level II
BBS programs cooperate. It is based on the Release 3.00 manual, the `Read.me`
and `Files_list` files on the preserved distribution disk, the installed menu
and script files under `bbs/`, and the behavior recovered from the command
modules under `cmds/`.

The original manual is available from the Color Computer Archive:

<https://colorcomputerarchive.com/repo/Documents/Manuals/Applications/OS9%20Level2%20BBS%20%28Alpha%20Software%20Technologies%29.pdf>

## System model

OS9L2BBS is not a monolithic server. It is a collection of ordinary OS-9
commands, text files, scripts, and data files. OS-9 supplies process creation,
path handling, device drivers, permissions, and user identities; the BBS
commands add the login, menu, message, mail, download, chat, and administration
policies.

The normal call lifecycle is:

```text
Tsmon <port>
  |-- detects baud rate and initializes the modem
  |-- starts BBS.login on the caller's port
  `-- starts Monitor unless -m was requested

BBS.login
  |-- displays motd
  |-- authenticates against BBS.users
  |-- records the call in userlog and BBS.userstats
  |-- changes to the caller's configured OS-9 user number
  |-- runs the caller's configured command or script
  |     `-- normally runbbs -> Menu
  |-- displays eotd
  `-- returns control to Tsmon

Monitor
  `-- watches carrier detect and kills the caller's process tree on hangup

Menu
  |-- displays the selected bbs.menu_* file
  |-- reads a key
  |-- checks any priority prefix in the matching bbs.cmds* entry
  `-- changes directory, chains a command, or exits
```

The current `bbs/runbbs` script enters the mailroom, reads and checks mail, and
then starts the display-selection menu. Menu files and command tables turn
directory changes into navigation: each board directory contains the local
message base and its own menu files.

## Identity and access control

`BBS.users` is a text database. The manual defines each record as:

```text
user name,password,program,user number[,daily time limit]
```

- `user name` and `password` are entered at login.
- `program` may be an executable or an OS-9 script such as `runbbs`.
- `user number` becomes the caller's OS-9 user ID. User zero is conventionally
  the sysop.
- `daily time limit` is optional. Missing or zero means unlimited access.

Menu command tables may prefix an entry with `>NNNNN`. The numeric value is a
minimum user priority. This is how the shipped menus restrict mail, SIG, elite,
and sysop functions without placing access policy inside every command.

`bbs.alias` maps valid BBS aliases to users. Message and mail commands consult
it when attributing or addressing posts. The manual specifically notes that
posting failures commonly result from a missing or inconsistent alias file.

`BBS.userstats` stores per-user usage statistics. BBS.login and the message,
mail, upload, and download commands update it. `BBS.stat` scans it as a stream
of 32-byte records keyed by OS-9 user ID. Ordinary callers see their own
record; user zero is prompted for an account number. The fields recovered from
the report code are:

| Offset | Size | Meaning |
| ---: | ---: | --- |
| 0 | 2 | OS-9 user ID |
| 2 | 2 | times called |
| 4 | 6 | fields not displayed by `BBS.stat` |
| 10 | 2 | messages left |
| 12 | 2 | messages read |
| 14 | 2 | files downloaded |
| 16 | 2 | files uploaded |
| 18 | 6 | last-login year, month, day, hour, minute, and second |
| 24 | 2 | current-login duration value, omitted when zero |
| 26 | 6 | fields not displayed by `BBS.stat` |

The original date renderer spells the year as `19YY`; this is preserved
behavior, not a modern interpretation added by the reconstruction.

## Menus and scripts

`Menu <menu-file> <command-file>` is the system's dispatcher. A menu text file
contains the display. The corresponding command file maps a key to an OS-9
command line. The last slash-prefixed line supplies the input prompt.

Examples from the shipped main menu table:

```text
b chd main
>00001 m chd mailroom
>00001 s chd sigs
u chd utils
>01000 e chd elite
g ex
/Your choice (?=menu):==>
```

The command may be `chd`, another `menu`, a BBS executable, an OS-9 script, or
`ex` to leave the current menu. Scripts that invoke an interactive command must
redirect its standard input back to the caller, normally with `</1`; otherwise
the command reads its answers from the script file itself.

The supplied hierarchy is:

```text
/dd/bbs
|-- MAIN                 public message base
|-- MAILROOM             private mail base
|-- SIGS
|   |-- COCO             CoCo message base
|   |   `-- FILES        CoCo downloads
|   `-- OS9              OS-9 message base
|       `-- FILES        OS-9 downloads
|-- ELITE                high-priority message base
|   `-- FILES            elite downloads
`-- UTILS                chat, conference, setup, and administration
```

## Message bases

A board directory contains `bbs.msg` and `bbs.msg.inx`.

- `bbs.msg` holds message bodies and headers.
- `bbs.msg.inx` is the fixed-record index used to locate live messages without
  scanning the whole message file.

The commands divide responsibilities as follows:

- `BBS.create` initializes a message base.
- `BBS.post` edits and appends a new message.
- `BBS.read` reads by message number and can move next, previous, or through a
  thread.
- `BBS.reply` prepares a response associated with an existing message.
- `BBS.forward` reads forward through messages.
- `BBS.new` reads messages newer than the caller's recorded visit.
- `BBS.scan` displays compact message headings.
- `BBS.search` finds messages whose subjects contain entered text.
- `BBS.delete` marks messages deleted.
- `BBS.pack` rewrites the base, removing deleted message storage and rebuilding
  the index.
- `BBS.archive` removes old messages and optionally writes a human-readable
  archive file.
- `BBS.convert` converts a Release 2.0 message base for Release 3.0.

`BBS.pack` walks the index and body files as parallel streams. For each live
record it writes the body's new 32-bit packed offset into a rebuilt index and
copies body lines through the CR-only message terminator. For each tombstone
it omits both streams, remembers the original message number, and later uses
that list to renumber saved positions in `BBs.msg.lst`.

The historical scratch names are counterintuitive: `msg.scratch` is the
rebuilt index and `inx.scratch` is the rebuilt body store. After both outputs
are complete, the program deletes the originals and renames the scratch files
by editing their raw 32-byte OS-9 directory entries. Raw directory names use
bit 7 of the last character as their terminator.

The source annotations should distinguish three different values that are
easy to confuse: the user-visible message number, an index-record position,
and a byte offset in `bbs.msg`.

The recovered index layout uses a 64-byte header followed by 64-byte message
records. The header's first word is the current high message number. Fields
used consistently by the archive and message commands are:

| Offset | Size | Meaning |
| ---: | ---: | --- |
| 0 | 4 | 32-bit byte offset of the body in `bbs.msg`; `$FFFF` in the first word marks a deleted record |
| 4 | 20 | CR-terminated or fixed-width author display name |
| 24 | 30 | CR-terminated or fixed-width subject |
| 54 | 6 | year, month, day, hour, minute, and second bytes |
| 60 | 2 | author's OS-9 user ID, used to authorize deletion |
| 62 | 2 | recipient user ID; `$FFFF` means all users |

`BBS.alias` lines are stored as `display name,user number`. Commands replace
the comma with CR when they need the display name as an OS-9 line, then parse
the decimal user number following the comma.

## Private mail

The mailroom uses `BBS.mail` and `BBS.mail.inx`. Mail records are addressed to
a user or alias and are filtered using the authenticated user identity.

- `BBS.mail.post` composes mail with the same line editor used by message
  posting.
- `BBS.mail.check` reports whether the current user has unread mail.
- `BBS.mail.read` reads the current user's mail.
- `BBS.mail.readD` reads mail and deletes each item after it is handled.
- `BBS.mail.delete` deletes selected mail.

The read-and-delete command is intentionally separate because the original
manual warns of shell compatibility problems that can surface as OS-9 error
223 during deletion.

## Download libraries and transfer protocols

Each download directory contains three related databases:

- `DLD.lst` - compact file list and validation state.
- `DLD.dsc` - long descriptions.
- `DLD.key` - searchable keywords.

`DLD.lst` is a stream of 96-byte records:

| Offset | Size | Meaning |
| ---: | ---: | --- |
| 0 | 31 | CR-terminated filename field |
| 31 | 1 | validation flag; `$FF` is visible and zero is hidden |
| 32 | 64 | CR-terminated one-line description |

`BBS.upload` and `BBS.download` provide the interactive protocol-selection
front ends. The protocol-specific commands perform the actual transfer:

| Command | Direction | Protocol |
| --- | --- | --- |
| `Uloada` | upload | ASCII |
| `Uloadx` | upload | XMODEM checksum |
| `Uloadxc` | upload | XMODEM CRC |
| `Uloady` | upload | YMODEM |
| `Dloada` | download | ASCII |
| `Dloadx` | download | XMODEM checksum |
| `Dloadxc` | download | XMODEM CRC |
| `Dloady` | download | YMODEM |

Administration and browsing commands are:

- `DLD.validate` reviews uploaded files, collects their one-line description,
  long description, and keywords, and makes accepted files visible.
- `DLD.unvalidate` removes validation from a library entry.
- `DLD.add` registers a file that was placed in the directory without using
  the upload front end.
- `DLD.list` lists available files.
- `DLD.read` displays a file's description.
- `DLD.search` searches the keyword database.

The transfer routines and database routines are separate concerns. Source
labels should say whether a buffer contains a pathname, transfer block,
protocol checksum/CRC, list record, description text, or keyword text.

## Chat, paging, and conference mode

`BBS.chat` records a user's request to chat with the sysop. `Answer` locates
the chat process, signals it, links to its shared module data, and relays
characters until the operator exits with Alt-X.

Conference mode is a small multi-process shared-memory service:

- `BBS.conf` enters conference mode and exchanges characters with the shared
  conference data module.
- `BBS.conf.who` lists conference participants.
- `BBS.who` lists callers currently online.
- `BBS.page` signals another caller or the sysop.

Shared-module fields in these commands must be documented as synchronization
flags, process IDs, character slots, or participant records—not as anonymous
workspace offsets.

## ANSI tools

`AnsiCode` emits ANSI control sequences selected on its command line.
`AnsiFilt` converts ANSI screen data to OS-9/CoCo display codes.

`AnsiEd` maintains two distinct representations:

- The **screen buffer** is the editable final screen image.
- The **output buffer** is the ordered ANSI stream, including animation and
  cursor movement, that will be written to disk.

Edit mode changes the screen buffer. Record mode converts every key and screen
operation into ANSI data in the output buffer. Putting the screen into the
output buffer scans the screen from top-left to bottom-right and emits cursor
positioning sequences only where needed. Saving first merges the screen buffer
into the output buffer and then writes the output buffer.

This distinction is the key to meaningful `AnsiEd` labels. Buffers, lengths,
cursor coordinates, saved cursor state, active attributes, foreground and
background colors, and edit/record mode must be named separately.

## Carrier handling and online viewing

`Tsmon` cycles through supported baud rates until it receives carriage return,
reports the detected communications parameters, and starts `BBS.login` and
`Monitor`. It sends the contents of `modem.set` whenever it initializes the
modem. The manual requires a modem setup string for reliable 2400-baud use.

`Monitor` watches data-carrier detect. If the caller hangs up without logging
off, it terminates the caller's process tree so that the next call cannot
inherit the previous session.

`T1mon` provides limited support for the CoCo 3 internal serial port at up to
300 baud. The manual explicitly excludes chat, conference, upload, and
download from reliable use on that port.

`ViewBBS` changes the current display to the special online-view window used
with the supplied double driver. The double driver mirrors ordinary reads and
writes between the serial descriptor and a CoCo window while forwarding status
calls directly to the serial driver.

## Source annotation conventions

The reconstructed assembly is verified against the preserved binaries. Source
improvements must not change emitted bytes.

Each command source should provide:

1. A module header stating command syntax, purpose, persistent files read or
   written, cooperating commands, and important failure behavior.
2. A workspace layout whose names describe stored state.
3. A short contract above every routine: inputs, outputs, clobbers, persistent
   effects, and error convention.
4. Labels that describe decisions and loop roles, such as
   `FindNextMessage`, `WriteIndexRecord`, or `WaitForChatSlot`.
5. Instruction comments that explain why the instruction is needed in the
   surrounding algorithm. Comments such as "load A" or "branch if equal" add
   no information and should be replaced.
6. An explicit note where meaning is inferred rather than stated by the
   manual or proven by call/data-flow analysis.
