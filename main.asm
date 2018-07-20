	.include "macros.asm"
	.data
	score: .asciiz "Score: "
	chooseJollyValue: .asciiz "Choose the value of the jolly:" 
	invalid: .asciiz "Invalid entry"
	over: .asciiz "You are over 7.5"
	yourMove: .asciiz "1.Draw another card 2.Stop"
	lose: .asciiz "You lose"
	nCards: .asciiz "Used cards: " 
	dealerTurn: .asciiz "Turn of the dealer"
	win: .asciiz "You win!"
	half: .float 0.5
	init: .float 0.0
	ten: .float 10.0
	seven: .float 7.0
	sevenhalf: .float 7.5
	limit: .float 5.5
	.align 2
	Deck: .space 160
	.text
	.globl main

main:
	l.s $f21,init #player score
	li $s0,0 #player number of cards
	li $s2,0 #$s2: boolean player, 0 player 1 dealer

#Below there are the labels, and their related instructions, which outline the structure of the game
	
player:
	
	la $a0,Deck
	jal draw
	addi $s0,$s0,1
	
	move $a0,$v0
	jal cardIdentify
	
	beq $v0,$zero,chooseJolly
	li $t0,8
	slt $t1,$v0,$t0
	beq $t1,$zero,addHalf
	mtc1 $v0,$f20	
	cvt.s.w $f20,$f20
	add.s $f21,$f21,$f20 #add the int value corresponding to the card drawn
	displayScore($f21)
	j checkOver
	
choose:
	li $v0,51
	la $a0,yourMove
	syscall
	seq $t0,$a0,1
	seq $t1,$a0,2
	or $t0,$t0,$t1
	beq $t0,$zero,invalidChoose #If the user enters anything other than 1 or 2, the entry is redone
	beq $t1,$zero,player 
	print_nCards($s0) 
	j dealer
	
dealer:
	li $s2,1 #Turn of the dealer
	l.s $f23,init
	li $s1,0
	
	li $v0,55
	la $a0,dealerTurn
	li $a1,1
	syscall

dealerMoves:
	la $a0,Deck
	jal draw
	addi $s1,$s1,1
	
	move $a0,$v0
	jal cardIdentify
	
	beq $v0,$zero,jollyMove
	li $t0,8
	slt $t1,$v0,$t0
	beq $t1,$zero,addHalf
	mtc1 $v0,$f20
	cvt.s.w $f20,$f20
	add.s $f23,$f23,$f20
	displayScore($f23)
	j checkOver

decision:
	l.s $f25,sevenhalf
	c.eq.s $f23,$f25
	bc1t result
	l.s $f25,limit 
	c.le.s $f25,$f23 #The dealer decides to stop when it reaches at least the score set by a threshold
	bc1t result
	j dealerMoves

result:
	print_nCards($s1)
	c.lt.s $f21,$f23
	bc1t lost
	c.eq.s $f21,$f23
	bc1f victory
	slt $t0,$s0,$s1
	bne $t0,$zero,victory
	j lost
	
end:
	li $v0,10
	syscall
	
#Below, the labels, and related instructions, which deal with checks, validity of entries, 
#operations for the proper functioning of the game
	
chooseJolly:
	li $v0,52
	la $a0,chooseJollyValue
	syscall
	#Check insertion
	mov.s $f23,$f0
	l.s $f24,ten
	mul.s $f23,$f23,$f24
	cvt.w.s $f23,$f23
	mfc1 $t0,$f23
	beq $t0,$zero,invalidJolly #The player has entered 0
	li $t5,71
	slt $s0,$t0,$t5
	beq $s0,$zero,invalidJolly
	seq $t2,$t0,5 #If $t2=1 the player has entered 0.5
	li $t1,10
	div $t0,$t1
	mfhi $t3
	seq $t4,$t3,$zero #If $t4=1 the player has entered an int
	or $t4,$t4,$t2
	beq $t4,$zero,invalidJolly
	add.s $f21,$f21,$f0
	displayScore($f21)
	j checkOver

invalidJolly:
	li $v0,55
	la $a0,invalid
	li $a1,0
	syscall
	j chooseJolly
	
addHalf:
	l.s $f22,half
	beq $s2,$zero,halfPlayer
	add.s $f23,$f23,$f22
	displayScore($f23)
	j checkOver
	
halfPlayer:
	add.s $f21,$f21,$f22
	displayScore($f21)
	j checkOver
	
checkOver: 
	l.s $f24,ten
	beq $s2,$zero,overPlayer #If s2=0 it is the player's turn, otherwise the check is carried out on the score of the dealer
	mul.s $f22,$f23,$f24
	cvt.w.s $f22,$f22
	mfc1 $t0,$f22
	li $t5,76
	slt $t1,$t0,$t5
	beq $t1,$zero,victory
	j decision
	
overPlayer:
	mul.s $f22,$f21,$f24
	cvt.w.s $f22,$f22
	mfc1 $t0,$f22
	li $t5,76
	slt $t1,$t0,$t5
	beq $t1,$zero,overLimit
	j choose
	
jollyMove: #The dealer decides the value of the jolly.
		#If He has an int score, the jolly is equal to 7-score
		#If He has a floating point score(n.5), the jolly is equal to 7.5-score
		#If He has a score of seven, the jolly is equal to 0.5.
	mov.s $f24,$f23
	l.s $f25,ten
	mul.s $f24,$f24,$f25
	cvt.w.s $f24,$f24
	mfc1 $t0,$f24
	seq $t2,$t0,70
	bne $t2,$zero,halff
	li $t1,10
	div $t0,$t1
	mfhi $t0
	beq $t0,$zero,sevenn
	l.s $f25,sevenhalf
	sub.s $f25,$f25,$f23
	add.s $f23,$f23,$f25
	displayScore($f23)
	j decision

halff:
	l.s $f25,half
	add.s $f23,$f23,$f25
	displayScore($f23)
	j decision

sevenn:
	l.s $f25,seven
	sub.s $f25,$f25,$f23
	add.s $f23,$f23,$f25
	displayScore($f23)
	j decision

invalidChoose:
	li $v0,55
	la $a0,invalid
	li $a1,0
	syscall
	j choose

overLimit:
	li $v0,55
	la $a0,over
	li $a1,1
	syscall
	j lost

lost:
	li $v0,55
	la $a0,lose
	li $a1,1
	syscall
	j end
victory:
	li $v0,55
	la $a0,win
	li $a1,1
	syscall
	j end
	
	
	
	
	
