#Código 2

.global start

.data

	V: .word 12 , 21 , 13 , 14 , 5 , 9
	N: .word 6

.bss

	CuentaTotal: .space 4

.text

	start:

		mov sp , #0x0C200000

		ldr R0 , =V

		ldr R2 , =N

		ldr R1 , [R2]

		bl Cuenta

		ldr R2 , =CuentaTotal

		str R0 , [R2]

	b .

	Cuenta:

	// Esta función llamará a otra función por lo tanto cuando la segunda función
	// retorne a esta, habrá modificado el Link Register y no sabremos volver al main.
	// Tenermos queguardar el Link Register en la pila.

	PUSH { LR } // Apilamos el Link Register en el Stack.

	// PRÓLOGO_1

		mov R4 , #0

		mov R5 , #0

		mov R6 , R0

		mov R7 , R1

		bucle:

		cmp R4 , R7

		beq fin_bucle

			ldr R0 , [R6]

			bl Comprobar

			add R5 , R5 , R0

			add R4 , R4 , #1

			add R6 , R6 , #4

		b bucle

		fin_bucle:

		mov R0 , R5

	// EPÍLOGO_1

		// Tenemos que restaurar el Link Register para poder volver al main.

		POP { R4 }

		mov pc , lr

	Comprobar:

	// El registro R4 si contenía un valor previo, por tanto hemos de
	// pasarlo a la pila.

		PUSH { R4 } // Apilamos R4.

	// PRÓLOGO_2

		mov R4 , #1

		and R0 , R0 , R4

	// EPÍLOGO_2

		POP { R4 } // Desapilamos R4 y restauramos su valor.

		mov pc , lr

.end
