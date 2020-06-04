		AREA LAB1Q3, CODE, READONLY
		ENTRY
A		EQU 10  ; 
B		EQU 2  ; 
C		EQU 1  ; 
D		EQU 4  ; 
		MOV r1, #A ; move the value of A to register 1
		MOV r2, #B ; move the value of B to register 2
		MOV r3, #C ; move the value of C to register 3
		MOV r4, #D ; move the value of D to register 4
		ADD r0, r1, r2 ; store the sum of A and B in register 0
		MUL r5, r3, r4 ; store the product of C and D in register 5
		SUB r0, r0, r5 ; store the difference (A+B)-(C×D) in register 0
LOOP	B LOOP
		END