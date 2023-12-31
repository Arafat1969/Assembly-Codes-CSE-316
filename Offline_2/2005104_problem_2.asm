.MODEL SMALL 
.STACK 100H
.DATA
MSG DB 'Enter the number : $'
N DW ?
A DW ?
OUT_MSG DB 0DH,0AH,'The sum of the digits : $'


.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG
    MOV AH,9
    INT 21H
    
    MOV N,0
    MOV BL,10 
    MOV CX,0
INPUT_NUM_1:
    MOV AH,1
    INT 21H
    CMP AL,20H
    JE INPUT_NUM_1
    CMP AL,0DH
    JE END_INPUT_1
    SUB AL,30H
    MOV AH,0
    MOV CX,AX
    MOV AX,N
    MUL BX
    ADD AX,CX
    MOV N,AX
    MOV CX,0
    JMP INPUT_NUM_1  
END_INPUT_1:
    MOV BX,10
    MOV AX,N
    DIV BX 
    PUSH DX
    CALL SUM_DIGIT
    ;ADD AX,A
    MOV N,AX
    JMP PRINT_NUM 
    
MAIN ENDP 


SUM_DIGIT PROC
    PUSH BP
    MOV BP,SP
    MOV DX,0
    CMP AX,0
    JE RETURN
    DIV BX 
    PUSH DX  
    CALL SUM_DIGIT
RETURN:
    ADD AX,WORD PTR[BP+4] 
    POP BP
    RET 2

PRINT_NUM:
    LEA DX,OUT_MSG
    MOV AH,9
    INT 21H
STACK_PUSH:
    MOV AX,N
    MOV DX,0
    MOV BX,10
    MOV CX,0
LOOP_PUSH:
    DIV BX
    PUSH DX
    MOV DX,0
    INC CX
    CMP AX,0
    JNE LOOP_PUSH
;PRINT
    MOV AH,2
LOOP_POP:
    POP DX
    ADD DX,48
    INT 21H
    DEC CX
    JNZ LOOP_POP
;EXIT:
    MOV AH,4CH
    INT 21H 
END MAIN