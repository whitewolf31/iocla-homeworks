OPEN_PARAN equ 40
CLOSED_PARAN equ 41
PLUS equ 43
MINUS equ 45
ASTERISK equ 42
DIVIDE equ 47
section .text

extern strlen
extern atoi
global expression
global term
global factor

; `factor(char *p, int *i)`
;       Evaluates "(expression)" or "number" expressions 
; @params:
;	p -> the string to be parsed
;	i -> current position in the string
; @returns:
;	the result of the parsed expression
factor:
        push    ebp
        mov     ebp, esp
        sub     esp, 24
        mov     DWORD [ebp - 4], 1     ; int shouldAdd = 1
        mov     DWORD [ebp - 8], 1     ; int result = 1;
        mov     DWORD [ebp - 12], 0    ; int paranthesesOpened = 0
        mov     eax, [ebp + 8]         ; eax is p
        mov     DWORD [ebp - 16], eax  ; char *currentExpression = p
        mov     DWORD [ebp - 20], eax  ; char *buffer = p
first_factor_while:
        mov     eax, [ebp - 20]         ; compare with open paranthases
        cmp     BYTE [eax], OPEN_PARAN
        jne     check_factor_2
        inc     DWORD [ebp - 12]        ; paranthesesOpened++
check_factor_2:
        cmp     BYTE [eax], CLOSED_PARAN ; compare with closed parantheses
        jne     check_factor_3
        dec     DWORD [ebp - 12]        ; paranthesesOpened--
check_factor_3:
        cmp     BYTE [eax], ASTERISK        ; go to paranth check if *buffer == +
        je      paranth_factor_check
        cmp     BYTE [eax], DIVIDE
        je      paranth_factor_check
        jmp     check_factor_end
paranth_factor_check:
        cmp     DWORD [ebp - 12], 0
        jne     check_factor_end          ; paranthases not ok
        mov     bl, BYTE [eax]  
        mov     BYTE [ebp - 24], bl     ; char oldChar = *buffer
        mov     BYTE [eax], 0
        push    DWORD [ebp + 12]        ; prepare for func call
        push    DWORD [ebp - 16]
        call    expression
        add     esp, 8
        cmp     DWORD [ebp - 4], 1      ; check should add
        jne     should_factor_sub
        imul    DWORD [ebp - 8]
        mov     [ebp - 8], eax          ; start multiplying
        jmp     should_factor_sub_if_end
should_factor_sub:
        mov     ecx, eax                ; performin division
        mov     eax, [ebp - 8]
        cdq
        idiv    ecx
        mov     [ebp - 8], eax
should_factor_sub_if_end:
        mov     al, BYTE [ebp - 24]
        mov     edx, [ebp - 20]
        mov     BYTE [edx], al
        cmp     al, BYTE ASTERISK
        jne     change_factor_should_add
        mov     DWORD [ebp - 4], 1
        jmp     change_factor_should_end
change_factor_should_add:
        mov     DWORD [ebp - 4], 0
change_factor_should_end:
        mov     eax, [ebp - 20]       ; eax is buffer
        inc     eax
        mov     [ebp - 16], eax       ; currentExpression = buffer + 1
check_factor_end:
        inc     DWORD [ebp - 20]
        mov     eax, [ebp - 20]
        cmp     BYTE [eax], 0
        jne     first_factor_while
        push    DWORD [ebp + 12]      ; prepare for func call
        push    DWORD [ebp - 16]      ; currentExpression push
        call    expression
        add     esp, 8
        mov     ecx, [ebp - 8]
        cmp     DWORD [ebp - 4], 1
        jne     should_factor_sub_end
        imul    ecx
        jmp     factor_func_end
should_factor_sub_end:
        mov     ecx, eax
        mov     eax, [ebp - 8]
        cdq
        idiv    ecx
factor_func_end:
        add     esp, 24
        leave
        ret

; `term(char *p, int *i)`
;       Evaluates "factor" * "factor" or "factor" / "factor" expressions 
; @params:
;	p -> the string to be parsed
;	i -> current position in the string
; @returns:
;	the result of the parsed expression
term:
        push    ebp
        mov     ebp, esp
        sub     esp, 24
        mov     DWORD [ebp - 4], 1     ; int shouldAdd = 1
        mov     DWORD [ebp - 8], 0     ; int result = 0;
        mov     DWORD [ebp - 12], 0    ; int paranthesesOpened = 0
        mov     eax, [ebp + 8]         ; eax is p
        mov     DWORD [ebp - 16], eax  ; char *currentExpression = p
        mov     DWORD [ebp - 20], eax  ; char *buffer = p
first_term_while:
        mov     eax, [ebp - 20]         ; compare with open paranthases
        cmp     BYTE [eax], OPEN_PARAN
        jne     check_term_2
        inc     DWORD [ebp - 12]        ; paranthesesOpened++
check_term_2:
        cmp     BYTE [eax], CLOSED_PARAN ; compare with closed parantheses
        jne     check_term_3
        dec     DWORD [ebp - 12]        ; paranthesesOpened--
check_term_3:
        cmp     BYTE [eax], PLUS        ; go to paranth check if *buffer == +
        je      paranth_term_check
        cmp     BYTE [eax], MINUS
        je      paranth_term_check
        jmp     check_term_end
paranth_term_check:
        cmp     DWORD [ebp - 12], 0
        jne     check_term_end          ; paranthases not ok
        mov     bl, BYTE [eax]  
        mov     BYTE [ebp - 24], bl     ; char oldChar = *buffer
        mov     BYTE [eax], 0
        push    DWORD [ebp + 12]        ; prepare for func call
        push    DWORD [ebp - 16]
        call    expression
        add     esp, 8
        cmp     DWORD [ebp - 4], 1      ; check should add
        jne     should_sub
        add     DWORD [ebp - 8], eax    ; add expression
        jmp     should_sub_if_end
