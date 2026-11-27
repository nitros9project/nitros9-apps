# Multi-Vue

Multi-Vue graphical environment and applications for NitrOS-9 Level Two on
the CoCo 3. The package includes CPU-specific commands, icons, system data,
a demonstration and a startup procedure.

## Building

With LWTOOLS and ToolShed's `os9` command on `PATH`, run from this directory:

```sh
make NITROS9DIR=/path/to/nitros9
```

The build creates `MultiVue_6809.dsk` and `MultiVue_6309.dsk`. It builds the
required OS modules through NitrOS-9's CoCo 3 recipe, using a 40-column
window terminal. Temporary modules are kept separately in `.nitros9-6809/`
and `.nitros9-6309/`.

The images contain `CMDS`, `CMDS/ICONS`, `SYS` and `DEMO`; the graphical shell
is installed as `CMDS/AutoEx`. See [TODO](TODO) for existing maintenance notes.

`make clean` removes generated disks, temporary OS modules and application
build outputs. See the repository's [source and licensing notes](../README.md#source-and-licensing)
for the treatment of historical package material.
