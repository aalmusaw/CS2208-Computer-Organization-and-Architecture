		AREA P2, CODE, READONLY
		ENTRY
		MOV R0, #22
		MOV R1, #48
GCD		CMP R0, R1
		BEQ LOOP
		BLT LT
		SUB R0, R1
		B GCD
LT		SUB R1, R0
		B GCD
LOOP	B LOOP
		END
		