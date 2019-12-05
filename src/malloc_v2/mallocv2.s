.section .data
  topoInicialHeap: .quad 0
  topoHeap: .quad 0
.section .text
.globl _start
.globl iniciaAlocador
iniciaAlocador:
  pushq %rbp
  movq %rsp, %rbp
  call alturabrk
  movq %rax, topoInicialHeap
  popq %rbp
  ret

.globl finalizaAlocador
finalizaAlocador:
  pushq %rbp
  movq %rsp, %rbp
  movq topoInicialHeap, %rdi
  movq $12, %rax
  syscall
  popq %rbp
  ret

.globl alocaMem
alocaMem:
  pushq %rbp
  movq %rsp, %rbp

  movq %rdi, %rdx       # rdx <- tamanho
  call alturabrk       # pega valor antigo de brk

  movq %rax, %rsi       # rsi <- valor brk antigo
  add %rdx, %rax
  add $24, %rax
  movq %rax, %rdi
  movq $12, %rax
  syscall              # arranja espaço

  movq %rsi, %rax
  movq $1, (%rax)      # validez = 1
  movq %rdx, 8(%rax)   # tamanho_bloco = tamanho
  movq %rsi, %rbx
  addq $48, %rbx
  addq %rdx, %rbx
  movq %rbx, 16(%rax)  # proximo_bloco = proximo

  movq %rsi, %rax       # retorna primeiro end.
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
  movq %rsp, %rbp
  movq $12, %rax
  movq $0, %rdi
  syscall
  popq %rbp
  ret
