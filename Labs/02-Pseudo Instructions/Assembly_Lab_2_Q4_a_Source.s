     AREA prog1, CODE, READONLY
     ENTRY
     LDR r0, = 0x12345678 
loop B loop

     AREA prog1, DATA, READONLY
X    DCD 0x70707070 
     END