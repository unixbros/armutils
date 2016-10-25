@ $armutils: cat.s v 1.0 2016/10/21 16:43:28 dcat Exp $

@ get and parse args
@ print files;
@ 	stat() file/get size
@ 	brk() file size
@ 	read() file
@ 	write() to stdout

.globl _start
_start:
	ldr     r6, [sp]      @ r6 = argc
	sub     r6, r6, $1    @ decrease to logical size due to argv[0]

	cmp     r6, $0        @ if argv == 0
	beq     exit          @ 	goto exit

	add     sp, sp, $4    @ *sp++ = argv @
next:
	add     r5, r5, $1    @ counter++
	add     sp, sp, $4    @ *argv++
	ldr     r1, [sp]      @ r1 = *argv

	ldr     r0, [sp]      @ r0 = *argv
	mov     r2, $-1       @ argv_counter = -1
stat:
	mov     r7, $106      @ stat()
	swi     $0
brk:
	mov     r7, $45       @ brk()
	swi     $0
read:
	mov     r7, $3        @ read()
	swi     $0
write:
	mov     r0, $1        @ r0 = stdout
	mov     r7, $4        @ write()
	swi     $0

	cmp     r5, r6        @ if argc != counter
	blt     next          @ 	goto next
exit:
	mov     r0, $0        @ r0 = EXIT_SUCCESS
	mov     r7, $1        @ exit()
	swi     $0
