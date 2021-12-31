global get_words
global compare_func
global sort
extern strtok
extern strlen
extern strcmp
extern qsort

section .data
    delimiters db " ,.", 10, 0
section .text

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix
sort:
    enter 0, 0
    push  cmp_func   ; we first push the function
    push  DWORD [ebp + 16] ; we push sizeof(char *)
    push  DWORD [ebp + 12] ; we push number_of_words
    push  DWORD [ebp + 8]  ; we push **words
    call  qsort
    add   esp, 16          ; disalloc params
    leave
    ret

cmp_func:
    enter 0, 0
    mov   eax, [ebp + 12]  ; eax now holds a char**
    push  DWORD [eax]      ; prepare for strlen
    call  strlen
    add   esp, 4           ; disalloc params
    push  eax
    mov   eax, [ebp + 8]   ; ebx now holds a char**
    push  DWORD [eax]      ; prepare for strlen
    call  strlen
    add   esp, 4
    sub   eax, DWORD [ebp - 4]   ; substract from first len, second len
    add   esp, 4           ; disalloc value from stack
    cmp   eax, 0
    jne   cmp_func_end
    mov   eax, [ebp + 12]  ; second char**
    push  DWORD [eax]   
    mov   eax, [ebp + 8]   ; first char**
    push  DWORD [eax]
    call  strcmp
    add   esp, 8           ; disalloc stack allignment -> we can leave directly because result is in eax
cmp_func_end:
    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte
get_words:
    enter 0, 0
    push  delimiters    ; second parameter of strtok
    push  DWORD [ebp + 8]    ; first parameter of strtok
    call  strtok
    add   esp, 8       ; disalloc parameters from stack
    cmp   eax, 0       ; compare result of strtok with NULL
    je    end
    xor   ecx, ecx     ; our counter
strtok_loop:
    mov   ebx, [ebp + 12]         ; ebx is now **words
    mov   [ebx + ecx * 4], eax    ; add to words array the current word
    inc   ecx
    push  ebx                     ; saving registers before strtok call
    push  ecx
    push  delimiters
    push  0x0                     ; strtok is now called with NULL
    call  strtok
    add   esp, 8                  ; disalloc parameters from stack
    pop   ecx
    pop   ebx
    cmp   eax, 0
    ja    strtok_loop
end:
    leave
    ret
