.section .data
  topoInicialHeap: .quad
.section .text
.globl iniciaAlocador
iniciaAlocador:
  pushq %rbp
  movq %rsp, %rbp
  movq $12, %rax
  movq $0, %rdi
  syscall
  movq %rax, topoInicialHeap
  popq %rbp
  ret

.globl finalizaAlocador
finalizaAlocador:
  pushq %rbp
  movq %rsp, %rbp
  movq $12, %rax
  movq topoInicialHeap, %rdi
  syscall
  popq %rbp
  ret

.globl alocaMem
alocaMem:
  pushq %rbp
  movq %rsp, %rbp
  movq %rdi, %rbx
  movq $12, %rax
  movq $0, %rdi
  syscall
  addq %rax, %rbx
  movq %rbx, %rdi
  movq $12, %rax
  syscall
  popq %rbp
  ret
