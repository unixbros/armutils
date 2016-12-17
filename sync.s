@ $armutils: sync.s v 1.0 2016/10/12 22:47:37 dcat Exp $

.globl _start
_start:
sync:
	mov     r7, $36
	swi     $0
exit:
	mov     r0, $0 @ r0 = EXIT_SUCCESS
	mov     r7, $1 @ exit()
	swi     $0
