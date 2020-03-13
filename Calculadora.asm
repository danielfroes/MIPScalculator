.data 
_menuI: .asciiz "\n\nDigite \"C\" para o menu da calculadora e \"M\" para o menu das memórias\n"
_menuC:    .asciiz "\nDigite o número da opção desejada: \n 1-> Adição 2-> Subtração\n 3->Divisao 4->Multiplicação\n 5->Potenciacao 6->Raiz quadradada\n 7-> Tabuada 8->Fatorial\n 9->Fibbonaci\n"
_menuM:    .asciiz "\nMenu memória \n"

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
	
	#exit program
	li $v0, 10
	syscall
			
_CalcMenu:
	#print calculator Menu
	li $v0, 4
	la $a0, _menuC
	syscall
	
	#Read Option (char) from calc Menu and put to t0
	li $v0, 12
	syscall
	move $t0, $v0
	
	beq $t0, '1', _AddFunc
	beq $t0, '2', _SubFunc
	beq $t0, '3', _DivFunc
	beq $t0, '4', _MulFunc
	
	
	#volta para o menu inicial
	j _InitMenu
	
	
_MemMenu:
	#print memory Menu
	li $v0, 4
	la $a0, _menuM
	syscall
	
	#volta para o menu inicial
	j _InitMenu
	
