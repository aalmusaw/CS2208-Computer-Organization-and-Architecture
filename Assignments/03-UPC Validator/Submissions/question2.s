		AREA question2, CODE, READONLY
		ENTRY
		MOV r0, #2							;Assume the string is not a palindrome
		LDR r1, =STRING						;Set up a pointer to the string in r1
		LDR r2, =EoS-1						;Set up a pointer to the end of string in r2
		
SCAN	CMP r1, r2							;WHILE  
		BPL DONE							;the start pointer has not crossed the end pointer
	
LNBL	LDRB r3, [r1], #1					;	load a byte from the left of the string in r3 and update pointer
		CMP r3, #0x41						;	IF the byte is lexicographically less than 'A'
		BMI LNBL							;		load the next byte from the left of the string
		CMP r3, #0x5B						;	ELSE IF the byte is  between 'A' and 'Z' inclusive
		BMI LNBR							;		Load the next byte from the right of string
		CMP r3, #0x61						;	ELSE IF the byte is between 'Z' and 'a' exclusive
		BMI LNBL							;		load the next byte from the left of the string
		CMP r3, #0x7B						;	ELSE IF the byte is greater than 'z'
		BPL LNBL							;		load the next byte from the left of the string
		B LNBR								;	ELSE load the next byte from the right of string

LNBR	LDRB r4, [r2], #-1					;	load a byte from the right of the string in r4 and update pointer
		CMP r4, #0x41						;	IF the byte is lexicographically less than 'A'
		BMI LNBR							;		load the next byte from the right of the string
		CMP r4, #0x5B						;	ELSE IF the byte is  between 'A' and 'Z' inclusive
		BMI LOWR							;		Compare the left and right letters	
		CMP r4, #0x61						;	ELSE IF the byte is between 'Z' and 'a' exclusive
		BMI LNBR							;		load the next byte from the right of the string
		CMP r4, #0x7B						;	ELSE IF the byte is greater than 'z'
		BPL LNBR							;		load the next byte from the right of the string
											;	ELSE compare the left and right letters

LOWR	CMP r3, #0x61						;	IF the letter stored in r3 is uppercase
		ADDMI r3, r3, #0x20					;		turn it to lower case
		CMP r4, #0x61						;	IF the letter stored in r4 is uppercase
		ADDMI r4, r4, #0x20					;		turn it to lower case

		CMP r3, r4							;	IF the letter on the left not the same as the one on the right
		BNE STOP							;		BREAK and stop execution.
		BEQ SCAN							;	ELSE CONTINUE
											;REPEAT
DONE	MOV r0, #1							;Declare that the string is a palindrome
STOP	B STOP								;Stop execution					
		
		
		AREA question2, DATA, READONLY
STRING 		DCB "He lived as a devil, eh?" 	;string
EoS 		DCB 0x00 						;end of string
		END