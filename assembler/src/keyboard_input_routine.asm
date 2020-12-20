BEGIN
    LDM 15          ; SILENCE TTY
    FIM P0, 0       ; BY SETTING BIT 3 OF 0 TO 3 TO 1
    SRC 0           ; DEFINE RAM ADDRESS
    WMP             ; WRITE DATA TO RAM PORT
    CLC
ST
    JCN 9, ST       ; WAIT FOR DATA INPUT
    JMS SBR1        ; 5.00 MS TIMEOUT
    FIM P0, 13      ; IR(0)=0, IR(1)=13
TEST
    ISZ 1, TEST     ; COMPLETE TIMING FOR BIT SAMPLE
    SRC P0          ; DEFINE ROM PORT ADDRESS
    RDR             ; HEAD FROM INPUT TO AC
    CMA
    WMP             ; COMPLEMENT DATA AND ECHO
    JMS SBR2        ; DO FINAL TIMEOUT 300 MS
    FIM P0, 0       ; IR(0-1)=0
    LDM 0
    XCH 2           ; IR(2)=0
    LDM 0
    XCH 3           ; IR(3)=0
    LDM 8
    XCH 4           ; IR(4)=8
ST1
    JMS SBR1
    CLC
    SRC P0
    RDR             ; HEAD DATA INPUT
    CMA
    WMP
    RAR             ; STORE DATA IN CARRY
    LD 2            ; LOAD AC=IR(2)
    RAR             ; TRANSFER BIT
    XCH 2           ; RESTORE NEW DATA WORD
    LD 3
    RAR
    XCH 3           ; EXTEND REGISTER TO MAKE 8 BITS
    JMS SBR2
    ISZ 4, ST1
    LDM 15
    FIM P0, 0
    SRC P0
    WMP
    JUN ST          ; RETURN TO INPUT


; SUBROUTINES

*=0X45
SBR1                ; 5.47 MS TIMEOUT
    FIM P0, 0       ; IR(0-1)=0
L1
    ISZ 0, L1
    ISZ 1, L1
    BBL

SBR2                ; 2.75 MS TIMEOUT
    FIM P0, 8       ; IR(0)=0, IR(1)=8
L2
    ISZ 0, L2
    ISZ 1, L2
    BBL