should_sub:
        sub     DWORD [ebp - 8], eax
should_sub_if_end:
        mov     al, BYTE [ebp - 24]
        mov     edx, [ebp - 20]
        mov     BYTE [edx], al
        cmp     al, BYTE PLUS
        jne     change_should_add
        mov     DWORD [ebp - 4], 1
        jmp     change_should_end
change_should_add:
        mov     DWORD [ebp - 4], 0
change_should_end:
        mov     eax, [ebp - 20]       ; eax is buffer
        inc     eax
        mov     [ebp - 16], eax       ; currentExpression = buffer + 1
check_term_end:
        inc     DWORD [ebp - 20]
        mov     eax, [ebp - 20]
        cmp     BYTE [eax], 0
        jne     first_term_while
        push    DWORD [ebp + 12]      ; prepare for func call
        push    DWORD [ebp - 16]      ; currentExpression push
        call    expression
        add     esp, 8
        mov     edx, [ebp - 8]
        cmp     DWORD [ebp - 4], 1
        jne     should_sub_end
        add     edx, eax
        jmp     term_func_end
should_sub_end:
        sub     edx, eax
term_func_end:
        mov     eax, edx
        add     esp, 24
        leave
        ret

; `expression(char *p, int *i)`
;       Evaluates "term" + "term" or "term" - "term" expressions 
; @params:
;	p -> the string to be parsed
;	i -> current position in the string
; @returns:
;	the result of the parsed expression
expression:
        push    ebp
        mov     ebp, esp
        sub     esp, 12       ; we declare 3 local variables and one place to store edx
        mov     [ebp - 4], DWORD 0   ; int paranthesesOpened
        mov     eax, [ebp + 8]
        mov     [ebp - 8], eax       ; char *buffer = p
        push    DWORD [ebp + 8]      ; starting strlen call
        call    strlen
        add     esp, 4               ; cleaning up
        mov     [ebp - 12], eax      ; int pLen = strlen(p)
first_while:
        mov     eax, [ebp - 8]       ; eax is buffer
        cmp     BYTE [eax], BYTE OPEN_PARAN  ; check open parantheses
        jne     check_2
        inc     DWORD [ebp - 4]      ; paranthesesOpened++
        jmp     check_end
check_2:
        cmp     BYTE [eax], BYTE CLOSED_PARAN ; check closed parantheses
        jne     check_3
        dec     DWORD [ebp - 4]      ; paranthsesOpened--
        jmp     check_end
check_3:
        cmp     BYTE [eax], BYTE PLUS    ; comparing to see if plus
        je      paranth_check
        cmp     BYTE [eax], BYTE MINUS   ; comparing to see if minus
        je      paranth_check
        jmp     check_end
paranth_check:
        cmp     DWORD [ebp - 4], 0       ; check paranthesesOpened are 0
        jne     check_end
        push    DWORD [ebp + 12]         ; prepare for term call
        push    DWORD [ebp + 8]
        call    term
        add     esp, 8                   ; clean up
        jmp     func_end                 ; go directly to end
check_end:
        inc     DWORD [ebp - 8]          ; increment buffer
        mov     eax, [ebp - 8]
        cmp     BYTE [eax], 0
        jne     first_while              ; (*buffer != 0)
        mov     eax, [ebp + 8]
        mov     [ebp - 8], eax           ; buffer = p
        mov     DWORD [ebp - 4], 0             ; paranthseseOpened = 0
second_while:
        mov     eax, [ebp - 8]       ; eax is buffer
        cmp     BYTE [eax], BYTE OPEN_PARAN  ; check open parantheses
        jne     second_check_2
        inc     DWORD [ebp - 4]      ; paranthesesOpened++
        jmp     second_check_end
second_check_2:
        cmp     BYTE [eax], BYTE CLOSED_PARAN ; check closed parantheses
        jne     second_check_3
        dec     DWORD [ebp - 4]      ; paranthsesOpened--
        jmp     second_check_end
second_check_3:
        cmp     BYTE [eax], BYTE ASTERISK    ; comparing to see if plus
        je      second_paranth_check
        cmp     BYTE [eax], BYTE DIVIDE   ; comparing to see if minus
        je      second_paranth_check
        jmp     second_check_end
second_paranth_check:
        cmp     DWORD [ebp - 4], 0       ; check paranthesesOpened are 0
        jne     second_check_end
        push    DWORD [ebp + 12]         ; prepare for term call
        push    DWORD [ebp + 8]
        call    factor
        add     esp, 8                   ; clean up
        jmp     func_end                 ; go directly to end
second_check_end:
        inc     DWORD [ebp - 8]          ; increment buffer
        mov     eax, [ebp - 8]
        cmp     BYTE [eax], 0
        jne     second_while              ; (*buffer != 0)
        mov     eax, [ebp + 8]           ; eax is now p
        cmp     BYTE [eax], OPEN_PARAN
        jne     call_atoi
        mov     edx, [ebp - 12]          ; edx is now pLen
        mov     BYTE [eax + edx - 1], 0  ; *(p + pLen - 1) = 0
        inc     eax
        push    DWORD [ebp + 12]         ; prepare to call expression
        push    eax
        call    expression
        add     esp, 8                   ; clear up
        jmp     func_end
call_atoi:
        push    DWORD [ebp + 8]          ; prepare to call atoi
        call    atoi
        add     esp, 4                   ; clear
func_end:
        add     esp, 12
        leave
        ret
