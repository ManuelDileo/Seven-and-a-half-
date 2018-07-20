# INPUT 
# $a0: base address of the current deck of cards
# OUTPUT
# $v0: card number drawn from the current deck of cards

	.text
	.globl draw

draw:	
	move $t0,$a0
Loop:
	li $a0,0
	li $a1,40
	li $v0,42
	syscall	#Simulation of the draw by extracting a number from 0 to 39
	li $t1,4
	mul $t1,$t1,$a0
	add $t1,$t1,$t0
	lw $t2,0($t1)
	bne $t2,$zero,Loop #If the card is not in the current deck, it extractes a new number
	li $t3,1
	sw $t3,0($t1)	#Mark the current card as drawn
	move $v0,$a0
	jr $ra
