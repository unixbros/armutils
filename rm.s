@ $armutils: rm.s v 1.0 2016/10/12 22:44:43 dcat Exp $

.globl _start
_start:
	ldr     r6, [sp]      @ r6 = argc
	sub     r6, r6, $1    @ decrease to logical size due to argv[0]

	cmp     r6, $0        @ if argv == 0
	beq     exit          @ 	goto exit
	add     sp, sp, $4    @ *sp++ = argv
next:
	add     r5, r5, $1    @ counter++
	add     sp, sp, $4    @ *argv++
	ldr     r0, [sp]      @ r0 = *argv
unlink:
	mov     r7, $10       @ unlink()
	swi     $0

	cmp     r5, r6        @ if argc != counter
	blt     next          @ if argc <  counter; next()
exit:
	mov     r0, $0        @ r0 = EXIT_SUCCESS
	mov     r7, $1        @ exit()
	swi     $0

