.data

_readA:  .asciiz "\n Digite o valor do primeiro operando\n"
_readB:  .asciiz "\n Digite o valor do segundo operando\n"
_result: .asciiz "\n Resultado da operação: "

.text

.globl _AddFunc
.globl _SubFunc
.globl _DivFunc
.globl _MulFunc

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

	
	
	

	

	
