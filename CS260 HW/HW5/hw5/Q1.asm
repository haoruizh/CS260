#1. Define the following recursive function which is very similar to Fibonacci:
#F(n) = 2 *F(n -1) + 3 *F(n - 2);
#F(0) = 1;
#F(1) = 2.
#Please implement the function in MIPS and make sure your implementation
#indeed works on the simulator, by printing the value F(4) to the terminal.

.text 
.globl main
main:
li $a0, 4 #a0 -> 4 (a0 -> argument)
jal F
move $s0, $v0
li $v0, 1
move $a0, $s0
syscall
li $v0, 10
syscall
#F(X) function
F:
	bgt $a0, 1, recursion #If X > 1, go to recursion part
 	beqz $a0, x0 #if X = 0
 	li $v0, 2 #if F(1)
 	jr $ra
recursion:
	addi $sp, $sp, -8 #save $ra and $a0
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	addi $a0, $a0, -1 #update a0 to ao-1 (n-1)
	jal F #call F(n-1), $v0 -> F(n-1)
	addi $sp, $sp, -4#sapce for $v0
	sw $v0, 0($sp)
	addi $a0, $a0, -1 #update a0 to a0-1 (n-2)
	jal F #call F(n-2), $v0 -> F(n-2)
	lw $t0, 0($sp) #$t0->F(n-1)
	addi $sp, $sp, 4 #free v0 space
	mul $t0, $t0, 2 #$t0->2*F(n-1)
	mul $t1, $v0, 3 #$t1->3*F(n-2)
	add $v0, $t0, $t1 #v0 -> 2*F(n-1)+3*F(n-2)
	lw $a0, 4($sp) #load ao from 4($sp)
	lw $ra, 0($sp) #load ra from 0($sp)
	addi $sp, $sp, 8
	jr $ra
x0:
	li $v0, 1 #return 1
	jr $ra #go back to last call
	
	
