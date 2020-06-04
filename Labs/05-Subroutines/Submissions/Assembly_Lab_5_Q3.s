			AREA bubbleSort, CODE, READONLY
			ENTRY
;----------------------------------------------------
main		ADR r0,a          ;r0 is a pointer to array a
			ADR r1,endOfArray ;address at the end of the array
			SUB r1,r1,r0      ;r1: the length of the array in bytes
			ASR r1,#2         ;r1: the number of element in the array, i.e., n

			MOV r2,#0         ;r2: outer loop counter,i.e., i
			SUB r4,r1,#1      ;r4 is (n - 1)
startOuter	CMP r2,r4         ;compare i with (n - 1) 
			BGE endOuter      ;if i >= (n - 1), then exit the outer loop
			MOV r3,#0         ;r3 is the inner loop counter, i.e., j
			SUB r5,r4,r2      ;r5 is (n - 1 - i)
startInner	CMP r3,r5         ;compare j with (n - 1 - j) 
			BGE endInner      ;if j >= (n - 1 -j), then exit the inner loop
			ADD r6,r0,r3,LSL#2;r6 is a pointer to a[j]
			ADD r7,r6,#4      ;r7 is a pointer to a[j+1]
			ADR r13, stack	  ;Set up a pointer to the stack
			STR	PC, [r13, #-4]! ;pre-decrement the stack pointer
			B  sortTwo       ;call sortTwo(*a[j],*a[j+1])
			ADD r3,r3,#1      ;increment inner counter j
			B   startInner    ;loop again (inner loop)
endInner	ADD r2,r2,#1      ;increment outer counter i
			B   startOuter    ;loop again (outer loop)
endOuter	B endOuter

sortTwo		STR r8, [r13, #-4]!		;Free up register r8 using the stack
			STR r9, [r13, #-4]!		;Free up register r9 using the stack
			LDR r8, [r6]			;r8 stores a[j]
			LDR r9, [r7]			;r9 stores a[j+1]
			CMP r8, r9				;Compare a[j] and a[j+1]
			STRGT r8, [r7]			;If a[j] > a[j+1] then a[j] = *(a[j+1])
			STRGT r9, [r6]			;If a[j] > a[j+1] then a[j+1] = *(a[j])
			LDR r9, [r13], #4		;Retrieve the old value of register r9
			LDR r8, [r13], #4		;Retrieve the old value of reigster r8
			LDR r12, [SP], #4		;Retrieve the pipelined PC location
			SUB PC, r12, #4			;Adjust the pipelined PC location and save it in PC (i.e. return)
	
a          DCD 44,-56,3,65,-8,32,6,-87,54,65,87,32,65
endOfArray SPACE 4
		   SPACE 32					;reserved room for the stack to grow
stack	   DCD 0x0					;the base of the stack
;----------------------------------------------------
			END
				
 

