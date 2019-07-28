/*

	3º) Crear un programa en el ensamblador del ARM que ejecute una rutina "cuenta0s" que cuente
		el número de ceros que contiene un vector de tamaño arbitrario.

*/

.global start

	.equ LONGITUD , 5 // Vector de longitud 5 ( 0 - 4 ).

.data

	V: .word 1, 0, 2, 0, 0

.bss

.text

	start:

	// begin_function_main ******************************************************************************************

	LDR R0, =V // Almacenamos en R0 la dirección del vector V. Pasamos la dirección de V como pará,etro a la función
			   // mediante el registro R0.

	BL function_cuenta0s

	B fin

	// end_function_main ********************************************************************************************

	// begin_function_cuenta0s **************************************************************************************

	function_cuenta0s: // Comienzo de la función.

		MOV R1, #0 // R1 Será nuestro iterador y lo utilizamos como una "variable" local a la función.

		MOV R2, #0 // R2 Será nuestro contador de ceros y lo utilizamos como una "variable" local a la función.

		MOV R3, #0 // R3 Será utilizado para almacenar el dato a la posición correspondiente del vector.

		while:

		CMP R1, #LONGITUD

		BEQ End_While

			// var = V[i]

			LDR R3, [ R0 , R1 , LSL #2 ]

			// if ( var == 0 )

			CMP R3, #0

			BNE End_If

				// ceros++;

				ADD R2, R2, #1

			End_If:

			// i++;

			ADD R1, R1, #1

		B while

		End_While:

	MOV PC, LR // Fin de la función y regreso a la instrucción correspondiente del main.

	// end_function_cuenta0s ****************************************************************************************

	fin: B .

.end
