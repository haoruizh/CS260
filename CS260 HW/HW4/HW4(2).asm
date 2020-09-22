#Translating the following C code:
#void main(){
#int x=12;
#int y=simpleEx(x,x-5);
#y=y+simpleEx(14,x);
#}
#int simpleEx(int x, int y){
#int z=7;
#return x+2y-z;
#}

.text
.globl main
main:
	li $s0, 12 #s0=x
#y = simpleEx(x,x-5)
	move $a0, $s0 #move s0 to a0, first argument
	addi $a1, $a0, -5 #a1 = x-5 second argument
	jal simpleEx #calls the function
	move $s2, $v0 #y = simpleEx(x,x-5)
#y=y+simpleEx(14,x)
	move $a1, $s0 #a1 = x=12
	li $a0, 14 #a0 = 14
	jal simpleEx #call function
	add $s2, $s2, $v0# y = y+simpleEx(14,x)
#exit
li $v0, 10
syscall	
simpleEx:#function simpleEx
	addi $sp, $sp, -4 #allocate space
	sw $a0, 0($sp) #save $s0 on sp
	li $s1, 7 #s1 =z=7
	add $v0, $a0, $a1 #v0 = x+y
	add $v0, $v0, $a1 #v0 = x+2y
	sub $v0, $v0, $s1 #v0 = x+2y-z
	lw $a0,0($sp)#get a0
	addi $sp, $sp, 4#free the space
	jr $ra #return to next instruction after function call and return v0	
