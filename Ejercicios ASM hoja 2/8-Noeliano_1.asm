/*

	8º) Se dice que un vector V de N elementos es Noeliano si si es una secuencia monótona creciente
		y sus elementos suman en total 45. Ejem: V[6] = { 3 , 5 , 5 , 7 , 10 , 15 }

		a) Escribir una subrutina en ensamblador del ARM Sum45( A , N ) que reciva la dirección
		   de comienzo de un vector A como primer parámetro y el número N de elementos de dicho
		   vector como segundo parámetro. La función ha de devolver 1 si la suma hace 45 y 0
		   en cualquier otro caso.

*/

.global start

	.EQU N , 6

.data

	A: .word 3 , 5 , 5 , 7 , 10 ,15

.bss

.text

	start:

	// begin_function_main **********************************************************************************************

		LDR R0 , =A // La dirección de A será pasado como parámetro a la función mediante R0.

		MOV R1 , #N // El número de elementos del vector A será pasado como parámetro a la función mediante R1.

		BL Suma45 // Saltamos a la función Suma45 y almacenamos en el Link Register la direción de la
				  // siguiente instrucción a ejecutar.

	// end_function_main ************************************************************************************************

	B fin

	// begin_function_Sum45 *********************************************************************************************

	Suma45: // Comienzo de la función Suma45.

		// begin_epilogue

			// Nada que almacenar en el Stack.

		// end_epilogue

		// begin_function_body

			MOV R2 , #0 // R2 Será el iterador de nuestro bucle.

			MOV R3 , #0 // R3 Servirá para almacenar los datos del vector.

			MOV R4 , #0 // R4 Contendrá el resultado de las sumas de los elementos del vector.

			while:

			CMP R1 , R2

			BEQ End_While

				// Obtenemos A[i]

				LDR R3 , [ R0 , R2 , LSL #2 ]

				// Realizamos la suma del elemento actual.

				ADD R4 , R4 , R3

				// i++;

				ADD R2 , R2 , #1

			B while

			End_While:

			// if ( R4 == 45 ) { return 1; } else { return 0; }

			CMP R4 , #45

			BNE else

				MOV R0 , #1 // return 1;

			B End_If

			else:

				MOV R0 , #0 // return 0;

			End_If:

		// end_function_body

		// begin_prologue

			// Nada que restaurar del Stack.

		// end_prologue

	MOV PC , LR // Retorno a la instrucción correspondiente del main.

	// end_function_Sum45 ***********************************************************************************************

	fin: B .

.end
