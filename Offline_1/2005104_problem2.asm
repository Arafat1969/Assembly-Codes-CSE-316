.MODEL SMALL
.STACK 100H

.DATA
    PROMPT DB 'Enter 3 lowercase letters : $' 
    SECOND_MSG DB 0DH,0AH,'The second highest letter is : $'
    NOT_LOWER_MSG DB 0DH,0AH,'Not lowercase letter $'
    ALL_SAME_MSG DB 0DH,0AH,'All letters are equal $' 
    SPACE DB ' $'
 
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX ,PROMPT
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV BL,AL 
    MOV AH,9
    LEA DX,SPACE
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV BH,AL
    MOV AH,9
    LEA DX,SPACE
    INT 21H
    
    MOV AH,1
    INT 21H 
    
    ;check lowercase
    CMP BH,'a'
    JL  NOT_LOWERCASE
    CMP BH,'z'
    JG  NOT_LOWERCASE
    
    CMP BL,'a'
    JL  NOT_LOWERCASE
    CMP BL,'z'
    JG  NOT_LOWERCASE
    
    CMP AL,'a'
    JL  NOT_LOWERCASE
    CMP AL,'z'
    JG  NOT_LOWERCASE   
    
    
    
    
    CMP BH,BL
    JE BH_BL_SAME
    JA BH_AL_CHECK
    XCHG BH,BL
 
BH_AL_CHECK:
    CMP BH,AL
    JA BL_AL_CHECK
    CMP BH,AL
    JE PRINT_BL
    XCHG BH,AL

BL_AL_CHECK:
    CMP BL,AL
    JA PRINT_BL
    XCHG BL,AL
    JMP PRINT_BL

BH_BL_SAME:
    CMP BL,AL
    JE PRINT_ALL_SAME
    JL PRINT_BL
    XCHG BL,AL
    
PRINT_BL:
    MOV AH,9
    LEA DX, SECOND_MSG
    INT 21H
    MOV AH,2
    MOV DL,BL
    INT 21H 
    JMP EXIT

PRINT_ALL_SAME:
    MOV AH,9
    LEA DX, ALL_SAME_MSG
    INT 21H
    JMP EXIT
NOT_LOWERCASE:
    MOV AH,9
    LEA DX,NOT_LOWER_MSG 
    INT 21H
EXIT:
     MOV AH, 4CH
     INT 21H 
     
MAIN ENDP 
END MAIN       