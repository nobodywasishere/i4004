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
