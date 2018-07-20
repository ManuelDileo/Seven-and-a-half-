.macro print_nCards (%x)
	li $v0,56
	la $a0, nCards
	li $a1,0
	add $a1,$a1,%x
	syscall
.end_macro
	
.macro displayScore (%x)
	li $v0,57
	la $a0, score
	mov.s $f12, %x
	syscall
.end_macro
