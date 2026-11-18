# MIPS-Processor-FPGA

A MIPS processor built up in stages in VHDL and Xilinx Vivado, targeting the Basys 3 FPGA board. Completed over five labs in ECE 445 (Computer Organization) at George Mason University, Fall 2026.

## What It Does

Starting from a 2-bit adder, the series builds a working MIPS datapath: a 32-bit ALU, instruction fetch and decode, a register file, control logic, data memory, and branching. Each lab reuses the components from the one before it.

## Lab Progression

| Lab | Focus | What Was Built |
|-----|-------|----------------|
| 1 | VHDL and Vivado IP Integrator | 2-bit ripple-carry adder from two 1-bit full adders, tested on the Basys 3 with switches and LEDs |
| 2 | 32-bit MIPS ALU | ALU with 10 operations and Zero, Carryout and Overflow flags |
| 3 | Instruction fetch and decode | Program Counter, PC Adder, and a 256-byte big-endian Instruction Memory; instruction fields split into Opcode, Rs, Rt, Rd, Shamt, Funct |
| 4 | R-type datapath | Register file, control unit, and ALU control unit connected to run 12 R-type instructions |
| 5 | I-type datapath | Immediate arithmetic and logic, loads, stores, and conditional branches (beq, bne) |

## Key Details

**ALU (Lab 2):** AND, OR, XOR, NOR, ADD, SUBTRACT, shift left logical, shift right logical, set-less-than (signed), and set-less-than (unsigned), selected by a 4-bit control input. Verified with 20 test vectors checked against hand-calculated results, including signed overflow cases, a simultaneous Zero and Carryout case, and signed vs. unsigned comparison.

**Fetch and Decode (Lab 3):** The PC advances by 4 each clock edge while enabled, and resets to 0x00000000 when reset is high. The 12 R-type instructions were hand-translated to machine code for the instruction memory.

**R-Type Datapath (Lab 4):** The control unit asserts RegWrite for R-type opcodes, and the ALU control unit decodes the Funct field. In simulation, all register values matched the calculated final values. On the board, the display stepped through the expected results.

**I-Type Datapath (Lab 5):** Added data memory, immediate extension, a branch adder, branch logic, and multiplexers for next-PC selection. The test program loads six words, runs a loop with bne and beq, and stores the results back to memory. A second program generates the sequence 1, 2, 3, 6, 9, 18, 27, 54, 81 and stores the first nine terms at consecutive word addresses.

## Tools

- VHDL
- Xilinx Vivado (simulation, block designs, synthesis, implementation)
- Basys 3 FPGA board (xc7a35t)

## Concepts Practiced

- Structural VHDL and block-design integration
- Two's complement arithmetic, overflow, and flag logic
- MIPS instruction formats (R-type and I-type) and machine-code encoding
- Datapath and control unit design
- Simulation with testbenches and waveform debugging

## What I Learned

- **A wrong constant can look like a logic bug.** In Lab 5 the first `addi` produced 2 instead of 1 because the ALU Carryin constant was set to 1. Reading the waveform and tracing the result back to that one signal fixed it.
- **Resetting the PC does not reset the register file.** On the board in Lab 4, pressing reset returned the PC to the first instruction but the display showed a different result, because the registers still held values from the previous run. Reprogramming the board restored the starting values.
- **Displayed values are not always the raw values.** The PC output shown in simulation uses bits 6 through 2, so it counts by 1 even though the internal PC counts by 4.

## Status

All five labs are complete. Each design was simulated in Vivado and tested on the Basys 3, and all five labs were graded 100.

## Repository Layout

*Add once the files are uploaded: VHDL source files, testbenches, constraints file, and lab reports for each lab.*
