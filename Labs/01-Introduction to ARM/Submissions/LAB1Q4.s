		AREA LAB1Q4, CODE, READONLY
		ENTRY
		LDR r1, A ; load the value of A to register 1
		LDR r2, B ; load the value of B to register 2
		LDR r3, C ; load the value of C to register 3
		LDR r4, D ; load the value of D to register 4
		ADD r0, r1, r2 ; store the sum of A and B in register 0
		MUL r5, r3, r4 ; store the product of C and D in register 5
		SUB r0, r0, r5 ; store the difference of (A+B)-(C×D) in register 0
		STR r0, Z ; load the contents of register 0 in memory location Z
LOOP	B LOOP
		
		AREA LAB1Q4, DATA, READWRITE
A		DCD 4
B		DCD 12
C		DCD -4
D		DCD -5
Z		DCD 0
		END