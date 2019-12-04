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

  mov %rdi, %rdx       # rdx <- tamanho
  call alturabrk       # pega valor antigo de brk

  mov %rax, %rsi       # rsi <- valor brk antigo
  add %rdx, %rax
  add $24, %rax
  mov %rax, %rdi
  mov $12, %rax
  syscall              # arranja espaço

  mov %rsi, %rax
  movq $1, (%rax)      # validez = 1
  movq %rdx, 8(%rax)   # tamanho_bloco = tamanho
  mov %rsi, %rbx
  addq $48, %rbx
  addq %rdx, %rbx
  movq %rbx, 16(%rax)  # proximo_bloco = proximo

  mov %rsi, %rax       # retorna primeiro end.
  addq $24, %rax
  popq %rbp
  ret

.globl desalocaMem
desalocaMem:
  pushq %rbp
  movq %rsp, %rbp
  movq $0, -24(%rdi)
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
