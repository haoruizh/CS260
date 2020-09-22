#Write a MIPS program that can print
#out the cubic root of 3 up to the precision of 10^?3
#. You shall use Newton’s
#method. The correct answer should be 1.442.

.text
.globl main
main:
#f2 = f(0) = 1.0
li $t0, 1
mtc1 $t0, $f2 #f2->1
cvt.s.w $f2, $f2 #f2->1.0
#f1->3.0
li $t0, 3
mtc1 $t0, $f1 #f1->3
cvt.s.w $f1, $f1
#f0 -> 3.0
mov.s $f0, $f1
#f5 -> precison (10^-3)
li $t0, 1
li $t1, 1000
mtc1 $t0, $f5 #f5->1
cvt.s.w $f5, $f5
mtc1 $t1, $f6 #f6->1000
cvt.s.w $f6, $f6
div.s $f5, $f5, $f6 #f5->0.0001
Loop: #compute (f(k+1) = (2*f(k) + 3/f(k)^2)/3)
mul.s $f4, $f2, $f2 #f4->f(K)^2
div.s $f6, $f0, $f4 #f6->3/f(K)^2
add.s $f6, $f2, $f6 #f6->f(k)+3/f(k)^2
add.s $f2, $f6, $f2 #f2 -> 2f(k)+3/f(k)^2
div.s $f2, $f2, $f1 #f2 = (2f(k)+3/f(k)^2)/3
mov.s $f3, $f2 #f3->f(k+1)
mul.s $f6, $f2, $f2 #f6 = f^2(k)
mul.s $f2, $f2, $f6 #f2->f^3(k)
sub.s $f2, $f2, $f0 #f2=f^3(k)-3
abs.s $f2, $f2 #f2=|f^3(k)-3|
c.lt.s $f2, $f5 #if |f^3(k)-3| < precision
bc1t done#if true, jump out of loop
mov.s $f2, $f3
j Loop
done:
#print out f3
li $v0, 2
mov.s $f12, $f3
syscall
li $v0 10
syscall



