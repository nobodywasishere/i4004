# asm-4004

A simple Intel 4004 Assembler written in Python

- Comments are done using semicolons (`;`)
- Lines of code can have leading spaces
- Automatically generates 8-bit and 16-bit instructions from assembly code

See [the datasheet](../docs/4004_datasheet.md) for the instructions the processor supports

```
usage: asm-4004 [-h] -i INPUT [-o OUTPUT] [-v] [--line LINE] [--surr SURR]

Assembler for Intel 4004 Processor

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input file
  -o OUTPUT, --output OUTPUT
                        Output file
  -v, --verbose
  --line LINE           Print out lines surrounding location in binary file
  --surr SURR           Number of surrounding lines for --line
```

Example (nonsensical) assembly code:
```
; no operation
NOP

; clear accumulator and carry
CLB

; increment register 15
INC r15

; jump to addr 0x31 if condition is 1
JNT 0x31

; fetch immediate from rom data 0x80 into register r5
FIM r5 0x80

; send contents of register pair r4 + r5 out as address
; on A1 and A2 time in the instruction cycle
JIN r3
```

Command-line (verbose) output:
```
$ ./asm-4004 -i test.asm -v

Input file: test.asm
Output file: test.bin

0000 0000 	 00 	 nop
0000 0001 	 f0 	 clb
0000 0002 	 6f 	 inc r15
0000 0003 	 11 	 jnt 0x31
0000 0004 	 31 	
0000 0005 	 24 	 fim r5 0x80
0000 0006 	 80 	
0000 0007 	 33 	 jin r3

```

Machine code:
```
00 F0 6F 11 31 24 80 33
```

To-Do:
- [ ] Symbol handling for processes and memory locations
- [ ] Multi-file code and processes
