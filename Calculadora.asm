# Comentar e identar tudo

.data 
_menuI: .asciiz "\n\nDigite \"C\" para o menu da calculadora e \"M\" para o menu das memorias\n"
_menuC:    .asciiz "\nDigite o numero da opcao desejada: \n 1-> Adicao 2-> Subtracao\n 3->Divisao 4->Multiplicacao\n 5->Potenciacao 6->Raiz quadradada\n 7-> Tabuada 8->Fatorial\n 9->Fibbonaci\n"
_menuM:    .asciiz "\nMenu memoria \n Digite 'M1', 'M2' ou 'M3'\n"
_endCalc: .asciiz "\nEncerrando programa..."
_debug: .asciiz "\ndebug\n"

_memOpt: .space 4 #Allocate 4 bytes (including \0)

.text
.globl _InitMenu

_InitMenu:
	#Print init Menu
	li $v0, 4
	la $a0, _menuI
	syscall
	
	#Read Option (char) from init Menu and put to t0
	li $v0, 12
	syscall
	move $t0, $v0

	beq $t0, 'C', _CalcMenu
	beq $t0, 'M', _MemMenu
	
	j _EndCalc
			
_CalcMenu:
	#print calculator Menu
	li $v0, 4
	la $a0, _menuC
	syscall
	
	#Read Option (int) from calc Menu and put to t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	beq $t0, 1, _AddFunc
	beq $t0, 2, _SubFunc
	beq $t0, 3, _DivFunc
	beq $t0, 4, _MulFunc
	beq $t0, 5, _potFunc
	beq $t0, 6, _SqrtFunc
	beq $t0, 7, _tabFunc
	beq $t0, 8, _FatFunc
	beq $t0, 9, _fibFunc
	
	j _EndCalc
	
_EndCalc:
	#Print ending message
	li $v0, 4
	la $a0, _endCalc
	syscall
	
	#Finish program
	li $v0, 10
	syscall
	
###################MEMORY FUNCTIONS#######################
_MemMenu:
	#print memory Menu
	li $v0, 4
	la $a0, _menuM
	syscall
	
	#Read Option (string) from calc Menu
	li $v0, 8
	la $a0,  _memOpt
	li $a1, 4 #4 chars to read "M - x - \0 - \n"
	syscall
	
	move $t1, $a0 #protect address of input buffer
	
	#compare 1st byte
	lb $t0, 0($t1)
	bne $t0, 'M', _MEnd
	
	#compare next byte
	addi $t1, $t1, 1
	lb $t0, 0($t1)
	
	beq $t0, '1', _M1
	beq $t0, '2', _M2
	beq $t0, '3', _M3
	
	j _MEnd
	
_M1:
	#show M1 result
	li, $a0, 0
	j _MResult

_M2:
	#show M2 result
	li, $a0, 4
	j _MResult
	
_M3:
	#show M3 result
	li, $a0, 8
	j _MResult
	
_MResult:
	#use $a0 to print the right memory
	jal _PrintMem
	j _MemMenu
	
_MEnd:
	#return to initial menu
	j _InitMenu
	
