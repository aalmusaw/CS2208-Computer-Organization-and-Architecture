		AREA LAB1Q1, CODE, READONLY
		ENTRY
		MOV r1, #2 ; Put 2 in register r1
		MOV r2, #-3 ; Put -3 in register r2
		MOV r3, #-254 ; Put -254 in register r3
		MOV r4, #-65281 ; Put -65281 in register r4
		ADD r0, r1, r2 ; Add r1 to r2 and put the result in r0 
		ADD r5, r3, r4 ; Add r3 to r4 and put the result in r5 
		ADD r0, r0, r5 ; Add the contents of r0 and r5, and store in r0.
LOOP	B LOOP
		END