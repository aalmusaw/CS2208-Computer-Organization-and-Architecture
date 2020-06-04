     AREA prog1, code, READONLY
     ENTRY
     MOV r3,#2
     LDR r1, =0xCCCCCCCC ;in binary 1100 1100 1100 1100 1100 1100 1100 1100
	 
     LSL r1,r1,#5
     LSL r1,r1,r3
     LSR r1,r1,#10
     LSR r1,r1,r3
     ASR r1,r1,#2	 
     LSL r1,r1,#15
     ASR r1,r1,#16
	 
     ASR r1,r1,r3
	
     ROR r1,r1,#4	 
     ROR r1,r1,r3
     RRX r1,r1
     RRX r1,r1
     RRX r1,r1	
     RRX r1,r1	 
loop B   loop
     END