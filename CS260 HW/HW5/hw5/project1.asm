#3. (Project) Quicksort is an algorithm that sorts an array of n (distinct)
#numbers in O(n log n) time. The algorithm’s psuedo-code can be found right
#under Hoare partition scheme at the following wiki-page:
#https://en.wikipedia.org/wiki/Quicksort
#Please translate the psuedo-code into MIPS and make sure your resulting
#MIPS program indeed works by running it on the following array of seven
#numbers:
#10, 2, 17, 9, 6, 4, 8
#and printing the sorted array on the terminal, that should be
#2, 4, 6, 8, 9, 10, 17.

.data
	array: .space 28 #stores 7 int
.text
.globl main
main:
	la $s0, array#s0 -> array
	li $t0, 0 #t0->0
#input
loop:
	slti $t1, $t0, 7 #if t0 < 7, t1 = 1, else t1 = 0
	beqz $t1, else #if t0>7, go to sort
		li $v0, 5#ask input of int
		syscall
		sw $v0, 0($s0) #save input to array
		addi $s0, $s0, 4 #load next index add in array
		addi $t0, $t0, 1 #increment value
		j loop
else:	#start sort
	la $a0, array #s0->array address
	li $a1, 0 #a0->0 (index)
	li $a2, 6 #a1->6 (index)
	jal quickSort
	#print block
	la $s0, array#s0->array address
	li $t0, 0 #t0->index count
Print:
	slti $t1, $t0, 7
	beqz $t1, exit
		li $v0,1
		lw $a0, 0($s0)
		syscall
		addi $s0, $s0, 4
		addi $t0, $t0, 1
		j Print
exit:
	li $v0, 10
	syscall
quickSort:
	bge $a1, $a2, end
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	jal pivot
	addi $sp, $sp, -4
	sw $v0, 0($sp)
	#sort left
	lw $a2,0($sp)
	jal quickSort
	#sort right
	lw $a2, 12($sp)
	lw $s0, 0($sp)
	addi $a1, $s0, 1
	jal quickSort
	lw $a2, 12($sp)
	lw $a1, 8($sp)
	lw $ra, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 16
end:
	jr $ra
	
	
	
#####################PIVOT FUNCTION##########################################
pivot:
	add $t0, $a1, $a2 # t0 -> pivot = A[(lo+hi)/2]
	div $t0, $t0, 2
	mul $t0, $t0, 4
	add $t0, $a0, $t0
	lw $t0, 0($t0)
	addi $t1, $a1, -1#i=lo-1, t1->i
	addi $t2, $a2, 1#j=hi+1, t2->j
loopForever:
loop1:
	addi $t1, $t1, 1#i=i+1
	mul $t3, $t1, 4#t3->A[i]
	add $t3, $t3, $a0
	lw $t3, 0($t3)
	bge $t3, $t0, loop2 #if A[i] >= pivot, go to loop2
	j loop1 #otherwise, go back to loop1
loop2:
	addi $t2, $t2, -1#j=j-1
	mul $t4, $t2, 4 #t4->A[j]
	add $t4, $t4, $a0
	lw $t4, 0($t4)
	ble $t4, $t0, breakLoop #if A[j]=< pivot, go to exit
	j loop2 #otherwise, go back to loop2
breakLoop:
	blt $t1, $t2, swap
	move $v0, $t2 #if i>=j, return j
	jr $ra
swap:
	mul $t5, $t1, 4 #t5 = a[i] address
	add $t5, $t5, $a0
	sw $t4, 0($t5) #save A[j] to A[i] address
	mul $t5, $t2, 4 #t5 = A[j] address
	add $t5, $t5, $a0
	sw $t3, 0($t5)#save A[i] to A[j] address
	j loopForever
