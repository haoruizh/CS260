#Find the second largest number in an array
.data #store array in data
	myArray: .space 20 #array sotres 5 int
	
.text #Store in text
.globl main
main: #main block
	la $s0, myArray #$s0 -> address of myArray
	li $t0, 0 #$t0 -> count and tracking index
	Loop:
		slti $t1, $t0, 5 #If t0 <5,t1=1, else t1=0
		beqz $t1, else #If index > 5, go to else block
			li $v0,5 #ask for the int input from keyboard
			syscall  #Call OS
			sw $v0, 0($s0) #store int to $s0
			addi $s0, $s0 ,4 #Load next element in array, $s0 = $s0 +4
			addi $t0, $t0, 1 #keep track of arrat element $t0++
			j Loop #Back to loop
else:
	j Compare #Go to compare
				
#COMPARE ARRAY ELEMENTS
Compare:
	li $t4, 0 #Keep track of array element
	la $t0, myArray #$t0 -> myArray
	la $t2, 0($t0) #$t2 -> add of array[0]
	la $t3, 4($t0) #t3 -> add of array[1]
	lw $t5, 0($t2) #$t5 -> val of $t2
	lw $t6, 0($t3) #$t6 -> val of $t3
	lw $t7, 0($t0) #$t7 -> val of array[0]
#COMPARE THE FIRST AND SECOND ELEMENT, STORE THEM IN $T2, AND $T3
	blt $t5, $t6, assVal #if array[0]<array[1] (t5 < t6), go to else block
	addi $t0, $t0, 8 #skip array[0] and array[1]
	j comLoop #go to comLoop
assVal:
	la $t2, 4($t0) #t2 -> address of array[1]
	la $t3, 0($t0) #t3 -> address of array[0]
	lw $t5, 0($t2) #$t5 -> val of $t2
	lw $t6, 0($t3) # $t6 -> val of $t3
	addi $t0, $t0, 8 #skip the first and second element
	j comLoop #go to comLoop		
	#COMPARE ARRAY ELEMENTS IN A LOOP
comLoop:
	addi $t4, $t4, 1 #t4++
	slti $t1, $t4, 5 #if t4 <4, t1 = 1, else t1 =0
	lw $t5, 0($t2) #$t5 -> word of $t2
	lw $t6, 0($t3) #$t6 -> word of $t3
	lw $t7, 0($t0) #$t7 -> word of $t0
	beqz $t1, Print #if t1 =0 (t4 > 4), go to Print
	slt $t1, $t7, $t5 #If array element < largest, t1 = 1, else t1 = 0
	beqz $t1, change #if current value of array > val of largest, ($t7 > $t5), go to change
	addi $t0, $t0, 4 #next element
	j comLoop #go to comLoop	
#CHANGE ADDRESS OF $T2 AND $T3
change:  
	la $t3, 0($t2) #$t3 -> address of $t2
	la $t2, 0($t0) #$t2 -> add of current $0
	addi $t0, $t0, 4 #next element
	j comLoop #go to comLoop
					
#PRINT OUT THE SECOND LARGEST NUMBER			
Print:
	li $v0, 1 #print out int
	lw $a0, 0($t3) #$a0 -> val of $t3
	syscall #call OS
#Exit
	li $v0, 10#Exit program
	syscall#call OS
	
