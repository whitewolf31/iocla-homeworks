section .data
    extern len_cheie, len_haystack

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov     edi, [ebp + 8]   ;key
    mov     esi, [ebp + 12]  ;haystack
    mov     ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE
    
    xor     eax, eax
    push    eax
    push    eax
key_loop:
    pop     eax
    pop     edx
    mov     ecx, [edi + edx * 4] ; offset
    push    edx
    push    eax
    xor     eax, eax
cipher_loop:
    push    eax
    push    ecx                      ; store offset and idx on stack
    mov     ecx, DWORD [len_cheie]
    mul     ecx
    pop     ecx
    add     eax, ecx
    mov     edx, DWORD [len_haystack]
    cmp     eax, edx
    jge     check_next               ; if we're done with current column, move to next
    mov     dl, BYTE [esi + eax]
    add     esp, 4
    pop     eax
    mov     [ebx + eax], dl          ; write to result address
    inc     eax
    push    eax
    sub     esp, 4
    pop     eax
    inc     eax
    jmp     cipher_loop

check_next:
    pop     eax
    pop     eax
    pop     edx
    mov     ecx, DWORD [len_cheie] 
    inc     edx
    push    edx
    push    eax
    cmp     edx, ecx
    jl      key_loop                 ; if the key is not over yet, go back
    
    pop     eax
    pop     eax
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
