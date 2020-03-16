.data

_readA:  .asciiz "\n Digite o valor do primeiro operando\n"
_readB:  .asciiz "\n Digite o valor do segundo operando\n"
_result: .asciiz "\n Resultado da opera��o: "
_mulStr1: .asciiz " X "
_mulStr2: .asciiz " = "
_newLine: .asciiz "\n"

.text

.globl _AddFunc
.globl _SubFunc
.globl _DivFunc
.globl _MulFunc
.globl _potFunc
.globl _tabFunc

_AddFunc:
	jal _ReadDoubleOperand
	
	add $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu
	
_SubFunc:
	jal _ReadDoubleOperand
	
	sub $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu
	

_DivFunc:
	jal _ReadDoubleOperand
	
	div $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu

_MulFunc:
	jal _ReadDoubleOperand
	
	mul  $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu

######################################################
_potFunc:
	jal _ReadDoubleOperand #$v0 -> A; $v1 -> B ; A^B
	
	#fazer com expoente negativo?
	
	move $t0, $v0 #t0 -> A; reference to multiply
	move $t1, $v1 #t1 -> B; reference to stop
	move $t2, $zero #t2 -> cnt
	li $t3, 1 #t3 -> acumulator (answer) [existe acumulator em ingles? rsrs
	
_potLoop:
	beq $t2, $t1, _potResult #cnt == B
	
	#cnt = cnt*A
	mul $t3, $t3, $t0
	addi $t2, $t2, 1 #cnt++
	
	j _potLoop
	
_potResult:
	move $a0, $t3
	jal _PrintResult
	
_potEnd:
	j _InitMenu
	
######################################################	

_tabFunc:
	jal _ReadSingleOperand
	
	# 2 x 3 = 6
	# 2 x 4 = 8
	# 2 x 5 = 10
	# n x multiplier = current value
	
	move $t0, $v0   #t0 -> n
	li $t1, 10      #t1 -> max multiplication -1 (if t1 is 11, max mult is 10)
	move $t2, $zero #t2 -> multiplier (cnt)
	
_tabLoop:
	beq $t2, $t1, _tabEnd #multiplier == t1
	
	#t3 = n * multiplier
	addi $t2, $t2, 1 #cnt++
	mul $t3, $t0, $t2 #t3 -> result
	
	#printar as criancas
	jal _printMulLine
	
	j _tabLoop
	
_printMulLine:
	# n X multiplier = result
	
	#print "\n"
	li $v0, 4
	la $a0, _newLine
	syscall 
	
	#print n
	li $v0, 1
	move $a0, $t0
	syscall
	
	#print " X "
	li $v0, 4
	la $a0, _mulStr1
	syscall 
	
	#print multiplier
	li $v0, 1
	move $a0, $t2
	syscall
	
	#print " = "
	li $v0, 4
	la $a0, _mulStr2
	syscall
	
	#print result
	li $v0, 1
	move $a0, $t3
	syscall
	
	jr $ra
	
_tabEnd:
	j _InitMenu 

######################################################

_ReadSingleOperand:
	#print
	li $v0, 4
	la $a0,	_readA
	syscall
	
	#Read Operand
	li $v0, 5
	syscall
	
	jr $ra

_ReadDoubleOperand:
 	#print
	li $v0, 4
	la $a0,	_readA
	syscall
	
	#Read A
	li $v0, 5
	syscall
	move $t0, $v0
	
	#print
	li $v0, 4
	la $a0, _readB
	syscall
	
	#Read B
	li $v0, 5
	syscall
	move $t1, $v0
	
	move $v0, $t0
	move $v1, $t1
	
	#return operands in A-> $t0 and B-> $t1
	jr $ra
	
_PrintResult:
	#result need to be in $a0
  	move $a1, $a0
  	
	#print
	li $v0, 4
	la $a0, _result
	syscall
	
	#print result
	li $v0, 1
	move $a0, $a1
	syscall
	
	jr $ra
	
