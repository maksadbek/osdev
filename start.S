.section .text
.global _entry

_entry:
    la      t0, user
    csrw    mepc, t0
    la      t1, m_trap
    csrw    mtvec, t1
    li      t2, 0x1800
    csrc    mstatus, t2
    li      t3, 0x800
    csrs    mstatus, t3
    li      t4, 0x100
    csrs    medeleg, t4
    
    
    lui a5, 0x10000
    li a4, 75
    sb a4, 0(a5)

    mret

m_trap:
    csrr    t0, mepc
    csrr    t1, mcause
    la      t2, user
    csrw    mepc, t2

    li t3, 11
    beq t1, t3, handle_syscall
    
    mret

handle_syscall:
    lui a5, 0x10000
    li a4, 75
    sb a4, 0(a5)

    mv t0, a0
    li t1, 1
    beq t0, t1, syscall_debug

    j park

syscall_debug:
    lui     a5, 0x10000
    li      a4, 42
    sb      a4, 0(a5)
    # csrr    t0, mepc
    # addi    t0, t0, 4
    la      t2, user
    csrw    mepc, t2
    
user:
    li a0, 1
    ecall
    j user

park:
    lui a5, 0x10000
    li a4, 75
    sb a4, 0(a5)
    wfi
    j park


