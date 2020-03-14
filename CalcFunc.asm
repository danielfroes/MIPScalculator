.data
_readSingle: .asciiz "\n Digite o valor do operando\n"
_readA:  .asciiz "\n Digite o valor do primeiro operando\n"
_readB:  .asciiz "\n Digite o valor do segundo operando\n"
_result: .asciiz "\n Resultado da operação: "
_divErrorMsg: .asciiz "\n ERRO: divisão por 0\n"
_sqrtErrorMsg: .asciiz "\n ERRO: raiz quadrada de n negativo \n"
_fatErrorMsg: .asciiz  "\n ERRO: fatorial de n negativo \n"

.text

.globl _AddFunc
.globl _SubFunc
.globl _DivFunc
.globl _MulFunc
.globl _SqrtFunc
.globl _FatFunc
###############################################################################################
_AddFunc:
	jal _ReadDoubleOperand
	
	add $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu
###############################################################################################	
_SubFunc:
	jal _ReadDoubleOperand
	
	sub $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu
	
###############################################################################################
_DivFunc:
	jal _ReadDoubleOperand
	
	beq $v1, $zero, _divError # division by zero
	
	div $a0, $v0, $v1
	
	jal _PrintResult
	
	j _divEnd
	
_divError:
	li $v0, 4
	la $a0, _divErrorMsg
	syscall
	
_divEnd:
	j _InitMenu
	 
###############################################################################################
_MulFunc:
	jal _ReadDoubleOperand
	
	mul  $a0, $v0, $v1
	
	jal _PrintResult
	
	j _InitMenu
###############################################################################################
_SqrtFunc:
	#it will be used the newton's method to calculate the floor of the sqrt(n). the method is the following:
	# loop [0 ... n/2]
	#	res = (res + n/res)/2
	
	jal _ReadSingleOperand #$v0 -> n
	
	blt $v0, $zero, _sqrtError #sqrt of negative number
	
	move $t0, $v0 #t0-> n
	move $t1, $zero #t1-> cnt = 0
	move $t2, $t0 #t2-> x = n
	div $t3, $t0, 2 #t3-> n/2 
	
	
_sqrtLoop:
	beq $t1, $t3, _sqrtResult #end condition: cnt == n/2 
	
	#res = (res + n/res)/2
	div $t4, $t0, $t2
	add $t4, $t2, $t4
	div $t2, $t4, 2
		
	addi $t1, $t1, 1 #cnt++
 	
	j _sqrtLoop
	
_sqrtError:
	li $v0, 4
	la $a0, _sqrtErrorMsg
	syscall
	
	j _sqrtEnd
	
_sqrtResult:	
	move $a0, $t2 #put the result as a argument
	jal _PrintResult

_sqrtEnd:
	j _InitMenu
###############################################################################################
_FatFunc:
	jal _ReadSingleOperand
	
	blt $v0, $zero, _fatError #fatorial of negative number
	
	move $t0, $v0   #t0 -> n from n!
	li $t1, 1   #t1 -> result;sets it to 1 
	
	
	beq $t0, $zero, _fatResult #special case of 0! = 1
	
_fatLoop:
	
	beq $t0, 1, _fatResult #end condition when n == 1
	
	mul $t1, $t1, $t0  #r = r*n
	addi $t0, $t0, -1  #n--
	
	j _fatLoop
	
_fatError:
	li $v0, 4
	la $a0, _fatErrorMsg
	syscall
	
	j _fatEnd
	
_fatResult:
	move $a0, $t1  #moving result to argument
	jal _PrintResult

_fatEnd:
	j _InitMenu
	
###############################################################################################
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
###############################################################################################
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
###############################################################################################	
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
###############################################################################################
	
	
	

	

	
