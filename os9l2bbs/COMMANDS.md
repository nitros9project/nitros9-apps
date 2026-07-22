# OS-9 Level II BBS command reference

This is a maintenance-oriented companion to the original Release 3.00 manual.
It records each reconstructed module's role and the persistent state or other
commands that give its code meaning. The original manual remains authoritative
for operator instructions.

## Session and system commands

| Command | Syntax | Responsibility and state |
| --- | --- | --- |
| `Tsmon` | `Tsmon [-m] <port>` | Cycles baud rates until CR is received, reports the selected line settings, sends `modem.set`, and starts `BBS.login` plus `Monitor`. `-m` suppresses `Monitor` for local-window testing. |
| `T1mon` | `T1mon <port>` | Limited 300-baud monitor for the CoCo 3 internal serial port. It accepts the device to supervise and is not reliable for chat, conference, or file transfer. |
| `BBS.login` | `BBS.login` | Displays `motd`, authenticates a `BBS.users` record, updates `userlog` and `BBS.userstats`, adopts the configured OS-9 user ID, runs the configured program/script, and displays `eotd`. |
| `Monitor` | `Monitor` | Watches carrier detect and terminates the caller's process tree after a hangup. Normally started by `Tsmon`. |
| `Menu` | `Menu <menu-file> <command-file>` | Displays a menu, validates any `>NNNNN` priority prefix, and dispatches the selected OS-9 command line. |
| `New_user` | `New_user <pending-user-log>` | Legacy compiled registration form. It collects name, city, state, phone, alias, and password, previews them, and appends a labeled request to the named log. The shipped `runbbs_new` uses `BBS.form` instead. |
| `BBS.validate` | `BBS.validate` | Interactively constructs a new account and, after confirmation, appends matching records to `BBS.users` and `bbs.alias`; used from the sysop menu. It does not read the pending-user log. |
| `BBS.stat` | `BBS.stat` | Displays usage accumulated in `/dd/bbs/BBS.userstats`. |
| `BBS.build` | `BBS.build <file>` | Interactive line editor used to create a text file; the same editing model is reused by posting commands. |
| `BBS.form` | `BBS.form <form> <output>` | Displays each prompt in a form definition and writes the user's answers to the output file. |
| `BBS.list` | `BBS.list <file>` | Lists a text file with BBS-friendly output behavior. |
| `Prompt` | `Prompt <command> "prompt" [args...]` | Prompts for one value, inserts it into a command line, and executes the resulting command. |
| `At` | `At yy/mm/dd hh:mm <command>` | Waits until the requested date/time and then runs the command. Zero date fields mean the next occurrence of the requested time. |
| `Suser` | `Suser <number> [command]` | Sysop utility that adopts an OS-9 user number and runs a command or shell under that identity. The reconstructed source is stored as `suser.asm`; the emitted OS-9 module name is `Suser`. |
| `pause` | `pause ["message"]` | Displays a message and waits for a key. Scripts must redirect input from the terminal. |
| `Makdir` | `Makdir <path>` | Creates a directory; retained for compatibility with installations lacking the standard command. |
| `ViewBBS` | `ViewBBS` | Selects the double driver's BBS viewing window so the local operator can observe an online session. |
| `Quikterm` | `Quikterm [port]` | Runs a simple terminal emulator on the supplied or prompted-for device, with an Alt-T transfer menu for XMODEM-family upload and download. |

## Chat and conference commands

| Command | Syntax | Responsibility and state |
| --- | --- | --- |
| `BBS.chat` | `BBS.chat` | Publishes a chat request and waits for the sysop-side `Answer` command to attach. Exchanges characters through shared module data. |
| `Answer` | `Answer` | Finds and signals `BBS.chat`, links its shared data, and relays characters until Alt-X. |
| `BBS.who` | `BBS.who` | Walks process descriptors and displays callers currently online. |
| `BBS.page` | `BBS.page` | Locates another caller, resolves that process's standard-output device, opens the terminal directly, and writes the page text to it. |
| `BBS.conf` | `BBS.conf` | Joins conference mode and exchanges characters through the shared `Conf.dat` module. |
| `BBS.conf.who` | `BBS.conf.who` | Reads `Conf.dat` participant records and lists users currently in conference mode. |
| `Conf.dat` | linked data module | Shared conference participant and character-exchange state; it is linked by the conference commands rather than run as a command. |

## Message-base commands

These commands operate on `bbs.msg` and `bbs.msg.inx` in the current board
directory unless a directory argument is documented.

