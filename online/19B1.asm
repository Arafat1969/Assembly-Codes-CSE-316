;A sequence of lowercase letters will be given as input, followed by an uppercase
;letter working as the input terminator. Output the minimum among the lowercase letters in uppercase.


.MODEL SMALL 
.STACK 100H
.DATA  
LEAST_CHAR DW ? 
PROMPT DB 'Enter the sequence of lowercase letters terminated by a uppercase letter : $'
INVAL DB 0DH,0AH,'Not a valid character $'
NO_LOWER DB 0DH,0AH,'No lowercase letter present $'
MIN_LOWER DB 0DH,0AH,'Minimum lowercase letter in uppercase : $'


.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    
    LEA DX, PROMPT
    MOV AH,9
    INT 21H
     
    MOV LEAST_CHAR, 7BH
LOOP_INPUT:
    MOV AH,1
    INT 21H
    CMP AL,41H
    JNGE INVALID 
    CMP AL,5AH
    JBE DISPLAY
    CMP AL,61H
    JNGE INVALID
    CMP AL,7AH
    JBE CHECK
    JMP INVALID
INVALID:
    LEA DX, INVAL
    MOV AH,9
    INT 21H
    JMP END_CODE 
CHECK:
    MOV AH,0
    CMP AX,LEAST_CHAR
    JB ASSIGN
    JMP LOOP_INPUT 
DISPLAY:
    MOV AH,0
    CMP AX,LEAST_CHAR
    JE NO_LOW 
    LEA DX, MIN_LOWER
    MOV AH,9
    INT 21H
    SUB LEAST_CHAR,20H 
    MOV AH,2
    MOV DX,LEAST_CHAR 
    INT 21H
    JMP END_CODE
ASSIGN:
    MOV LEAST_CHAR,AX
    JMP LOOP_INPUT
NO_LOW:
    LEA DX, NO_LOWER
    MOV AH,9
    INT 21H    
    
END_CODE:
    MOV AH,4CH
    INT 21H 
MAIN ENDP
END MAIN    
    