.section .data
  A: .quad 0
  B: .quad 0
.section .text
.globl f
f:
  pushq %rbp
  movq %rsp, %rbp
  subq $16, %rsp
  movq A, %rax
  movq B, %rbx
  movq %rax, -16(%rbp)
  movq %rbx, -8(%rbp)
  movq -8(%rbp), %rax
  movq -16(%rbp), %rbx
  addq %rax, %rbx
  addq $16, %rsp
  addq $10, %rax
  popq %rbp
  ret
# _start:
#  movq $4, A
#  movq $5, B
#  call f
#  movq %rbx, %rdi
  # movq  %rax, A
  # movq A, %rdi
#  movq $60, %rax
#  syscall
