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
