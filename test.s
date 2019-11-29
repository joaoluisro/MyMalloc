.section .data
  A: .quad 0
  B: .quad 0
.section .text
.globl _start
f:
  pushq %rbp
  movq $4, %rax
  movq $2, %rbx
  addq %rax, %rbx
  movq %rbx, %rax
  popq %rbp
  ret
_start:
  movq $6, A
  movq $7, B
  movq A, %rax
  movq B, %rbx
  call f
  addq %rbx, %rax
  movq $60, %rax
  movq %rbx, %rdi
  syscall
