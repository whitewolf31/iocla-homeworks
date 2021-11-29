; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE
    xor eax, eax
age_loop:
    push edx
    push ecx
    mov edx, DWORD [edi + eax * 8 + 4] ; current date year
    mov ebx, DWORD [esi + 4] ; present year
    cmp edx, ebx
    jg invalid_date
    mov ecx, ebx
    sub ecx, edx
    movzx edx, WORD [edi + eax * 8 + 2] ; current date month
    movzx ebx, WORD [esi + 2] ; present month
    cmp edx, ebx
    jg bigger
    jl smaller
    movzx edx, WORD [edi + eax * 8] ; current date day
    movzx ebx, WORD [esi] ; present day
    cmp edx, ebx
    jg bigger
    jle smaller
smaller:
    mov edx, ecx
    jmp write_age
bigger:
    mov edx, ecx
    cmp edx, 0
    je invalid_date
    dec edx
    jmp write_age
write_age:
    pop ecx
    mov [ecx + eax * 4], DWORD edx
    jmp continue_loop
invalid_date:
    pop ecx
    mov [ecx + eax * 4], DWORD 0
continue_loop:
    inc eax
    pop edx
    cmp eax, edx
    jl age_loop

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
