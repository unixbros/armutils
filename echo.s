@ $armutils: echo.s v 1.0 2016/01/17 15:47:48 dcat Exp $

.globl _start
_start:
	ldr     r6, [sp]      @ r6 = argc
	sub     r6, r6, $1    @ decrease to logical size due to argv[0]

	cmp     r6, $0        @ if argv == 0
	beq     term          @ 	goto term

	add     sp, sp, $4    @ *sp++ = argv @
	b       next          @ 	goto next
next:
	add     r5, r5, $1    @ counter++
	add     sp, sp, $4    @ *argv++
	ldr     r1, [sp]      @ r1 = *argv

	ldr     r0, [sp]      @ r0 = *argv
	mov     r2, $-1       @ argv_counter = -1
strlen:
	ldrb    r9, [r0], $1  @ r9 == *argv++
	add     r2, r2, $1    @ length for write()
	cmp     r9, $0        @ if r9 == 0
	bne     strlen        @ 	goto strlen
write:
	mov     r0, $1        @ r0 = stdout
	mov     r7, $4        @ write()
	swi     $0

	cmp     r5, r6        @ if argc != counter
term:
	mov     r0, $1        @ r0 = stdout
	ldrlt   r1, =sp       @ if argc <  counter; r1 = space
	ldrge   r1, =nl       @ if argc >= counter; r1 = newline
	mov     r2, $1        @ r2 = len
	mov     r7, $4        @ write()
	swi     $0

	blt     next          @ if argc <  counter; next()
exit:
	mov     r0, $0        @ r0 = EXIT_SUCCESS
	mov     r7, $1        @ exit()
	swi     $0

.data
nl: .ascii "\n"
sp: .ascii " "

