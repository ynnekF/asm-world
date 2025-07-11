section .data
    hello_msg db "Hello, World!", 0xA  ; Message with newline
    hello_len equ $ - hello_msg        ; Length of the message

section .text
    global _start

_start:
    ; write syscall (syscall number 1)
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    mov rsi, hello_msg  ; pointer to message
    mov rdx, hello_len  ; message length
    syscall

    ; exit syscall (syscall number 60)
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; exit code: 0
    syscall
