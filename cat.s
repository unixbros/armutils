@ $armutils: cat.s v 1.0 2016/10/21 16:43:28 dcat Exp $

.global _start
_start:
        ldr   r6, [sp]
        sub   r6, r6, $1

        mov   r0, $1
        cmp   r6, $0
        beq   exit

        add   sp, sp, $4
next:
        add   r5, r5, $1
        add   sp, sp, $4
        ldr   r0, [sp]
open:
        mov   r7, $5
        mov   r1, $0
        swi   $0

        mov   r8, r0
stat:
        mov   r7, $108
        ldr   r1, =sb
        swi   $0

1:
        ldr   r4, =st_size
        ldr   r3, [r4]
        mov   r1, r8

output:
        mov   r7, $187
        mov   r0, $1
        mov   r2, $0
        swi   $0
close:
        mov   r7, $6
        mov   r0, r8
        swi   $0
2:
        cmp   r5, r6
        ble   next
        mov   r0, $0
exit:
        mov   r7, $1
        swi   $0

.bss
sb:
        __pad0:  .space 20
        st_size: .space 32
        __pad1:  .space 76

