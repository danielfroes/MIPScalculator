.data 
initMenu: .asciiz "Digite \"C\" para o menu da calculadora e \"M\" para o menu das mem�rias\n"
menuC:    .asciiz "\nDigite o n�mero da op��o desejada: \n 1-> adi��o\n 2-> subtra��o\n 3->divisao 4->multiplica��o 5->potenciacao 6->raiz quadradada 7-> Tabuada 8->Fatorial 9->Fibbonaci\n"
menuM:    .asciiz "\nMenu mem�ria \n"

.text
.globl main

main:
	#Print init Menu
	li $v0, 4
	la $a0, initMenu
	syscall
	
	#Read Option (char) from init Menu
	li $v0, 12
	syscall
	
	#Put init Menus' option to t0
	move $t0, $v0

	
	beq $t0, 'C', calcMenu
	beq $t0, 'M', memMenu
	
	#exit program
	li $v0, 10
	syscall
			
calcMenu:
	#print calculator Menu
	li $v0, 4
	la $a0, menuC
	syscall
	
	#volta para o menu inicial
	j main
	
	
memMenu:
	#print memory Menu
	li $v0, 4
	la $a0, menuM
	syscall
	
	#volta para o menu inicial
	j main
	