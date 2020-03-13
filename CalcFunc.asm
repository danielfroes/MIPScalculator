.data
_readSingle: .asciiz "\n Digite o valor do operando\n"
_readA:  .asciiz "\n Digite o valor do primeiro operando\n"
_readB:  .asciiz "\n Digite o valor do segundo operando\n"
_result: .asciiz "\n Resultado da operação: "
_divZero: .asciiz "\n ERRO: divisão por 0\n"

.text

.globl _AddFunc
.globl _SubFunc
.globl _DivFunc
.globl _MulFunc
.globl _FatFunc

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
	
	beq $v1, $zero, _erroDiv
	
	div $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu
	
_erroDiv:
	li $v0, 4
	la $a0, _divZero
	syscall
	
	j _InitMenu
	 

_MulFunc:
	jal _ReadDoubleOperand
	
	mul  $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu

_SqrtFunc:
	jal _ReadSingleOperand
	

	
	jal _PrintResult
	j _InitMenu

_FatFunc:
	jal _ReadSingleOperand
	
	move $t0, $v0   #t0 -> n from n!
	li $t1, 1   #t1 -> result;sets it to 1 
	
	beq $t0, $zero, _endFatLoop #especial case of 0! = 1
	
_fatLoop:
	
	beq $t0, 1, _endFatLoop  #end condition when n == 1
	
	mul $t1, $t1, $t0  #r = r*n
	addi $t0, $t0, -1  #n--
	
	j _fatLoop
	
_endFatLoop:
	
	move $a0, $t1  #moving result to argument
	jal _PrintResult
	j _InitMenu
	

_ReadSingleOperand:
	#print
	li $v0, 4
	la $a0,	_readSingle
	syscall
	
	#Read Operand
	li $v0, 5
	syscall
	
	#return operand in $v0
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
	
	
	jr $ra #return operands in A-> $v0 and B-> $v1
	
_PrintResult:
	#argument to be printed in $a0
  	move $t0, $a0
  	
	#print
	li $v0, 4
	la $a0, _result
	syscall
	
	#print result
	li $v0, 1
	move $a0, $t0
	syscall
	
	jr $ra

	
	
	

	

	
