# asm-4004

A simple Intel 4004 Assembler written in Python

- Automatically generates 8-bit and 16-bit instructions from assembly code
- Supports multiple input files with output filename automatically generated
- Comments are done using semicolons (`;`)
- Hexidecimal numbers start with `0x`
- Decimal numbers can stand alone or start with `#`
- Lines of code can have leading spaces
- Instructions that address a register pair can be assigned through either one of the individual registers, with or without the `r` or `p` (i.e. `r4`, `r5`, or `6`) or the combined register (i.e. `p0`, `p1`, or `3`)
- Warnings are presented if a number is possibly too large, or if the overall file is too large
- Symbols must be on their own line
- Define values for symbols using `=` (i.e. `cz=100`)
- Set which ROM to use with `.rom 2` at the beginning of the file, defaults to `0`

See [the datasheet](../docs/4004_datasheet.md) for the instructions the processor supports

```
usage: asm-4004 [-h] [-v] [-m] [-i INPUT] [-o OUTPUT] [--line LINE] [--surr SURR]

Assembler for Intel 4004 Processor

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         Verbose output
  -m                    Print binary to stdout and file
  -i INPUT, --input INPUT
                        Input files
  -o OUTPUT, --output OUTPUT
                        Output file (Not compatible with multiple input files)
  --line LINE           Print out lines surrounding hex location in binary file
  --surr SURR           Number of surrounding lines for --line
```

Example (nonsensical) assembly code:
```
init
    ; no operation
    NOP
test
    ; clear accumulator and carry
    CLB
    ; increment register 15
    INC r15
    ; jump to addr 0x31 if condition is 1
    JNT test
*=50
test2
    ; fetch immediate from rom data 0x80 into register r5
    FIM r5, init
    ; send contents of register pair r4 + r5 out as address
    ; on A1 and A2 time in the instruction cycle
    JIN p2
    JUN #500
.byte 100
test3
    JUN 0x345
    JCN 0xA, #23
```

Command-line (verbose) output:
```
$ ./asm-4004 -i test.asm -v

Input file: test.asm
Output file: test.bin

Symbols:
	 .rom 		 0x0
	 init 		 0x0
	 test 		 0x1
	 test2 		 0x32
	 test3 		 0x9b

	 init
 $000 	 00 	 nop
	 test
 $001 	 f0 	 clb
 $002 	 6f 	 inc r15
 $003 	 11 01 	 jnt test
	 *=50
	 test2
 $032 	 25 00 	 fim r5, init
 $034 	 35 	 jin p2
 $035 	 41 f4 	 jun #500
	 .byte 100
	 test3
 $09B 	 43 45 	 jun 0x345
 $09D 	 1a 17 	 jcn 0xa, #23

```

Machine code:
```
00 f0 6f 11 01 24 00 35 53 8d 43 45
```

To-Do:
- [x] Symbol handling for processes and memory locations
- [x] Warnings about numbers that are too large
- [x] Multifile input
- [ ] Better warnings / possibly suppress with command line option
- [ ] Multi-file symbols, code, and processes
