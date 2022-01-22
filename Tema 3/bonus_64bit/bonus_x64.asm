section .text
	global intertwine

;; void intertwine(int *v1, int n1, int *v2, int n2, int *v);
;
;  Take the 2 arrays, v1 and v2 with varying lengths, n1 and n2,
;  and intertwine them
;  The resulting array is stored in v
intertwine:
	enter 0, 0
	sub 	rsp, 44
	mov 	DWORD [rbp - 4], 0    ; i
	mov 	DWORD [rbp - 8], 0    ; j
	mov 	DWORD [rbp - 12], 0   ; k
	mov   DWORD [rbp - 16], esi ; n1
	mov		DWORD [rbp - 20], ecx ; n2
	mov   [rbp - 28], rdi 		  ; v1
	mov 	[rbp - 36], rdx 		  ; v2
	mov 	[rbp - 44], r8 			  ; v
both_while:
	mov   eax, DWORD [rbp - 12]    ; put k in rax
	mov 	rcx, QWORD 2
	cdq
	idiv	rcx
	cmp 	rdx, 1  					; k % 2
	jne		add_first_vect
	mov 	rax, [rbp - 36]    ; v2
	mov  	ebx, DWORD [rbp - 8]     ; j
	mov	  ecx, DWORD [rax + 4 * rbx] ; v2[j]
	mov 	rax, [rbp - 44]     ; v
	mov	  ebx, [rbp - 12]    ; k
	mov 	DWORD [rax + 4 * rbx], ecx  ; v[k] = v2[j]
	inc		DWORD [rbp - 12]   ; k++
	inc 	DWORD [rbp - 8]  	 ; j++
	jmp		end_if
add_first_vect:
	mov 	rax, [rbp - 28]     ; v1
	mov 	ebx, DWORD [rbp - 4]     ; j
	mov		ecx, DWORD [rax + 4 * rbx]
	mov 	rax, [rbp - 44]     ; v
	mov 	ebx, DWORD [rbp - 12]    ; k
	mov 	DWORD [rax + 4 * rbx], ecx  ; v[k] = v1[i]
	inc		DWORD [rbp - 12] 	 ; k++
	inc 	DWORD [rbp - 4]		 ; i++
end_if:
	mov   eax, DWORD [rbp - 4]
	cmp		eax, [rbp - 16]
	je		both_while_end
	mov 	eax, DWORD [rbp - 8]
	cmp 	eax, [rbp - 20]
	jb		both_while
both_while_end:
	mov 	eax, DWORD [rbp - 4] ; i
	cmp 	eax, [rbp - 16]
	je		j_while_end
	mov 	rax, [rbp - 28]     ; v1
	mov   ebx, DWORD [rbp - 4]  ; i
	mov		ecx, DWORD [rax + 4 * rbx]
	mov 	rax, [rbp - 44]     ; v
	mov 	ebx, DWORD [rbp - 12]    ; k
	mov 	DWORD [rax + 4 * rbx], ecx  ; v[k] = v1[i]
	inc		DWORD [rbp - 12] 	 ; k++
	inc 	DWORD [rbp - 4]		 ; i++
	jmp 	both_while_end
j_while_end:
	mov 	eax, [rbp - 8] ; j
	cmp 	eax, [rbp - 20]
	je  	func_end
	mov 	rax, [rbp - 36]    ; v2
	mov 	ebx, DWORD [rbp - 8]     ; j
	mov		rcx, [rax + 4 * rbx]
	mov 	rax, [rbp - 44]    ; v
	mov 	ebx, DWORD [rbp - 12]    ; k
	mov 	DWORD [rax + 4 * rbx], ecx  ; v[k] = v2[j]
	inc		DWORD [rbp - 12]   ; k++
	inc 	DWORD [rbp - 8]  	 ; j++
	jmp 	j_while_end
func_end:
	leave
	ret
