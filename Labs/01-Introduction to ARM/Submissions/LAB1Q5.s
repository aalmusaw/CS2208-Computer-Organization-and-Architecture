		AREA LAB1Q5, CODE, READONLY
		ENTRY
		LDRB r1, A ; load the value of A to register 1
		LDRB r2, B ; load the value of B to register 2
		LDRB r3, C ; load the value of C to register 3
		LDRB r4, D ; load the value of D to register 4
		ADD r0, r1, r2 ; store the sum of A and B in register 0
		MUL r5, r3, r4 ; store the product of C and D in register 5
		SUB r0, r0, r5 ; store the difference of (A+B)-(C×D) in register 0
		STRB r0, Z ; load the contents of register 0 in memory location Z
LOOP	B LOOP
		
		
		AREA LAB1Q5, DATA, READWRITE
A		DCB 4
B		DCB 12
C		DCB -4
D		DCB -5
Z		DCB 0
		END