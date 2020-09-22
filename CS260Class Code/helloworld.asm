.text#declare to store in text part in memory
.globl main
main:
	la $a0, myString #store myString address in $a0 register
	li $v0, 4# print out a string
	syscall#calls OS
	li $v0, 10#Exit program
	syscall #Calls OS and end program


#Declare a string variable
.data#declare to store in data part in memory
	myString: .asciiz  "HelloWorld!\n"  #declare a string with "HelloWorld!" & stores it in data memory
