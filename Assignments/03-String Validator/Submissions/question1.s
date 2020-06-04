		AREA question1, CODE, READONLY
		ENTRY
N		EQU 12				;Set up length of UPC String
		MOV r0, #2			;Assume the UPC String is invalid.
		LDR r1, =UPC		;Set up a pointer to the UPC String
		ADD r7, r1, #N		;Set up a pointer to what is after UPC String
SUM		TEQ r1, r7			;UNTIL
		BEQ SUMD			;All characters in UPC String have been scanned
		TST r1, #1			;   Test if r1 is pointing to an odd address (not aligned to multiple of 2 bytes)
		LDRB r5, [r1], #1	;	Load a byte from UPC, and increment the index
		SUB r5, r5, #&30	;   Cast value from char to numeric
		ADDEQ r3, r3, r5	;	IF r1 was pointing to an even address in test above, add the loaded byte to its partial sum in r3.
		ADDNE r2, r2, r5	;	ELSE, add the loaded byte to its partial sum in r2.
		B	SUM				;REPEAT
SUMD	ADD r3, r3, LSL #1	;Multiply the sum of 1st, 3rd, ... numbers in UPC stored at r3 by 3.
		ADD r4, r2, r3		;Compute the check sum in r4, i.e. r4 = r2+r3
DIV		SUBS r4, r4, #10	;WHILE check sum is not 0, subtract 10
		BMI STOP			;	If the check sum is negative, stop
		BNE DIV				;REPEAT
		MOV r0, #1			;Set r0 to 1 if check sum = 0, i.e. a valid UPS 
STOP	B STOP				;Stop execution					
		
		
		AREA question1, DATA, READONLY
UPC 	DCB "013800150738" 	;UPC string
		END