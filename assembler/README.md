# asm-4004

A simple Intel 4004 Assembler written in Python

- Automatically generates 8-bit and 16-bit instructions from assembly code
- Comments are done using semicolons (`;`)
- Hexidecimal numbers start with `0x`
- Decimal numbers can stand alone or start with `#`
- Lines of code can have leading spaces
- Instructions that address a register pair can be assigned through either one of the individual registers (i.e. `r4` and `r5`) or the combined register (i.e. `p0` and `p1`)
- Warnings are presented if a number is possibly too large
- Easy to add or modify instructions

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
test2
    ; fetch immediate from rom data 0x80 into register r5
    FIM r5, init
    ; send contents of register pair r4 + r5 out as address
    ; on A1 and A2 time in the instruction cycle
    JIN p2
    JUN #5005
test3
    JUN 0x345
```

Command-line (verbose) output:
```
$ ./asm-4004 -i test.asm -v

Input file: test.asm
Output file: test.bin

symbols:  {'init': 0, 'test': 1, 'test2': 5, 'test3': 10}

	 init
 $000 	 00 	 nop
	 test
 $001 	 f0 	 clb
 $002 	 6f 	 inc r15
 $003 	 11 01 	 jnt test
	 test2
 $005 	 24 00 	 fim r5, init
 $007 	 35 	 jin p2
Warning, #5005 may be too large
Warning, #5005 may be too large
 $008 	 53 8d 	 jun #5005
	 test3
 $00A 	 43 45 	 jun 0x345

00f06f1101240035538d4345

```

Machine code:
```
00 f0 6f 11 01 24 00 35 53 8d 43 45
```

To-Do:
- [x] Symbol handling for processes and memory locations
- [x] Warnings about numbers that are too large
- [ ] Better warnings / possibly suppress with command line option
- [ ] Multi-file code and processes
