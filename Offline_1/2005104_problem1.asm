.MODEL SMALL 
.STACK 100H 


.DATA 
    PROMPT DB 'Enter a printable Ascii character : $'
    NO_ALPHA_MSG DB 0DH, 0AH,'Not an alphanumeric value $'
    UPPER_MSG DB 0DH ,0AH, 'Uppercase letter $'
    LOWER_MSG DB 0DH ,0AH, 'Lowercase letter $'
    NUMBER_MSG DB 0DH ,0AH, 'Number $'
      
.CODE 
MAIN PROC 
 MOV AX, @DATA
 MOV DS, AX 
 
 LEA DX, PROMPT
 MOV AH, 09H
 INT 21H 
 
 MOV AH, 01H
 INT 21H    
 MOV BL, AL 
 
 CMP BL,'0'
 JL NO_ALPHA
 CMP BL,'9'
 JA UPPER_CHECK
 JMP NUMBER 
 
UPPER_CHECK:
 CMP BL,'A'
 JL NO_ALPHA
 CMP BL,'Z'
 JA LOWER_CHECK
 JMP UPPER 
 
LOWER_CHECK:
 CMP BL,'a'
 JL NO_ALPHA
 CMP BL,'z'
 JA NO_ALPHA
 JMP LOWER
  
UPPER:
 LEA DX, UPPER_MSG
 JMP DISPLAY
 
LOWER:
 LEA DX, LOWER_MSG
 JMP DISPLAY
  
NUMBER:
 LEA DX, NUMBER_MSG
 JMP DISPLAY
 
NO_ALPHA:
 LEA DX, NO_ALPHA_MSG
  
DISPLAY:
 MOV AH,09H
 INT 21H
   
EXIT:
 MOV AH, 4CH
 INT 21H  
  
MAIN ENDP 
END MAIN 