.section .data
  topoInicialHeap: .quad 0
  head: .quad 0
  tail: .quad 0
  best_pos: .quad 0
  best_tam: .quad 0
  tipo_fit: .quad 0
  next: .quad 0

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
    cmpq $1, tipo_fit
    je first_fit
    cmpq $2, tipo_fit
    je best_fit
    cmpq $3, tipo_fit
    je next_fit

    first_fit:
      cmpq $0, -24(%rsi)
      jne continue
      cmpq %rdx, -16(%rsi)
      jge aloca_meio
      continue:
        cmpq %rsi, tail
        je aloca_fim
        movq -8(%rsi), %rsi
        jmp first_fit

    best_fit:
      movq -16(%rsi),%r9
      call ret_tail
      movq %rax, best_pos
      loop_bf:
      movq $0, -24(%rsi)
      jne keep_bf
      cmpq %r9, -16(%rsi)
      jle keep_bf
      movq %r9, best_tam
      movq %rsi, best_pos
      keep_bf:
        movq -8(%rsi), %rsi
        cmpq %rsi, tail
        jge fim_bf
        jmp loop_bf
      fim_bf:
        movq best_pos, %rsi
        cmpq %rsi, tail
        je aloca_fim
        jmp aloca_meio

      next_fit:
      cmpq $0, next
      je start_nf
      movq next, %rsi
      start_nf:
      cmpq $0, -24(%rsi)
      jne continue_nf
      cmpq %rdx, -16(%rsi)
      jge aloca_meio
      continue_nf:
        movq %rsi, next
        cmpq %rsi, tail
        je aloca_fim
        movq -8(%rsi), %rsi
        jmp start_nf



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

.globl setfit
setfit:
  pushq %rbp
  movq %rsp, %rbp
  movq %rdi, tipo_fit
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
