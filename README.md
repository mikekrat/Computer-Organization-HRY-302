# Computer Organization — HRY-302 (TUC)

A **pipelined / single-cycle processor built in VHDL**, developed for the
Computer Organization course (2021–2022). The design implements a datapath and
control unit stage by stage, each with its own testbench and simulation
waveforms. **Grade: 6/6.**

## What it implements
A MIPS-style processor assembled from the classic five stages:

| Stage | Folder | Contents |
|-------|--------|----------|
| Instruction fetch | `IFSTAGE/` | PC, adders/incrementor, instruction RAM |
| Decode | `DECSTAGE/` | register file, decoder, immediate handling, muxes |
| Execute | `EXSTAGE/` | ALU and operand muxing |
| Memory | `MEMSTAGE/` | data RAM |
| Register file | `RF/`, `REG/` | registers and the register file |

Supporting blocks include the **ALU** (`ALU/`), the **control unit** (`CONTROL/`),
the integrated **datapath** (`DATAPATH/`) and the top-level single-cycle
processor (`PROC_SC/`). Each unit ships with a `*_TB.vhd` testbench, and the
`WAVEFORMS/` folder holds the simulation configs (`.wcfg`) and ROM programs
(`rom*.data`) used to verify it.

## Layout
```
SOURCES/     VHDL for every stage and unit, each with its testbench
WAVEFORMS/   simulation waveform configs + ROM test programs
REPORT/      design report (2018030104_REPORT.pdf)
```

## Simulate
Load the sources for a unit into a VHDL simulator (Xilinx ISE / Vivado), add the
matching `*_TB.vhd` as the top module, load the relevant `WAVEFORMS/*.wcfg`, and
run the simulation. `PROC_SC_TB` runs the whole processor against a ROM program.

## Tech
VHDL · processor datapath & control · pipelining · register file, ALU, RAM ·
testbench-driven simulation
