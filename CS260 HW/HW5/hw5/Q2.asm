#Define the function ?(k), with k ? 2, as
#2^2 + 4^2 + 6^2 + · · · + m^2
#where m is the largest even number that is ? k. Please implement the
#function in MIPS and make sure your implementation indeed works on the
#simulator, by printing the value ?(15) to the terminal.
.text
.globl main
main:
li $a0, 15 #k=15
jal function
move $s0, $v0 #save v0 to s0
li $v0, 1
move $a0, $s0
syscall
li $v0, 10
syscall
#function f
function:
	bgt $a0, 1, recursion #if k>1 (k>=2)
recursion:
	#Determine if $a0 is an odd or an even 
	div $t0, $a0, 2 #t0->a0/2
	mul $t0, $t0, 2 #t0->(a0/2)*2
	sub $t1, $a0, $t0 #t1 -> $a0 - ((a0/2)*2)
	beqz $t1, evenArgument #If t1 == 0 , then k is an even number, else, it is an odd
	addi $a0, $a0, -1 #if a0 is an odd number, ao = ao-1
evenArgument:
	move $t2, $a0 #t2->a0
	mul $s1, $t2, $t2 #s1 -> t2^2
	add $v0 $v0, $s1 #v0 -> a0^2
	addi $a0, $a0, -2
	beqz $a0, argumentIsZero
	j evenArgument #jump back to loop
argumentIsZero:
	jr $ra #return the value