		AREA question1, CODE, READWRITE
		ENTRY
											;Load addresses to pointers
		LDR r0, =STRING1					;Set up a pointer to STRING1
		LDR r1, =EoS						;Set up a pointer to the end of STRING1
		LDR r2, =STRING2					;Set up a pointer to STRING2
		LDR r9, =0x20746865					;Load the bit pattern " the" for later use
		LDR r10, =0x09746865				;Load the bit pattern "\tthe" for later use
		LDR r11, =0x00746865				;Load the bit pattern "\0the" for later use
											
											;Sequentially scan each character in a string, force it to lower case if it
											;is an upper case, check if it is 'the', store loaded characters from STRING1
											;as appropriate.
SCAN	CMP r0, r1							;WHILE  
		BPL STOP							;	STRING1 has not been scanned completely

											;All loaded uppercase characters are forced to lowercae here to check bit pattern
LWR		LDRB r3, [r0], #1					;	Load a character from STRING1 and increment pointer
		ADD r5, #1							;	Increment a byte counter
		CMP r3, #0x41						;	Is this an uppercase letter?
		RSBGES r4, r3, #0x5A				;	If this letter is in range A-Z inclusive:
		ORRGE r4, r3, #0x0020				;		set bit 5 to force to lower case
		MOVLT r4, r3						;	Else copy the letter as it is

											;Every 4 characters here are grouped in a register to check bit pattern
											;If we know the last 4 characters come from word 'the', then we overwrite it.
WORD	CMP r4, #0x20						;	IF the scanned character is NOT a space OR
		CMPNE r4, #0x09						;   it is NOT a tab
		BNE	PTRN							;		 Do not overwrite the last characters (i.e. skip next 4 lines)
											;	ELSE
		MOV r6, #0							;	Reset register R0
		MOV r5, #1							;	Reset the byte counter
		CMP r7, #1							;		IF the last 4 char are " the" or "\tthe"
		SUBEQ r2, #0x3						;			overwrite the last 3 bytes
		BEQ PTRN								;		ELSE
		CMPNE r7, #2						;			IF the last 4 char are "\0the"
		SUBEQ r2, #0x4						;				overwrite the last 4 bytes
		
											;Here, we store every 4 characters in a register so it can be checked later.
PTRN 	MOV r7, #0							;	forget prior knowledge about the shape of last 4 bytes											
		ORR r6, r4, r6, LSL	#8				;	Store processed char along with up to 3 older ones as a word using a shift

		


											;Here, we store the original loaded character in STRING2.
											;If the last 4 characters are of the form " the", "\tthe" or "\0the", we prepare
											;for the possibility that the scanned word is actually "the". We confirm this
											;by scanning the next character. If it is a space or a tab, then, we know for sure it is.
STRE	STRB r3, [r2], #1					;	Store the original char in STRING2
		CMP r5, #4							;	If we have not saved 4 bytes in register 6 yet
		BNE SCAN							;		Scan more characters.
		CMPEQ r6, r9						;	If the last 4 characters are " the"
		CMPNE r6, r10						;	OR "\tthe"
		MOVEQ r7, #1						; 			Remember this fact by storing 1 in a variable
		BEQ SCAN							;			Continue Loop
		CMP	 r6, r11						;	ELSE IF the last 4 characters are "\0the"
		MOVEQ r7, #2						;			Remember this fact by storing 2 in a variable

		B SCAN								;REPEAT
					
STOP	B STOP								;Stop execution					
		
		
		AREA question2, DATA, READWRITE
STRING1 DCB "and the man said they must go" ;String1
EoS 	DCB 0x00 							;end of string1
STRING2 space 0x7F 							;just allocating 127 bytes
		END