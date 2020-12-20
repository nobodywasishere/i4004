; BCD TO BINARY CONVERSION ROUTINE
; TAKEN FROM MCS-4 MANUAL
BCDBIN
    FIM P0, 0       ; IR(0-1)=0
    FIM P1, 0       ; IR(2-3)=0
    FIM P2, 10      ; IR(4)=0, IR(5)=10
    LDM 14          ; LOAD AC WITH 14
    XCH R6          ; EXCHANGE IR(6) AND AC
    SRC P0          ; DEFINE RAM ADDRESS
    RDM             ; READ RAM DATA TO AC
    XCH R3          ; EXCHANGE IR(3) AND AC
BDBN
    INC 1           ; IR(1)=IR(1)+1
    SRC P0          ; DEFINE RAM ADDRESS
BB1
    RDM             ; READ RAM DATA TO AC
    JZ, BB2         ; JUMP IF AC=0
    DAC             ; AC=AC-1
    WRM             ; WRITE AC TO RAM
    CLC             ; CLEAR CARRY REO
    LD R3           ; LOAD AC WITH C(IR(3))
    ADD r5          ; ADD IR(5) TO AC
    XCH R3          ; EXCHANGE IR(3) AND AC
    LD R2           ; LOAD AC WITH IR(2)
    ADD 4           ; ADD IR(4) RO AC
    XCH R2          ; EXCHANGE AC WITH IR(2)
    JUN BB1         ; JUMP UNCONDITIONAL
BB2
    FIM P2, 100     ; IR(4)=6, IR(5)=4
    ISZ 6, BDBN     ; IR(6)=IR(6)+1, SKIP IF IR(6)=0
    BBL             ; RETURN TO CALLING ROUTINE, AC=0
