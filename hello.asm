global      start

        section     .data
msg  db          'Hello world! 0123456789'

        section     .text
start:   
    mov rcx, 0
    mov r9, 0
    mov r10, 1
    mov r11, 0
rpt:
    mov r11, r9
    add r11, r10
    mov r9, r10
    mov r10, r11
    mov rax, r9
    call iprint
    call endl
    inc rcx
    cmp rcx, 30
    jl rpt

call quit
        

; Function get string length
; Param     
;       rax     string address
; Output
;       rax     string length
strlen: 
    push    rbx         ;save rbx since we gonna use it
    mov     rbx, rax    ; address in rbx to save 
nextchar:
    cmp byte [rax], 0   ; byte at rax's addr == 0?
    je  finished        ; if equal -> jump
    inc rax             ; rax addr += 1
    jmp nextchar

finished:
    sub rax, rbx
    pop rbx
    ret

sprint:
    push    rcx ; rcx is used by the syscall :@
    push    rdx ; save register we gonna use
    push    rdi
    push    rsi
    push    rax

    call strlen ; msg in rax, get its length

    mov     rdx, rax    ; param buf_len = result of call
    pop     rax         ; Retrieve the message

    mov     rsi, rax    ; param buf_str
    mov     rax, 0x02000004 ;function to use (#4 -> write)
    mov     rdi, 1      ; output file (1 -> stdout)
    syscall

    pop     rsi     ; load our saved registers
    pop     rdi
    pop     rdx
    pop     rcx
    ret

quit:
    mov     rax, 0x02000001 ;exit function
    mov     rdi, 0x00       ;param return 
    syscall
        

iprint:
    push    rax
    push    rcx
    push    rdx
    push    rsi

    mov     rcx, 0  ;no number

deviding_loop:
    inc     rcx         ; +1 per loop
    mov     rdx, 0
    mov     rsi, 10
    idiv    rsi         ;devide rax by rsi. store result in rax and rest in rdx
    add     rdx, 48
    push    rdx
    cmp     rax, 0
    jne     deviding_loop

printing_loop:
    dec     rcx         ; -1 per loop
    mov     rax, rsp
    call    sprint
    pop     rax         ; remove 1 elem from the stack
    cmp     rcx, 0
    jnz     printing_loop

    pop     rsi
    pop     rdx
    pop     rcx
    pop     rax
    ret

endl:               ; print a new line
    push    rax
    mov     rax, 10
    push    rax
    mov     rax, rsp
    call    sprint
    pop     rax
    pop     rax
    ret
