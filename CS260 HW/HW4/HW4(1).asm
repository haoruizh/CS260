#a. Read a string from keyboad whose length is at most 64;
#b. Delete the last appearance of character a from the string (assume that
#the string always contains at least an a);
#c. Print the string to terminal.


.data
myString: .space 64
buffer: .space 64

.text
.globl main
main:
	li $s0, 'a' #s0 -> char 'a'
	la $s2, buffer #$s2 -> address of buffer string
	#accept input from keyboard
	li $v0, 8 #read the input
	la $a0, myString #a0 -> address of myString
	li $a1, 64 #64 max input
	syscall 

	move $s1, $a0 #s0 stores the address of the string
	move $t1, $s1 #t1 temp sotres the address of the string
Loop1: #find the end of string
	lbu $t2, 0($t1) #t2 -> current character
	beqz $t2 Checking #if t2 = \0 character, go to Checking block
	addi $t1, $t1, 1 #if not, move to next character in string
	j Loop1 #jump back to loop1
Checking:#find last a
	addi $t1, $t1, -1 #load last non-0 char from myString to $s1
	lbu $t2, 0($t1) #load s0 word to t2
	beq $t2, $s0, Rewrite#if t2 = 'a' go to Rewrite block
	j Checking #jump back to Checking block
Rewrite: #rewrite myString to buffer
	lbu $t3, 0($s1) #t3 load myString current char
	beqz $t3, Print #if string ends, go to print
	beq $s1, $t1, skip #if current char is last a, skip it
	sb $t3, 0($s2) #store myString char to buffer
	addi $s2,$s2,1 #s2->next character in buffer
	addi $s1, $s1, 1 #s1->next character in myString
	j Rewrite
skip: #skip last a
	addi $s1, $s1, 1 #skip last a char
	j Rewrite
Print:	#print out the string
	li $v0,4 #display string
	la $a0, buffer #load myString address to a0
	syscall
	#Exit
	li $v0, 10
	syscall
