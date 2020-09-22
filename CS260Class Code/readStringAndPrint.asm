#Read a string from keyboard and print it out
.text #Store in text
.globl  main
main:
	li $v0, 8#Read a string from the keyboard
	la $a0, myString #Store myString to $a0 register
	li $a1 1 #Tell OS the most times can be type
	syscall#call systems
	li $v0, 10#Exit program
	syscall#call OS

#declare a string and allocate the space
.data#Store in data
	myString: .space 4 #64-bytes of space called myString
