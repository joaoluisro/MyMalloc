.section .data
  A: .quad 0
  B: .quad 0
  TOPO_HEAP: .quad
  NOVO_TOPO: .quad
.section .text
.globl meuMalloc
meuMalloc:
  pushq %rbp
  movq %rsp, %rbp
  movq $12, %rax
  syscall
  movq %rax, TOPO_HEAP
  addq $10, NOVO_TOPO
  movq  NOVO_TOPO, %rdi
  movq $12, %rax
  syscall
  popq %rbp
  ret
.globl mal
mal:
  pushq %rbp
  movq %rsp, %rbp
  movq $12, %rax
  syscall
  popq %rbp
  ret
