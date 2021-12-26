	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0	sdk_version 12, 0
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset %ebp, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register %ebp
	subl	$40, %esp
	calll	L0$pb
L0$pb:
	popl	%ecx
	movl	%ecx, -36(%ebp)                 ## 4-byte Spill
	movl	L___stack_chk_guard$non_lazy_ptr-L0$pb(%ecx), %eax
	movl	(%eax), %eax
	movl	%eax, -4(%ebp)
	movl	$0, -8(%ebp)
	subl	$16, %esp
	movl	%esp, %eax
	leal	-12(%ebp), %edx
	movl	%edx, 4(%eax)
	leal	L_.str-L0$pb(%ecx), %ecx
	movl	%ecx, (%eax)
	calll	_scanf
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	%esp, %ecx
	movl	%ecx, -16(%ebp)
	leal	15(,%eax,8), %edx
	andl	$-16, %edx
	movl	%esp, %ecx
	subl	%edx, %ecx
	movl	%ecx, -32(%ebp)                 ## 4-byte Spill
	movl	%ecx, %esp
	movl	%eax, -20(%ebp)
	movl	$0, -24(%ebp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-24(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jge	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-32(%ebp), %eax                 ## 4-byte Reload
	movl	-36(%ebp), %ecx                 ## 4-byte Reload
	leal	L_.str-L0$pb(%ecx), %ecx
	movl	-24(%ebp), %edx
	shll	$3, %edx
	addl	%edx, %eax
	subl	$16, %esp
	movl	%ecx, (%esp)
	movl	%eax, 4(%esp)
	calll	_scanf
	addl	$16, %esp
                                        ## kill: def $ecx killed $eax
	movl	-32(%ebp), %eax                 ## 4-byte Reload
	movl	-24(%ebp), %ecx
	movl	$0, 4(%eax,%ecx,8)
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movl	-24(%ebp), %eax
	addl	$1, %eax
	movl	%eax, -24(%ebp)
	jmp	LBB0_1
LBB0_4:
	movl	-32(%ebp), %eax                 ## 4-byte Reload
	movl	-12(%ebp), %ecx
	subl	$16, %esp
	movl	%ecx, (%esp)
	movl	%eax, 4(%esp)
	calll	_sort
	addl	$16, %esp
	movl	%eax, -28(%ebp)
LBB0_5:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$0, -28(%ebp)
	je	LBB0_7
## %bb.6:                               ##   in Loop: Header=BB0_5 Depth=1
	movl	-36(%ebp), %eax                 ## 4-byte Reload
	leal	L_.str.1-L0$pb(%eax), %ecx
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	subl	$16, %esp
	movl	%ecx, (%esp)
	movl	%eax, 4(%esp)
	calll	_printf
	addl	$16, %esp
	movl	-28(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -28(%ebp)
	jmp	LBB0_5
LBB0_7:
	movl	-36(%ebp), %eax                 ## 4-byte Reload
	leal	L_.str.2-L0$pb(%eax), %eax
	subl	$16, %esp
	movl	%eax, (%esp)
	calll	_printf
	addl	$16, %esp
                                        ## kill: def $ecx killed $eax
	movl	-36(%ebp), %eax                 ## 4-byte Reload
	movl	$0, -8(%ebp)
	movl	-16(%ebp), %ecx
	movl	%ecx, %esp
	movl	-8(%ebp), %ecx
	movl	%ecx, -40(%ebp)                 ## 4-byte Spill
	movl	L___stack_chk_guard$non_lazy_ptr-L0$pb(%eax), %eax
	movl	(%eax), %eax
	movl	-4(%ebp), %ecx
	cmpl	%ecx, %eax
	jne	LBB0_9
## %bb.8:
	movl	-40(%ebp), %eax                 ## 4-byte Reload
	movl	%ebp, %esp
	popl	%ebp
	retl
LBB0_9:
	calll	___stack_chk_fail
	ud2
	.cfi_endproc
                                        ## -- End function
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"%d"

L_.str.1:                               ## @.str.1
	.asciz	"%d "

L_.str.2:                               ## @.str.2
	.asciz	"\n"

	.section	__IMPORT,__pointers,non_lazy_symbol_pointers
L___stack_chk_guard$non_lazy_ptr:
	.indirect_symbol	___stack_chk_guard
	.long	0

.subsections_via_symbols
