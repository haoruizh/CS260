#Declare the string
.data#store in data
	myString: .asciiz "Hello!\n" #Declare the string called myString and it sotres "Hello!\n"


#Print out the string to the screen
.text#Store in text
.globl main
main:
	la $a0, myString #Store string to register $a0
	li $v0, 4#Print out the string
	syscall#Call OS
	li $v0, 10#Exit
	syscall#Call system
