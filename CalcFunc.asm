.data
_readSingle: .asciiz "\n Digite o valor do operando\n"
_readA:  .asciiz "\n Digite o valor do primeiro operando\n"
_readB:  .asciiz "\n Digite o valor do segundo operando\n"
_result: .asciiz "\n Resultado da operacao: "
_divErrorMsg: .asciiz "\n ERRO: divisao por 0, refaca o procedimento\n"
_sqrtErrorMsg: .asciiz "\n ERRO: raiz quadrada de n negativo \n"
_fatErrorMsg: .asciiz  "\n ERRO: fatorial de n negativo \n"
_fibErrorMsg: .asciiz  "\n ERRO: o numero da sequencia precisa ser maior que 0 \n"
_potErrorMsg: .asciiz "\n ERRO: o expoente precisa ser positivo, refaca o procedimento"
_beginningFibSeq: .asciiz "\n1 "
_mulStr1: .asciiz " X "
_mulStr2: .asciiz " = "
_newLine: .asciiz "\n"
_space: .asciiz " "

.text

.globl _AddFunc
.globl _SubFunc
.globl _DivFunc
.globl _MulFunc
.globl _SqrtFunc
.globl _FatFunc
.globl _potFunc
.globl _tabFunc
.globl _fibFunc
###############################################################################################
_AddFunc:
	jal _ReadDoubleOperand
	
	add $a0, $v0, $v1
	
	jal _PrintResult
	jal _StoreResult #store $a0 in memory
	j _InitMenu
###############################################################################################	
_SubFunc:
	jal _ReadDoubleOperand
	
	sub $a0, $v0, $v1
	
	jal _PrintResult
	jal _StoreResult #store $a0 in memory
	j _InitMenu
	
###############################################################################################
_DivFunc:
	jal _ReadDoubleOperand
	
	beq $v1, $zero, _divError # division by zero
	
	div $a0, $v0, $v1
	
	jal _PrintResult
	jal _StoreResult #store $a0 in memory
	j _divEnd
	
_divError:
	#print err message
	li $v0, 4
	la $a0, _divErrorMsg
	syscall
	
	j _DivFunc
	
_divEnd:
	j _InitMenu
	 
###############################################################################################
_MulFunc:
	jal _ReadDoubleOperand
	
	mul  $a0, $v0, $v1
	
	jal _PrintResult
	jal _StoreResult #store $a0 in/on memory
	
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
	jal _StoreResult #store $a0 in/on memory

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
	jal _StoreResult #store $a0 in/on memory
	j _InitMenu
	
_fatEnd:
	j _InitMenu

######################################################
_potFunc:
	jal _ReadDoubleOperand #$v0 -> A; $v1 -> B ; A^B
	
	blt $v1, $zero, _potError #fatorial of negative number
	
	move $t0, $v0 #t0 -> A; reference to multiply
	move $t1, $v1 #t1 -> B; reference to stop
	move $t2, $zero #t2 -> cnt
	li $t3, 1 #t3 -> acumulator (answer)
	
_potLoop:
	beq $t2, $t1, _potResult #cnt == B
	
	#cnt = cnt*A
	mul $t3, $t3, $t0
	addi $t2, $t2, 1 #cnt++
	
	j _potLoop
	
_potError:
	li $v0, 4
	la $a0, _potErrorMsg
	syscall
	
	j _potFunc
	
_potResult:
	move $a0, $t3
	jal _PrintResult
	jal _StoreResult #store $a0 in/on memory
	
_potEnd:
	j _InitMenu
	
######################################################	

_tabFunc:
	jal _ReadSingleOperand
	
	#The format is gonna be
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
	
	#print one line
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
	
###############################################################################################
_fibFunc:
	#It'll be used 3 registers to calculate the sequence: t1, t2 and t3
	#Each loop does the following: (1)t3 = t1+t2 ; (2)t1=t2 and t2=t3
	#The second step is a shift of the values. The next loop will calculate the next number based on t1 and t2
	
	
	jal _ReadSingleOperand
	
	blt $v0, 1, _fibError
	
	move $t0, $v0   #t0 -> n
	li $t1, 0
	li $t2, 1
	move $t3, $zero #t3 -> acumulator
	li $t4, 1 #cnt - the beginning point is the 2nd fibonacci sequence number
	
	#print the beginning of the sequence --> "1  "
	li $v0, 4
	la $a0, _beginningFibSeq
	syscall 
	
	j _fibLoop
	
_fibLoop:
	beq $t4, $t0, _fibEnd #Final condition
	
	add $t3, $t1, $t2 #t3 = t1 + t2
	
	jal _printFibSeq #print the number with spaces --> " x "
	
	#shift
	move $t1, $t2
	move $t2, $t3
	
	addi $t4, $t4, 1 #cnt++
	
	j _fibLoop
	
_printFibSeq:
	#print " "
	li $v0, 4
	la $a0, _space
	syscall 
	
	#print n
	li $v0, 1
	move $a0, $t3
	syscall
	
	#print " "
	li $v0, 4
	la $a0, _space
	syscall 
		
	jr $ra
	
_fibError:
	#if the number is 0 or < 0
	li $v0, 4
	la $a0, _fibErrorMsg
	syscall
	
	j _fatEnd	
	
_fibResult:
	move $a0, $t3
	jal _PrintResult
	jal _StoreResult #store $a0 on memory
	j _fibEnd

_fibEnd:
	move $a0, $t3
	jal _StoreResult #store the last fibonacci number on memory
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
