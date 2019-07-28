# Codigo 1

.global start

.data

	V: .word 12,21,13,14,5,9

	N: .word 6

.bss

	CuentaTotal: .space 4

.text

	start:

		ldr R0 , =V

		ldr R2 , =N // N está en la dirección 0xc000018 -- Podemos verlo en la vista "Registers".

		ldr R1 , [R2]

		mov R2 , #0

		mov R3 , #0

		bucle:

		cmp r2 , r1 // Esta instrucción está en la dirección 0c000034 -- Podemos verlo en la vista "Diassembly".

		beq fin_bucle

		ldr R4 , [R0]

		and r4 , r4 , #1

		add r3 , r3 , r4

		add r2 , r2 , #1

		add r0 , r0 , #4

		b bucle

		fin_bucle:

		ldr r1 , =CuentaTotal

		str R3 , [R1]

		// R0 final: 0xc000018

		// R1 final: 0xc000010

		// R2 final: 6

	fin: b .

.end
