/*

	3�) Crear un programa en el ensamblador del ARM que ejecute una rutina "cuenta0s" que cuente
		el n�mero de ceros que contiene un vector de tama�o arbitrario.

*/

.global start

	.equ LONGITUD , 5 // Vector de longitud 5 ( 0 - 4 ).

.data

	V: .word 1, 0, 2, 0, 0

.bss

.text

	start:

	// begin_function_main ******************************************************************************************

	LDR R0, =V // Almacenamos en R0 la direcci�n del vector V. Pasamos la direcci�n de V como par�,etro a la funci�n
			   // mediante el registro R0.

	BL function_cuenta0s

	B fin

	// end_function_main ********************************************************************************************

	// begin_function_cuenta0s **************************************************************************************

	function_cuenta0s: // Comienzo de la funci�n.

		MOV R1, #0 // R1 Ser� nuestro iterador y lo utilizamos como una "variable" local a la funci�n.

		MOV R2, #0 // R2 Ser� nuestro contador de ceros y lo utilizamos como una "variable" local a la funci�n.

		MOV R3, #0 // R3 Ser� utilizado para almacenar el dato a la posici�n correspondiente del vector.

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

	MOV PC, LR // Fin de la funci�n y regreso a la instrucci�n correspondiente del main.

	// end_function_cuenta0s ****************************************************************************************

	fin: B .

.end
