@ $armutils: pwd.s v 1.0 2016/10/12 23:10:37 dcat Exp $

.globl _start
_start:
getcwd:
	mov     r7, $183
	ldr     r0, =pwd
	mov     r1, $4096
	swi     $0

	mov     r2, $0
	ldr     r0, =pwd
strlen:
	ldrb    r9, [r0], $1
	add     r2, r2, $1

	cmp     r2, $4096
	bge     write

	cmp     r9, $0
	bne     strlen
	ldr     r1, =pwd
	ldr     r4, =pwd
write:
	mov     r0, $1
	mov     r7, $4
	swi     $0

	cmp     r4, r1
	ldr     r1, =nl
	mov     r2, $1
	beq     write
exit:
	mov     r0, $0
	mov     r7, $1
	swi     $0

.data
nl: .ascii "\n"

.bss
pwd: .space 4096
