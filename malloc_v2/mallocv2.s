.section .data
  topoInicialHeap: .quad 0
  topoHeap: .quad 0
.section .text
.globl _start
.globl iniciaAlocador
iniciaAlocador:
  pushq %rbp
  mov %rsp, %rbp
  call alturabrk
  mov %rax, topoInicialHeap
  popq %rbp
  ret

.globl finalizaAlocador
finalizaAlocador:
  pushq %rbp
  mov %rsp, %rbp
  mov topoInicialHeap, %rdi
  mov $12, %rax
  syscall
  popq %rbp
  ret

.globl alocaMem
alocaMem:
  pushq %rbp
  mov %rsp, %rbp

  mov %rdi, %rdx
  call alturabrk
  mov %rax, topoHeap
  add %rdx, %rax
  mov %rax, %rdi
  mov $12, %rax
  syscall
  mov topoHeap, %rax

  popq %rbp
  ret

.globl alturabrk
alturabrk:
  pushq %rbp
  mov %rsp, %rbp
  mov $12, %rax
  mov $0, %rdi
  syscall
  popq %rbp
  ret
