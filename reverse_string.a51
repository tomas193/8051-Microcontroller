ORG 00H
DB0 EQU P1.0
DB1 EQU P1.1
DB2 EQU P1.2
DB3 EQU P1.3
DB4 EQU P1.4
DB5 EQU P1.5
DB6 EQU P1.6
DB7 EQU P1.7
EN EQU P3.7
RS EQU P3.6
RW EQU P3.5
DATAS EQU P1
mov r0,#0d
mov r1,#0d
mov r2,#0d
mov a,#0d
jmp reverso

ORG 50H
nombre:db "J.Tomas AraujoG",00H
	
	write_name:
LCALL INIT_LCD
LCALL CLEAR_LCD

mov dptr,#nombre
loop:
mov a, #00h
movc a,@a+dptr
JZ idle
LCALL WRITE_TEXT
inc dptr
jnz loop

idle:jmp idle


WAIT_LCD:
CLR EN ;Start LCD command
CLR RS ;It's a command
SETB RW ;It's a read command
MOV DATAS,#0FFh ;Set all pins to FF initially
SETB EN ;Clock out command to LCD
MOV A,DATAS ;Read the return value
JB ACC.7,WAIT_LCD ;If bit 7 high, LCD still busy
CLR EN ;Finish the command
CLR RW ;Turn off RW for future commands
RET

INIT_LCD:
CLR RS
MOV DATAS,#38h
SETB EN
CLR EN
LCALL WAIT_LCD
CLR RS
MOV DATAS,#0Eh
SETB EN
CLR EN
LCALL WAIT_LCD
CLR RS
MOV DATAS,#06h
SETB EN
CLR EN
LCALL WAIT_LCD
RET

CLEAR_LCD:
CLR RS
MOV DATAS,#01h
SETB EN
CLR EN
LCALL WAIT_LCD
RET

WRITE_TEXT:
SETB RS
MOV DATAS,A
SETB EN
CLR EN
LCALL WAIT_LCD
RET

reverso:
mov dptr,#nombre
loop2:
mov a,#0d
movc a,@a+dptr
mov r1,#20h
subb a,r1
jz disp_name
regreso:
mov a,#0d
movc a,@a+dptr
inc dptr
inc r0
inc r2
jnz loop2
jmp apellido

disp_name:
LCALL INIT_LCD
LCALL CLEAR_LCD
print1:
dec r0
mov dptr,#nombre
mov a, r0
movc a,@a+dptr
LCALL WRITE_TEXT
cjne r0,#0h,print1

dptr_pos:
mov a,r2
mov r0,a
loop9:
dec r0
inc dptr
cjne r0,#0h,loop9
//print espacio
mov a,#0h
movc a,@a+dptr
LCALL WRITE_TEXT
jmp regreso

apellido:
dec r2
loop8:
dec r2
mov dptr,#nombre
mov a,r2
movc a,@a+dptr
LCALL WRITE_TEXT
cjne a,#20h,loop8
jmp idle



END
