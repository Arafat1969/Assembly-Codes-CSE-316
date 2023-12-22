

;B2 (Monday 2.30 pm)
;Input:
;Two strings of size between 1 and 6
;Each character is between abcde
;Take input one by one until user presses Enter
;
;- Find the hash value of each string
;- Simple hash function, positional value*character value
;a is 1
;b is 2
;...
;e is 5

.MODEL SMALL 
.STACK 100H
.DATA
MSG DB 'Enter the strings : $'
H1 DB ?
H2 DB ?
COUNT DB 0
OUT_EQUAL DB 0DH,0AH,'PE$' 
NOT_EQUAL DB 0DH,0AH,'NE$'


.CODE
MAIN PROC
   MOV AX,@DATA
    MOV DS,AX
    
    LEA DX,MSG
    MOV AH,9
    INT 21H     
    MOV H1,0
INPUT_NUM_1:
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE END_INPUT_1
    SUB AL,60H
    ADD COUNT,1
    MUL COUNT
    ADD H1,AL
    JMP INPUT_NUM_1  
END_INPUT_1:    
    MOV AX,0
    MOV COUNT,0
    MOV H2,0
INPUT_NUM_2:
    MOV AH,1
    INT 21H
    CMP AL,0DH
    JE END_INPUT_2
    SUB AL,60H 
    MOV AH,0
    ADD COUNT,1
    MUL COUNT
    ADD H2,AL
    JMP INPUT_NUM_2
END_INPUT_2:
    MOV AL,H1
    CMP AL,H2
    JE PRINT_EQUAL
    JMP PRINT_DIFF
PRINT_EQUAL:
    LEA DX,OUT_EQUAL
    MOV AH,9
    INT 21H
    JMP EXIT
PRINT_DIFF:
    LEA DX,NOT_EQUAL
    MOV AH,9
    INT 21H
EXIT:
    MOV AH,4CH
    INT 21H
MAIN ENDP 
END MAIN 