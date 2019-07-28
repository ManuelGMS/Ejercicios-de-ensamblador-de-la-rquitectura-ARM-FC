/*

	2º) Escribir un programa en ensamblador del ARM que llame a una función "swap(int *a, int *b)".
		La subrutina recibe como parámetro las direcciones de A y B y ha de preservar el valor del
		contenido de todos los registros que se empleen para realizar la operación.

*/

.global start

.data

	A: .word 40

	B: .word 10

.bss

.text

	start:

		// begin_function_main *******************************************************************************

		LDR R0, =A // Almacenamos la direccion A en R0. Pasamos la dirección A como parámetro mediante R0.
		LDR R1, =B // Almacenamos la dirección B en R1. Pasamos la dirección B como parámetro mediante R1.

		BL function_swap // Llamamos a la función swap y almacenamos en el Link Register la dirección de
						 // la siguiente instrucción a ejecutar.

		B fin // Finalizamos el programa.

		// end_function_main *********************************************************************************

		// begin_function_swap ********************************************************************************

		function_swap: // Comienzo de la función.

			LDR R2, [R0] // Almacenamos el dato de la dirección A en R2.
			LDR R3, [R1] // Almacenamos el dato de la dirección B en R3.

			STR R2, [R1] // Almacenamos el dato de A en la dirección B.
			STR R3, [R0] // Almacenamos el dato de B en la dirección A.

		MOV PC, LR // Retorno a la instrucción correspondiente del main.

		// end_function_swap **********************************************************************************

	fin: B .

.end
