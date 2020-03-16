.data 
_menuI: .asciiz "\n\nDigite \"C\" para o menu da calculadora e \"M\" para o menu das mem�rias\n"
_menuC:    .asciiz "\nDigite o n�mero da op��o desejada: \n 1-> Adi��o 2-> Subtra��o\n 3->Divisao 4->Multiplica��o\n 5->Potenciacao 6->Raiz quadradada\n 7-> Tabuada 8->Fatorial\n 9->Fibbonaci\n"
_menuM:    .asciiz "\nMenu mem�ria \n Digite '1', '2' ou '3'\n"

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
	
	j _InitMenu
			
_CalcMenu:
	#print calculator Menu
	li $v0, 4
	la $a0, _menuC
	syscall
	
	#Read Option (char) from calc Menu and put to t0
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
	
	#volta para o menu inicial
	# eu acho que o código nunca chega aqui, pois das funções ele pula direto para _InitMenu
	j _InitMenu
	
	
_MemMenu:
	#print memory Menu
	li $v0, 4
	la $a0, _menuM
	syscall
	
	#Read Option (char) from calc Menu and put to t0
	li $v0, 8
	la $a0,  _memOpt
	li $a1, 4 #4 bytes
	syscall
	
	move $t1, $a0 #protect reference
	
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
	li, $a0, 0
	j _MResult

_M2:
	li, $a0, 4
	j _MResult
	
_M3:
	li, $a0, 8
	j _MResult
	
_MResult:
	jal _PrintMem
	j _MEnd
	
_MEnd:
	#volta para o menu inicial
	j _InitMenu
	