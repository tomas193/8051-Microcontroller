ORG 00H
	MOV P0, #0FFH
	inicio:
	MOV P3, #000H
	MOV C, P0.0
	JNC derecha
	MOV C, P0.1
	JNC izquierda
	JMP inicio
	
	derecha:
	MOV A, #002H
	loop:
	MOV P3, A
	RL A
	LCALL del
	CJNE A,#020H,loop
	MOV C, P0.0
	JNC derecha
	JMP inicio

	izquierda:
	MOV A, #010H
	loop1:
	MOV P3, A
	RR A
	LCALL del
	CJNE A,#001H,loop1
	MOV C, P0.1
	JNC izquierda
	jmp inicio

del:MOV R2, #001H
tre:MOV R1, #005H
dos:MOV R0, #0FEH
uno:DJNZ R0, uno
	DJNZ R1, dos
	DJNZ R2, tre
	RET 
END
	