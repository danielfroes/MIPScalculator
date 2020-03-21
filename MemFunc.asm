.data

offsetMem: .word 0 #Allocating space on memory with tag offsetMem and putting 0 into this space
memStr: .asciiz "\nO resultado e: "
memErrStr: .asciiz "\ERRO! Essa memoria esta vazia "

.text
.globl _StoreResult
.globl _PrintMem


#arg is in $a0
_StoreResult:
	#cnt++
	lw $t0, offsetMem
	addi $t0, $t0, 4
	sw $t0, offsetMem
	
	addi $sp, $sp, -4
	sw $a0, 0($sp)
		
	jr $ra
	
#arg is in $a0
_PrintMem:
	lw $t0, offsetMem
	
	ble $t0, $a0,  _memError
	

	#load mem 
	add $sp, $sp, $a0 #move $sp to offset
	lw $t0, 0($sp)
	sub $sp, $sp, $a0 #return to initial point
	
	#print result string
	li $v0, 4
	la $a0, memStr
	syscall
	
	#print integer result
	li $v0, 1
	move $a0, $t0
	syscall

	j _memEnd
	
_memError:
	#print error message
	li $v0, 4
	la $a0, memErrStr
	syscall
	
	j _memEnd
	
_memEnd:
	jr $ra
