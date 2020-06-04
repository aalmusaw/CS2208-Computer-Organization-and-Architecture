		AREA prog3, code, READONLY
		ENTRY
		MOV r0, #123				; Load a value to r0
		MOV r1, #212				; Load a value to r1
		MOV r2, #99					; Load a value to r2
		MOV r3, #12					; Load a value to r3
		
		TST r0, #1					; Test the parity of r0.
		LSREQ r1, r1, r0			; If r0 is even, logically shift r1 right by r0.
		LSLEQ r2, r2, r0			; If r0 is even, logically shift r2 left by r0.
		LSLNE r1, r1, #8			; If r0 is odd, logically shift r1 right by 8.
		LSRNE r2, r2, #8			; If r0 is odd, logically shift r2 left by 8.
		
		ADD r4, r1, r2				;[r4] <- [r1] + [r2]
		ADD r4, r4, r3, ASR #3		;[r4] <- [r4] + [r3]/16
		
loop 	B loop
		END