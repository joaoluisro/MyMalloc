.section .data
  topoInicialHeap: .quad 0
  head: .quad 0
  tail: .quad 0
  tamanho_disponivel: .quad 0
  ender_corrente: .quad 0
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
  movq $4096, %r8
  aumento:
    cmpq %r8,%rdx
    jl fim_aumento
    addq $4096, %r8
    jmp aumento
  fim_aumento:
  cmpq tamanho_disponivel, %rdx
  jge bloco_novo
  jmp verifica
  bloco_novo:
    cmpq $0, ender_corrente
    je primeiro
    movq ender_corrente,%rax
    addq %r8, %rax
    movq %r8, tamanho_disponivel
    movq %rax, %rdi
    movq $12, %rax
    syscall
    jmp verifica

    primeiro:
      call alturabrk
      movq %rax, ender_corrente
      movq %r8, tamanho_disponivel
      addq %r8, %rax
      movq %rax,%rdi
      movq $12,%rax
      syscall
      jmp verifica

  aloca_fim:
    movq tail, %rbx
    cmpq %rbx, head
    je nova
      movq tail, %rsi
      movq -8(%rsi), %rbx
      movq %rbx, ender_corrente
      subq $24, ender_corrente
    nova:
    movq ender_corrente, %rax
    movq $1, (%rax)                 # validez = 1
    movq %rdx, 8(%rax)              # tamanho_bloco = tamanho
    movq %rax, %rbx
    addq $48, %rbx
    addq %rdx, %rbx
    movq %rbx, 16(%rax)             # proximo_bloco = proximo
    continua:
    movq ender_corrente, %rax
    addq $24, %rax

    cmpq $0, head
    jne adiciona
    movq %rax, head
    adiciona:
      movq %rax, tail

    addq %rdx, ender_corrente
    addq $24, ender_corrente

    popq %rbp
    ret

  aloca_meio:
    movq %rsi ,%rax
    movq %rdx, -16(%rsi)
    movq $1, -24(%rsi)
    addq %rdx, ender_corrente
    addq $24, ender_corrente
    popq %rbp
    ret

  verifica:
    movq ender_corrente, %rax
    subq %rdx, tamanho_disponivel
    subq $24, tamanho_disponivel
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
  movq head, %rsi
  while_ext:
    cmpq tail, %rsi
    je fim_while_ext
    cmpq $0, -24(%rsi)
    je fusao_nos
    pos_fusao:
      movq -8(%rsi), %rsi
      jmp while_ext
  fim_while_ext:

  popq %rbp
  ret

  fusao_nos:
    movq -8(%rsi), %rcx
    movq -16(%rsi), %r9
    while_nos:
      cmpq %rcx, tail
      je fim_while_nos
      cmpq $0, -24(%rcx)
      jne fim_while_nos
      addq -16(%rcx), %r9
      movq -8(%rcx), %rcx
      jmp while_nos
    fim_while_nos:
      movq %r9, -16(%rsi)
      movq %rcx, -8(%rsi)
      jmp pos_fusao



.globl alturabrk
alturabrk:
  pushq %rbp
  movq %rsp, %rbp
  movq $12, %rax
  movq $0, %rdi
  syscall
  popq %rbp
  ret

.globl tam_dis
tam_dis:
  pushq %rbp
  movq %rsp, %rbp
  movq tamanho_disponivel, %rax
  popq %rbp
  ret

  .globl end_cor
  end_cor:
    pushq %rbp
    movq %rsp, %rbp
    movq ender_corrente, %rax
    popq %rbp
    ret

.globl ret_tail
ret_tail:
    pushq %rbp
    movq %rsp, %rbp
    movq tail, %rax
    popq %rbp
    ret

.globl ret_head
ret_head:
    pushq %rbp
    movq %rsp, %rbp
    movq head, %rax
    popq %rbp
    ret