| Command | Syntax | Responsibility |
| --- | --- | --- |
| `BBS.create` | `BBS.create [directory]` | Initializes an empty message body file and index. |
| `BBS.post` | `BBS.post` | Collects a subject and body, resolves the caller's alias, and appends a message plus index record. |
| `BBS.read` | `BBS.read` | Reads by message number and navigates next, previous, and thread relationships. |
| `BBS.reply` | `BBS.reply` | Uses an existing message as the parent and posts a threaded response. |
| `BBS.forward` | `BBS.forward` | Reads forward from a selected position without the full interactive navigation loop. |
| `BBS.new` | `BBS.new` | Reads messages newer than the caller's saved last-read state. |
| `BBS.scan` | `BBS.scan` | Displays compact index headings rather than complete bodies. |
| `BBS.search` | `BBS.search` | Searches message subjects for entered text. |
| `BBS.delete` | `BBS.delete` | Marks selected index records deleted. |
| `BBS.pack` | `BBS.pack [directory]` | Rewrites the message body and index files, discarding deleted storage. With no directory argument it operates in the current data directory. |
| `BBS.archive` | `BBS.archive` | Removes messages older than an entered age and optionally appends readable copies to an archive text file. |
| `BBS.convert` | `BBS.convert [directory]` | Converts a Release 2.0 message base to the Release 3.0 layout. |

## Mail commands

These commands operate on `BBS.mail` and `BBS.mail.inx` in the mailroom and use
`/dd/bbs/bbs.alias` to resolve recipients.

| Command | Syntax | Responsibility |
| --- | --- | --- |
| `BBS.mail.post` | `BBS.mail.post` | Resolves a recipient and appends private mail using the common line editor. |
| `BBS.mail.check` | `BBS.mail.check` | Scans the pending index for mail sent by the current user and reports recipients who have not yet read it. |
| `BBS.mail.read` | `BBS.mail.read` | Reads the current user's mail without automatically deleting it. |
| `BBS.mail.readD` | `BBS.mail.readD` | Reads the current user's mail and deletes handled items. |
| `BBS.mail.delete` | `BBS.mail.delete` | Deletes selected private-mail records. |

## Download-library commands

These commands operate on `DLD.lst`, `DLD.dsc`, and `DLD.key` in the selected
download directory.

| Command | Syntax | Responsibility |
| --- | --- | --- |
| `BBS.upload` | `BBS.upload [directory]` | Prompts for ASCII, XMODEM checksum, XMODEM CRC, or YMODEM and starts the matching `Uload*` command. Updates user statistics after a successful transfer. |
| `BBS.download` | `BBS.download [directory]` | Selects a listed file and starts the matching `Dload*` command. Updates user statistics after a successful transfer. |
| `DLD.validate` | `DLD.validate [directory]` | Reviews new uploads, collects description and keyword metadata, and makes accepted files visible. |
| `DLD.unvalidate` | `DLD.unvalidate [directory]` | Removes validation from a library entry. |
| `DLD.add` | `DLD.add [directory]` | Registers a file that was copied into the directory outside the upload front end. |
| `DLD.list` | `DLD.list [directory]` | Lists validated downloads and their one-line descriptions. |
| `DLD.read` | `DLD.read [directory]` | Displays the long description for a selected download. |
| `DLD.search` | `DLD.search [directory]` | Searches `DLD.key` and reports matching downloads. |

## Transfer engines

| Command | Syntax | Responsibility |
| --- | --- | --- |
| `Uloada` | `Uloada [file]` | Receives an ASCII upload until its terminating control character. |
| `Uloadx` | `Uloadx [file]` | Receives XMODEM blocks using the one-byte checksum. |
| `Uloadxc` | `Uloadxc [file]` | Receives XMODEM blocks using CRC-16. |
| `Uloady` | `Uloady [file]` | Historically named YMODEM; receives checksum- or CRC-protected 128-byte SOH and 1024-byte STX data blocks, without YMODEM batch metadata. |
| `Dloada` | `Dloada [file]` | Sends a file as unframed ASCII. |
| `Dloadx` | `Dloadx [file]` | Sends XMODEM blocks using the one-byte checksum. |
| `Dloadxc` | `Dloadxc [file]` | Sends XMODEM blocks using CRC-16. |
| `Dloady` | `Dloady [file]` | Historically named YMODEM; sends checksum- or CRC-protected 1024-byte STX blocks beginning at block one, without a YMODEM block-zero file header. |

## ANSI utilities

| Command | Syntax | Responsibility |
| --- | --- | --- |
| `Ansicode` | `Ansicode <codes>` | Converts compact command-line selections into ANSI terminal escape sequences. |
| `AnsiFilt` | `AnsiFilt <file-or-command> | AnsiFilt` | Parses ANSI escape sequences and emits the corresponding CoCo/OS-9 display operations. |
| `AnsiEd` | `AnsiEd [input] [output]` | Edits a screen buffer and records an independent ANSI output stream. Supports cursor movement, attributes, colors, file load/save, buffer merge, and animation recording. |
