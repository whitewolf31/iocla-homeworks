section .text
	global cpu_manufact_id
	global features
	global l2_cache_info

;; void cpu_manufact_id(char *id_string);
;
;  reads the manufacturer id string from cpuid and stores it in id_string
cpu_manufact_id:
	enter	0, 0
	pusha
	xor 	eax, eax
	cpuid											; run cpuid with eax 0 to get ID
	mov		eax, [ebp + 8]
	mov 	DWORD [eax], ebx
	mov 	DWORD [eax + 4], edx
	mov 	DWORD [eax + 8], ecx
	popa
	leave
	ret

;; void features(char *vmx, char *rdrand, char *avx)
;
;  checks whether vmx, rdrand and avx are supported by the cpu
;  if a feature is supported, 1 is written in the corresponding variable
;  0 is written otherwise
features:
	enter	0, 0
	pusha
	mov		eax, 1
	cpuid
	mov 	eax, 0x20        ; turn on 5th bit to check for vmx
	and 	eax, ecx
	cmp 	eax, 0
	mov 	eax, [ebp + 8]
	je 		no_vmx           ; if present add it to char
	mov 	DWORD [eax], 1
	jmp 	rdrand
no_vmx:
	mov 	DWORD [eax], 0
rdrand:
	mov 	eax, 0x40000000  ; turn on 30th bit to check for rdrand
	and 	eax, ecx
	cmp 	eax, 0
	mov 	eax, [ebp + 12]
	je 		no_rdrand
	mov 	DWORD [eax], 1
	jmp 	avx
no_rdrand:
	mov 	DWORD [eax], 0
avx:
	mov 	eax, 0x10000000; turn on 28th bit to check for avx 	
	and 	eax, ecx
	cmp 	eax, 0
	mov 	eax, [ebp + 16]
	je 		no_avx
	mov 	DWORD [eax], 1
	jmp 	func_end
no_avx:
	mov 	DWORD [eax], 0
func_end:
	popa
	leave
	ret

;; void l2_cache_info(int *line_size, int *cache_size)
;
;  reads from cpuid the cache line size, and total cache size for the current
;  cpu, and stores them in the corresponding parameters
l2_cache_info:
	enter 0, 0
	pusha
	mov 	eax, 0x80000006   ; mov to eax function to get cpuid info
	cpuid	
	mov 	eax, 0xff         ; get the least significant byte of ecx -> LEVEL2_CACHE_LINESIZE
	and 	eax, ecx
	mov 	ebx, [ebp + 8]
	mov 	DWORD [ebx], eax
	mov 	eax, 0xffff0000   ; get first two bytes most significant of ecx -> LEVEL2_CACHE_SIZE
	and 	eax, ecx
	shr 	eax, 16 					; shift right to get good value
	mov 	ebx, [ebp + 12]
	mov 	DWORD [ebx], eax
	popa
	leave
	ret
