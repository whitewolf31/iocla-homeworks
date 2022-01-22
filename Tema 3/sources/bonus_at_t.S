/*
 * Don't forget to include "positions.h"
 */
 #include "positions.h"

.section .text
.global add_vect

/* 
 * void add_vect(int *v1, int *v2, int n, int *v)
 *
 * add v1 and v2, that have both the length n, and store the result in v3.
 * also, substract from v3 the values provided in positions.S, as described
 * in the task
 */

add_vect:
	pushl %ebp
	movl	%esp, %ebp
	movl  0x10(%ebp), %ecx  # put in ecx size of vector
	dec 	%ecx
	movl 	0x8(%ebp), %eax # put in eax first vector
	movl  0xc(%ebp), %ebx # put in ebx second vector
loop:
	movl  (%eax,%ecx,0x4), %edx  # put v1[ecx] in edx
	addl  (%ebx,%ecx,0x4), %edx  # add v2[ecx] in edx
	movl 	0x14(%ebp), %eax       # put v in eax
	movl  %edx, (%eax,%ecx,0x4)  # put result in v
	movl 	0x8(%ebp), %eax # put in eax first vector
	dec   %ecx
	cmpl  $0, %ecx
	jge 	loop
	subl  $8, %esp        # alloc space for should_multiply and factor variable
	cmpl  $10, 0x10(%ebp) 
	ja 		should_multiply
	movl  $0, -0x4(%ebp)  # should_multiply = 0
	mov   $10, %eax
	cdq
test:
	idivl 0x10(%ebp)
	mov 	%eax, -0x8(%ebp)  # factor = 10 / n
	jmp 	multiply_end
should_multiply:
	movl  $1, -0x4(%ebp)  # should_multiply = 1
	movl  0x10(%ebp), %eax
	cdq
	movl  $10, %ecx
	idivl %ecx
	movl 	%eax, -0x8(%ebp) # factor = 50 / n
multiply_end:                # continue doing the calculations
	movl 	$FIRST_POSITION, %eax
	movl  $0, %ecx
	cmpl 	-0x4(%ebp), %ecx
	jne 	multiply_first_factor
	cdq
	idivl -0x8(%ebp)
	movl  %eax, %ecx
	jmp  	multiply_first_factor_end
multiply_first_factor:
	imull -0x8(%ebp)
	movl  %eax, %ecx
multiply_first_factor_end:
	movl 	0x14(%ebp), %eax
	movl  $FIRST_VALUE, %edx
	subl  %edx, (%eax,%ecx,0x4)
	movl 	$SECOND_POSITION, %eax
	movl  $0, %ecx
	cmpl 	-0x4(%ebp), %ecx
	jne		multiply_second_factor
	cdq
	idivl -0x8(%ebp)
	movl  %eax, %ecx
	jmp  	multiply_second_factor_end
multiply_second_factor:
	imull -0x8(%ebp)
	movl  %eax, %ecx
multiply_second_factor_end:
	movl 	0x14(%ebp), %eax
	movl  $SECOND_VALUE, %edx
	subl  %edx, (%eax,%ecx,0x4)
	movl 	$THIRD_POSITION, %eax
	movl  $0, %ecx
	cmpl 	-0x4(%ebp), %ecx
	jne		multiply_third_factor
	cdq
	idivl -0x8(%ebp)
	movl  %eax, %ecx
	jmp  	multiply_third_factor_end
multiply_third_factor:
	imull -0x8(%ebp)
	movl  %eax, %ecx
multiply_third_factor_end:
	movl 	0x14(%ebp), %eax
	movl  $THIRD_VALUE, %edx
	subl  %edx, (%eax,%ecx,0x4)
	leave
	ret
