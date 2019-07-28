/*

	4º) Imlementar el algoritmo de la burbuja en ensamblador del ARM.

		Utilicese como referencia el siguiente código de alto nivel.

		do

			swapped=0

			for i from 0 to N‐2 do:

				if V[i] > V[i+1] then

					swap( V[i], V[i+1] )

					swapped = true

				end if

			end for

		while swapped

		NOTA: Definir una constante N que almacene el número de elementos del vector.

*/

.global start

	.equ N , 10

.data

	V: .word 1, 7, 9, 8, 2, 3, 5, 6, 0, 4

.bss

.text

	start:

		// begin_function_main **********************************************************************************************************

		MOV R4, #0 // R4 como un flag boolean que marca la condición de salida.

		LDR R6, =V // R6 como puntero a nuestro vector.

		MOV R7, #0 // R7 como el contenedor del dato de V[i]. También se usa para volcar la dirección de V[i] en R0.

		MOV R8, #0 // R8 como el contenedor del dato de V[i+1]. También se usa para volcar la dirección de V[i+1] en R1.

		MOV R9, #0 // R9 para operaciones intermedias.

		do:

			MOV R4, #0 // R4 será untilizado como un boolean.

			MOV R5, #0 // R5 como el iterador del bucle for.

			for:

			CMP R5, #(N-1)

			BEQ End_For

			LDR R7, [ R6 , R5 , LSL #2 ] // Cargamos en R7 el valor de V[i]

			MOV R9, R5 // R9 = i;

			ADD R9, R9, #1 // R9 = i + 1;

			LDR R8, [ R6 , R9 , LSL #2 ] // Cargamos en R8 el valor de V[i+1]

				// if ( V[i] > V[i+1] )

				CMP R7, R8

				BLE End_If

					// Pasamos a R0 la dirección de V[i] correspondiente.

					MOV R9, R5 // R9 = i

					LSL R9, #2 // Desplazamiento de 2 bits a la zquierda ( i * 4 ).

					ADD R9, R9, R6

					MOV R0, R9

					// Pasamos a R1 la dirección de V[i+1] correspondiente.

					ADD R9, R9, #4

					MOV R1, R9

					// CALL swap

					BL function_swap // Saltamos a la función swap y almacenamos en el Link Register
									 // la dirección de la siguiente instrucción.

					MOV R4, #1 // Flag Boolean --> TRUE ( hubo cambios ).

				End_If:

				// i++;

				ADD R5, R5, #1

			B for

			End_For:

		CMP R4 , #0 // Vemos si R4 contiene 0 (FALSE) o 1 (TRUE).

		BNE do // Si se realizó algún cambio, R0 valdrá 1 y el algoritmo se seguirá ejecutando
			   // hasta que no se produzcan más cambios, vuelta en la que R0 valdrá 1.

		B fin

		// end_function_main *****************************************************************************************************

		// begin_function_swap ***************************************************************************************************

		function_swap: // Comienzo de la función swap

			// R0 y R1 son recividos como parámetros.

			// R0 --> &V[i]

			// R1 --> &V[i+1]

			LDR R2, [R0] // R2 contiene el dato de V[i]

			LDR R3, [R1] // R3 contiene el dato de V[i+1]

			STR R2, [R1] // El dato de R2 pasa a V[i+1]

			STR R3, [R0] // El dato de R3 pasa a V[i]

		MOV PC, LR // Fin de la función y regreso a la instrucción correspondiente del main.

		// end_function_swap *****************************************************************************************************

	fin: B .

.end
