**********************************************************************
* Conf.dat - OS-9 Level 2 BBS shared conference state
*
* syntax: linked data module; not executed directly
* purpose: hold the participant roster and most recently published message.
*
* Layout used by BBS.conf and BBS.conf.who:
*   $0000-$003B  twenty 3-byte participant records
*                {16-bit biased user ID, notification flag}
*   $003C-$0103  200-byte shared message
*   $0104-       sender handle copied immediately after the message
*
* A participant ID of $FFFF marks a never-used slot, while zero marks a
* vacated slot. BBS.conf stores OS-9 user IDs plus one so zero remains free.
* Notification zero means the latest message is unread; one means consumed.
*
* The module requests 400 bytes of shared memory but initializes only 292.
* The final 32 CR bytes seed enough of the handle region for a safe initial
* scan; a real post replaces up to 255 bytes beginning at offset $003C.
*
* edt/rev  YYYY/MM/DD  Modified by
* comment
* ------------------------------------------------------------------
*          2026/07/20  Codex
* annotated source and normalized comments.
*          2026/07/21  Codex
* decoded and documented the shared conference-memory protocol.
**********************************************************************

                    nam       Conf.dat
                    ttl       data module

                  IFP1
                    use       defsfile
                  ENDC

tylg                set       Data+Objct ; shared data object module
atrv                set       ReEnt+rev ; reentrant module with revision encoded below
rev                 set       $01       ; original module revision

ParticipantSlots    equ       20        ; maximum compact roster entries
ParticipantSize     equ       3         ; biased ID word plus notification byte
RosterBytes         equ       ParticipantSlots*ParticipantSize ; shared roster length
MessageBytes        equ       200       ; maximum conference line length
HandleSeedBytes     equ       32        ; initialized prefix of the sender-handle region
SharedStateBytes    equ       400       ; memory requested by the original module

                    mod       eom,name,tylg,atrv,start,size ; declare the OS-9 data module

SharedState         rmb       SharedStateBytes ; complete shared conference allocation
size                equ       .         ; total shared-memory requirement

name                fcs       /Conf.dat/ ; os-9 module name

* Each $FF,$FF,$FF triple is an unused roster entry. BBS.conf overwrites the
* first two bytes with a biased user ID and sets the final byte to one.
start
ParticipantTable    fill      $FF,RosterBytes ; initialize all twenty participant slots

* CR initialization makes an empty shared message immediately printable and
* provides terminators throughout the region before the first real post.
SharedMessage       fill      C$CR,MessageBytes ; initialize the 200-byte message area
SharedHandlePrefix  fill      C$CR,HandleSeedBytes ; seed the sender-handle terminators

                    emod                ; emit the OS-9 module CRC and trailer
eom                 equ       *         ; define the assembly-time value for eom
                    end                 ; end the assembly source
