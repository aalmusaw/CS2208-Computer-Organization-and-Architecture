		AREA P4, CODE, READWRITE
		ENTRY
		LDRB R10, [R12], R8, LSL #8
LOOP	B LOOP
		END
		