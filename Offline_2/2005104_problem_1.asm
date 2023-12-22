.MODEL SMALL 
.STACK 100H
.DATA
MSG DB 'Enter the number of chocolates: $'
N DW ?
K DW ?
NEXT_MSG DB 0DH,0AH,'Enter the number of wrapper required: $'
OUT_MSG DB 0DH,0AH,'The total chocolate number is : $'


.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG
    MOV AH,9
    INT 21H
    
    
;INPUT CODE
    MOV N,0
    MOV BL,10 
    MOV CX,0
INPUT_NUM_1:
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE END_INPUT_1
    SUB AL,30H
    MOV AH,0
    MOV CX,AX
    MOV AX,N
    ;MOV DX,0
    MUL BX
    ADD AX,CX
    MOV N,AX
    MOV CX,0
    JMP INPUT_NUM_1  
END_INPUT_1:
    LEA DX,NEXT_MSG
    MOV AH,9
    INT 21H
    MOV K,0
    MOV BL,10
    MOV CX,0
INPUT_NUM_2:
    MOV AH,1
    INT 21H
    CMP AL,0DH
    MOV AH,0
    JE END_INPUT
    SUB AL,30H
    MOV CX,AX
    MOV AX,K
    MUL BX
    ADD AX,CX
    MOV K,AX
    JMP INPUT_NUM_2    
END_INPUT: 
    MOV AX,N
    MOV BX,K
    MOV DX,0
FOR_LOOP:
    CMP AX,BX
    JB STACK_PUSH
    DIV BX
    ADD N,AX
    ADD AX,DX
    MOV DX,0
    JMP FOR_LOOP
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
    LEA DX,OUT_MSG
    MOV AH,9
    INT 21H
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
MAIN ENDP
END MAIN
   