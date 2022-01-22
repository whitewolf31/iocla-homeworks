section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b
cmmmc:
	add   esp, 4
	pop   eax         ; get a
	pop   ecx         ; get b
	sub   esp, 12      ; restore stack pointer
	push  ecx         ; push b for later
	push  eax         ; push a for later
cmmdc_loop:
	push  ecx
	xor   edx, edx    ; clear edx => result of modulo
	div   ecx
	push  edx       
	pop   ecx         ; the new ecx will be a % b
	pop   eax         ; eax will be old ecx
	cmp   ecx, DWORD 0 ; loop check
	ja    cmmdc_loop
	pop   edx         ; a is edx
	pop   ecx         ; b is ecx
	push  eax         ; save eax (cmmdc) for later
	push  edx
	pop   eax         ; move a to eax
	mul   ecx         ; eax will be a * b
	pop   ecx         ; ecx will be cmmdc
	div   ecx         ; eax will hold cmmmc
	ret
