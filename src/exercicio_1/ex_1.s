.section .data
  topoInicialHeap: .quad 0
  head: .quad 0
  tail: .quad 0
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
  movq %rdi, %rdx
  jmp verifica

  aloca_fim:
    call alturabrk        # pega valor antigo de brk

    movq %rax, %rsi        # rsi <- valor brk antigo
    addq %rdx, %rax
    add $24, %rax
    movq %rax, %rdi
    movq $12, %rax
    syscall              # arranja espaço

    movq %rsi, %rax
    movq $1, (%rax)      # validez = 1
    movq %rdx, 8(%rax)    # tamanho_bloco = tamanho
    movq %rsi, %rbx
    addq $48, %rbx
    addq %rdx, %rbx
    movq %rbx, 16(%rax)  # proximo_bloco = proximo

    movq %rsi, %rax       # retorna primeiro end.
    addq $24, %rax

    cmpq $0, head
    jne adiciona
    movq %rax, head
    adiciona:
      movq %rax, tail

    popq %rbp
    ret

  aloca_meio:
    movq %rsi ,%rax
    movq %rdx, -16(%rsi)
    movq $1, -24(%rsi)
    popq %rbp
    ret

  verifica:
    call alturabrk
    cmpq topoInicialHeap, %rax   # verifica se a lista é vazia
    jne itera
    jmp aloca_fim

  itera:
    movq head, %rsi
    while:
      cmpq $0, -24(%rsi)
      jne continue
      cmpq %rdi, -16(%rsi)
      jge aloca_meio
      continue:
        cmpq %rsi, tail
        je aloca_fim
        movq -8(%rsi), %rsi

      jmp while

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
