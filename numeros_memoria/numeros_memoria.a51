ORG 00H
	MOV P0,#0FFH
	MOV R0,#30H
	MOV R1,#50H
	leer:
	MOV A,P0
	MOV R2,A
	CJNE A,#0,inicio
	jmp leer
	
	inicio:
	MOV 30H,P0
	CPL A
	INC A
	MOV 50H,A
	loop:
	MOV A,R2
	INC A
	INC R0
	INC R1
	MOV R2,A
	MOV @R0,A
	CPL A
	INC A
	MOV @R1,A
	CJNE R0,#50H,loop
	fin:
	NOP
	JMP fin
	END
	