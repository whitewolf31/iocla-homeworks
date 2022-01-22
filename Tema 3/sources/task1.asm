NODE_SIZE EQU 8
MAX_INT EQU 0x7fffffff

section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list
sort:
	enter 0, 0
	sub 	esp, 24                 ; we need 6 local variables
	mov   [ebp - 4], DWORD 0			; int i
	mov   [ebp - 8], DWORD 0      ; int j
	mov   [ebp - 16], DWORD 0     ; struct node * node_to_change
	mov   [ebp - 24], DWORD 0     ; struct node * first_node
outer_loop:
	mov   [ebp - 12], DWORD MAX_INT ; int current_min = MAX_INT
	mov   [ebp - 20], DWORD 0       ; struct node * current_min_node
	mov   [ebp - 8], DWORD 0        ; make j = 0
inner_loop:
	mov   ecx, [ebp - 8]            ; ecx holds j
	mov   eax, [ebp + 12]           ; eax holds head of nodes array
	lea   ebx, [eax + NODE_SIZE * ecx] ; ebx holds the current node address
	mov   edx, [ebx + 4]            ; edx holds next of current node
	cmp   edx, DWORD 0
	ja    skip_current              ; if next != null, skip, it was already assigned
	cmp   ebx, [ebp - 16]           ; compare with node_to_change, if it's the same skip it
	je    skip_current
	mov   edx, [ebx]                ; edx holds the value of current node
	cmp   edx, [ebp - 12]           ; compare with current_min
	jge   skip_current
	mov   [ebp - 20], ebx           ; if all is ok move to current_min_node address of current node
	mov   [ebp - 12], edx           ; replace current_min with new minimum
skip_current:
	inc   ecx
	mov   [ebp - 8], ecx
	cmp   ecx, [ebp + 8]            ; compare with n
	jl    inner_loop
	mov   eax, [ebp - 16]           ; move to eax, node_to_change
	mov   ebx, [ebp - 20]           ; ebx holds *current_min_node
	cmp   eax, 0
	je    non_existing_node_to_change   ; this means node_to_change != null
	mov   [eax + 4], ebx            ; node_to_change->next = current_min_node
	jmp   existing_node_to_change
non_existing_node_to_change:
	mov   [ebp - 24], ebx           ; assign first node
existing_node_to_change:
	mov   [ebp - 16], ebx           ; node_to_change = current_min_node (change node_to_change to current_min_node)
	mov   ecx, [ebp - 4]            ; ecx holds i
	inc   ecx
	mov   [ebp - 4], ecx
	cmp   ecx, [ebp + 8]            ; compare with n
	jl    outer_loop
	mov   eax, [ebp - 24]           ; put return value in eax
	add   esp, 24                   ; disalloc local variables

	leave
	ret
