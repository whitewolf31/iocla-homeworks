;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS


section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE
    push edx
    shr edx, OFFSET_BITS
    push ebx
tags_loop:
    cmp [ebx], edx
    je found_tag
    add ebx, 4
    pop esi
    push esi
    push ebx
    sub ebx, esi
    cmp ebx, 400
    pop ebx
    jl tags_loop
    jmp not_found
    
found_tag:
    mov esi, ebx
    pop ebx
    pop edx
    sub esi, ebx
    shr esi, 2
    mov edi, 7
    and edi, edx
    shl esi, 3
    add esi, edi
    mov bl, BYTE [ecx + esi]
    mov [eax], bl
    jmp end
not_found:
    pop ebx
    pop edx
    push ecx
    mov cl, BYTE [edx]
    mov [eax], cl
    pop ecx
    mov esi, edx
    shr esi, 3
    mov [ebx + edi * 4], esi
    shl esi, 3
    mov eax, esi
    add eax, 8
    lea ecx, [ecx + edi * 8]
cache_enter:
    push ebx
    mov bl, BYTE [esi]
    mov [ecx], bl
    pop ebx
    inc esi
    inc ecx
    cmp eax, esi
    jg cache_enter
end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


