.data

offsetMem: .word 0 #Alocando um espaço na mem com a tag offsetMem e colocando nesse espaço o valor 0
memStr: .asciiz "\nO resultado e: "

.text
.globl _StoreResult
.globl _PrintMem


#arg esta em $a0
_StoreResult:
	#cnt++
	lw $t0, offsetMem
	addi $t0, $t0, 4
	sw $t0, offsetMem
	
	#considerar os casos em q nao ha numeros na mem escolhida
	
	addi $sp, $sp, -4
	sw $a0, 0($sp)
		
	jr $ra
	
#arg esta em $a0
_PrintMem:
	#load mem 
	add $sp, $sp, $a0 #move $sp to offset
	lw $t0, 0($sp)
	sub $sp, $sp, $a0 #there and back again
	
	li $v0, 4
	la $a0, memStr
	syscall
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	jr $ra
	
	
