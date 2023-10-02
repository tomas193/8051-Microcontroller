mov 30H,#231d
mov 31H,#65d
mov 32H,#56d
mov 33H,#31d
mov 34H,#238d
mov 35H,#150d
mov 36H,#95d
mov 37H,#137d
mov 38H,#98d
mov 39H,#242d

mov r0,#18h
mov a,#30h
index:
mov @r0,a
inc a
inc r0
cjne a,#3ah,index

mov p0,#0FFH
inicio:
jnb p0.0,asc
jnb p0.1,des
jmp inicio

asc:
mov R0, #30H
MOV R1,#31H
mov r3,#0h
mov b,#0d
loop:
mov A, @R1
SUBB A,@R0
jc swp

back:
orl C,b.0
mov b.0,c
inc r3
inc r0
inc r1
cjne r3,#09h,loop
mov c,b.0
jnc inicio
inc r2
cjne r2,#09h,asc
jmp inicio

des:
mov R0, #30H
MOV R1,#31H
mov r3,#0h
mov b,#1d
loop1:
mov A, @R1
SUBB A,@R0
jnc swp

back2:
anl C,b.0
mov b.0,c
inc r3
inc r0
inc r1
cjne r3,#09h,loop1
mov c,b.0
jc inicio
inc r2
cjne r2,#09h,des
jmp inicio

swp:
mov a,@r1
mov r7,a
MOV a,@R0
mov @R1,A
mov a,r7
MOV @R0,a
jnb p0.0,back
jnb p0.1,back2
end
