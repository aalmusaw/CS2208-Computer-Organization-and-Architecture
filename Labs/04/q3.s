		AREA P3, CODE, READONLY
		ENTRY
		MOV R0, #0x64
		LDR R1, =0x199A
		MUL R1, R0, R1
		MOV R1, R1, ASR #16
LOOP	B LOOP
		END
		