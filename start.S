.section .text
.global _entry

_entry:
    la sp, stack0
    li a0, 1024*4
    csrr a1, mhartid
    addi a1, a1, 1
    mul a0, a0, a1
    add sp, sp, a0
    call start
park:
    lui	a5, 0x10000
    li	a4, 75
    sb	a4, 0(a5)
    wfi
    j park
