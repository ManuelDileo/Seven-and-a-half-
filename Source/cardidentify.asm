# INPUT 
# $a0: card number drawn from the current deck of cards
# OUTPUT
# $v0: type of card drawn: 0 if it's a jolly, 8 if 0.5 is its value, the real decimal value otherwise
# On the display: Inform the user of the card drawn indicating its value in "decimal|seed" (eg "7C", "8S").
#It's used to not fill the main with a long data segment.

	.data
	msg1: .asciiz "Card: "
	jolly: .asciiz "Jolly!"  #The jolly is the king of diamonds.
	
	uc: .asciiz "1H" 	#The labels are the acronyms of the cards in italian language 
	dc: .asciiz "2H" 	#(eg "dc" means "Due di cuori" that means "Two Hearts")
	tc: .asciiz "3H" 	#This detail is not important for understanding the program.
	qc: .asciiz "4H"
	cc: .asciiz "5H"
	sc: .asciiz "6H"
	stc: .asciiz "7H"
	oc: .asciiz "8H"
	nc: .asciiz "9H"
	rc: .asciiz "10H"
	uq: .asciiz "1D"
	dq: .asciiz "2D"
	tq: .asciiz "3D"
	qq: .asciiz "4D"
	cq: .asciiz "5D"
	sq: .asciiz "6D"
	stq: .asciiz "7D"
	oq: .asciiz "8D"
	nq: .asciiz "9D"
	uf: .asciiz "1C"
	df: .asciiz "2C"
	tf: .asciiz "3C"
	qf: .asciiz "4C"
	cf: .asciiz "5C"
	sf: .asciiz "6C"
	stf: .asciiz "7C"
	of: .asciiz "8C"
	nf: .asciiz "9C"
	rf: .asciiz "10C"
	up: .asciiz "1S"
	dp: .asciiz "2S"
	tp: .asciiz "3S"
	qp: .asciiz "4S"
	cp: .asciiz "5S"
	sp: .asciiz "6S"
	stp: .asciiz "7S"
	op: .asciiz "8S"
	np: .asciiz "9S"
	rp: .asciiz "10S"
	.align 2
	
	.text
	.globl cardIdentify
	
cardIdentify:
	
	li $t0,10
	div $a0,$t0
	mflo $t1 #Seed
	mfhi $t2 #value
	move $t3,$t2
	
	
	#Switch of Switch to print the msg of the card drawn.
	slt $t4, $t3, $zero
	bne $t4,$zero,exit
	
	beq $t3, $zero, Ace
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Two
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Three
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Four
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Five
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Six
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Seven
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Eight
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Nine
	
	addi $t3,$t3,-1
	beq  $t3,$zero, Ten
	
	j exit
	
	#Seeds in the order: Hearts Diamonds Clubs Spades
	
Ace:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,HeartsAce
	
	addi $t3,$t3,-1
	beq $t3,$zero,DiamondsAce
	
	addi $t3,$t3,-1
	beq $t3,$zero,ClubsAce
	
	addi $t3,$t3,-1
	beq $t3,$zero,SpadesAce
	
	j exit

HeartsAce:
	la $a1,uc
	j exit
DiamondsAce:
	la $a1,uq
	j exit
ClubsAce:
	la $a1,uf
	j exit
SpadesAce:
	la $a1,up
	j exit

Two:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,TwoHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,TwoDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,TwoClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,TwoSpades
	
	j exit

TwoHearts:
	la $a1,dc
	j exit
TwoDiamonds:
	la $a1,dq
	j exit
TwoClubs:
	la $a1,df
	j exit
TwoSpades:
	la $a1,dp
	j exit

Three:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,ThreeHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,ThreeDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,ThreeClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,ThreeSpades
	
	j exit

ThreeHearts:
	la $a1,tc
	j exit
ThreeDiamonds:
	la $a1,tq
	j exit
ThreeClubs:
	la $a1,tf
	j exit
ThreeSpades:
	la $a1,tp
	j exit

Four:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,FourHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,FourDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,FourClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,FourSpades
	
	j exit

FourHearts:
	la $a1,qc
	j exit
FourDiamonds:
	la $a1,qq
	j exit
FourClubs:
	la $a1,qf
	j exit
FourSpades:
	la $a1,qp
	j exit
	
Five:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,FiveHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,FiveDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,FiveClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,FiveSpades
	
	j exit
	
FiveHearts:
	la $a1,cc
	j exit
FiveDiamonds:
	la $a1,cq
	j exit
FiveClubs:
	la $a1,cf
	j exit
FiveSpades:
	la $a1,cp
	j exit
	
Six:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,SixHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,SixDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,SixClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,SixSpades
	
	j exit

SixHearts:
	la $a1,sc
	j exit
SixDiamonds:
	la $a1,sq
	j exit
SixClubs:
	la $a1,sf
	j exit
SixSpades:
	la $a1,sp
	j exit

Seven:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,SevenHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,SevenDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,SevenClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,SevenSpades
	
	j exit

SevenHearts:
	la $a1,stc
	j exit
SevenDiamonds:
	la $a1,stq
	j exit
SevenClubs:
	la $a1,stf
	j exit
SevenSpades:
	la $a1,stp
	j exit
	
Eight:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,EightHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,EightDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,EightClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,EightSpades
	
	j exit

EightHearts:
	la $a1,oc
	j exit
EightDiamonds:
	la $a1,oq
	j exit
EightClubs:
	la $a1,of
	j exit
EightSpades:
	la $a1,op
	j exit

Nine:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,NineHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,NineDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,NineClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,NineSpades
	
	j exit

NineHearts:
	la $a1,nc
	j exit
NineDiamonds:
	la $a1,nq
	j exit
NineClubs:
	la $a1,nf
	j exit
NineSpades:
	la $a1,np
	j exit
	
Ten:
	move $t3,$t1
	slt $t4,$t3,$zero
	bne $t4,$zero,exit
	
	beq $t3,$zero,TenHearts
	
	addi $t3,$t3,-1
	beq $t3,$zero,TenDiamonds
	
	addi $t3,$t3,-1
	beq $t3,$zero,TenClubs
	
	addi $t3,$t3,-1
	beq $t3,$zero,TenSpades
	
	j exit

TenHearts:
	la $a1,rc
	j exit
TenDiamonds:
	la $a1,jolly
	j exit
TenClubs:
	la $a1,rf
	j exit
TenSpades:
	la $a1,rp
	j exit
	
exit:
	
	li $v0,59
	la $a0,msg1
	syscall 
	
	#value to return
	seq $t3,$t1,1
	seq $t4,$t2,9
	and $t3,$t3,$t4
	bne $t3,$zero,Jolly
	li $t4,7
	slt $t3,$t2,$t4
	bne $t3,$zero,Value
	li $v0,8
	j end

Jolly:
	li $v0,0
	j end
Value:
	addi $t2,$t2,1
	move $v0,$t2
	j end
	
end:
	jr $ra
	
	
	
	
	
