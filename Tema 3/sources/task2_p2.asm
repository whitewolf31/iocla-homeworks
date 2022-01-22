section .text
	global par

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression
par:
	add   esp, 4
	pop   eax       ; eax holds str_length
	pop   ebx       ; ebx holds head of str
	sub   esp, 12   ; restore stack pointer
	xor   edx, edx  ; number of brackets opened with no pair
	xor   ecx, ecx  ; counter
str_loop:
	cmp   BYTE [ebx + ecx], 40   ; ascii code of (
	jg    close_bracket  ; if it's greater, 41 ascii code of ) go to close_bracket case
	inc   edx
	jmp   after_close_bracket
close_bracket:
	cmp   edx, 0          ; if the counter is 0, it means a closing bracket was closed with no open one
	je    end_with_false   ; end with false
	dec   edx             ; reduce number of open bracket with no pair
after_close_bracket:
	inc   ecx
	cmp   ecx, eax        ; loop condition
	jl    str_loop
	cmp   edx, 0
	jg    end_with_false  ; end with false if there are unclosed open brackets
	xor   eax, eax
	inc   eax             ; return 1 if all is ok
end:
	ret
end_with_false:
	xor   eax, eax
	jmp   end
