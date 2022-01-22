section .text
	global vectorial_ops

;; void vectorial_ops(int *s, int A[], int B[], int C[], int n, int D[])
;  
;  Compute the result of s * A + B .* C, and store it in D. n is the size of
;  A, B, C and D. n is a multiple of 16. The result of any multiplication will
;  fit in 32 bits. Use MMX, SSE or AVX instructions for this task.

vectorial_ops:
	push	rbp
	mov		rbp, rsp
	movd 	xmm0, edi
	pshufd  xmm0, xmm0, 0
	mov 	r10, DWORD 0
	mov 	eax, DWORD 0
loop:
	movdqu xmm1, [rsi + 4*rax]   ; put 4 int from A
	pmulld xmm1, xmm0 						; multiply by s
	movdqu xmm2, [rdx + 4*rax]   ; put 4 int from B
	movdqu xmm3, [rcx + 4*rax]   ; put 4 int from C
	pmulld xmm2, xmm3
	paddq  xmm1, xmm2            ; perform addition
	movdqu [r9 + 4*rax], xmm1    ; put result in D
	add 	r10, 4
	add  	eax, 4
	cmp 	r10, r8
	jb		loop

	leave
	ret
