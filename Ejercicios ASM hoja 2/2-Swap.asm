/*

	2�) Escribir un programa en ensamblador del ARM que llame a una funci�n "swap(int *a, int *b)".
		La subrutina recibe como par�metro las direcciones de A y B y ha de preservar el valor del
		contenido de todos los registros que se empleen para realizar la operaci�n.

*/

.global start

.data

	A: .word 40

	B: .word 10

.bss

.text

	start:

		// begin_function_main *******************************************************************************

		LDR R0, =A // Almacenamos la direccion A en R0. Pasamos la direcci�n A como par�metro mediante R0.
		LDR R1, =B // Almacenamos la direcci�n B en R1. Pasamos la direcci�n B como par�metro mediante R1.

		BL function_swap // Llamamos a la funci�n swap y almacenamos en el Link Register la direcci�n de
						 // la siguiente instrucci�n a ejecutar.

		B fin // Finalizamos el programa.

		// end_function_main *********************************************************************************

		// begin_function_swap ********************************************************************************

		function_swap: // Comienzo de la funci�n.

			LDR R2, [R0] // Almacenamos el dato de la direcci�n A en R2.
			LDR R3, [R1] // Almacenamos el dato de la direcci�n B en R3.

			STR R2, [R1] // Almacenamos el dato de A en la direcci�n B.
			STR R3, [R0] // Almacenamos el dato de B en la direcci�n A.

		MOV PC, LR // Retorno a la instrucci�n correspondiente del main.

		// end_function_swap **********************************************************************************

	fin: B .

.end
