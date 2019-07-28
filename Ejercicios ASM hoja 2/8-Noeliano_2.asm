/*

	8º) Se dice que un vector V de N elementos es Noeliano si es una secuencia monótona creciente
		y sus elementos suman en total 45. Ejem: V[6] = { 3 , 5 , 5 , 7 , 10 , 15 }

		b) Escribir un programa en ensamblador del ARM que, utilizando la subrutina anterior,
		   determine si un vector de entrada es noeliano o no.

*/

.global start

	.EQU N , 6

.data

	A: .word 3 , 5 , 5 , 7 , 10 ,15

	NOELIANO: .word 0 // Al final del programa guardaremos aquí un 1 si el vector es Noeliano.

.bss

.text

	start:

	// begin_function_main **********************************************************************************************

		LDR R0 , =A // La dirección de A será pasado como parámetro a la función mediante R0.

		MOV R1 , #N // El número de elementos del vector A será pasado como parámetro a la función mediante R1.

		MOV R4 , #0 // R4 Será el iterador de nuestro bucle.

		MOV R5 , #0 // R5 Contendrá el dato A[i]

		MOV R6 , #0 // R6 Servirá para moverse por el vector.

		MOV R7 , #1 // R7 Como un boolean que indica si el vector es una secuencia monótona creciente.

		// Comprobamos que el vector es una secuencia monótona creciente.

		WHILE:

		CMP R4 , #( N - 1 )

		BEQ END_WHILE

			// Obtenemos A[i]

			LDR R5 , [ R0 , R4 , LSL #2 ]

			// Obtenemos la dirección de A[i]

			MOV R6 , R4

			LSL R6 , #2

			ADD R6 , R6 , R0

			// Bucle interno que revisa que el valor de A[i] actual sea menor o igual que todos los que tiene
			// a la derecha dentro del vector.

			MOV R8 , R4 // R8 Como iterador. Igualamos el iterador del bucle interior con el del bucle exterior.

			ADD R8 , R8 , #1 // i++;

			FOR:

			CMP R8 , #N

			BEQ END_FOR

				// Obtenemos el siguiente valor a la derecha.

				ADD R6 , R6 , #4 // Siguiente dirección.

				LDR R9 , [R6] // Almacenamos el valor de esa dirección.

				// Si el valor de R5 (A[i]) es estrictamente mayor que alguno de los datos entonces el vector no
				// es una estructura monótona creciente. Por tanto igualaremos el iterador R8 a N-1 y pondremos
				// el flag R7 a 0.

				CMP R5 , R9

				BLE END_IF

					MOV R8 , #( N - 1 ) // Servirá para salir del bucle.

					MOV R7 , #0 // Indicamos que el vector ya no es una estructura creciente.

				END_IF:

				// i++;

				ADD R8 , R8 , #1

			B FOR

			END_FOR:

			// i++;

			ADD R4 , R4 , #1

		B WHILE

		END_WHILE:

		// Si el vector es una secuencia monótona creciente entonces llamamos a la función para ver si sus datos suman
		// un total de 45.

		CMP R7 , #1

		BNE END_IF_CRECIENTE

			BL Suma45 // Saltamos a la función Suma45 y almacenamos en el Link Register la direción de la
				  	  // siguiente instrucción a ejecutar.

			CMP R0 , #1

			BNE END_IF_NOELIANO

				LDR R1 , =NOELIANO // Reutilizo R1 ahora que no lo vamo a volver a utilizar.

				STR R0 , [R1] // NOELIANO = 1

			END_IF_NOELIANO:

		END_IF_CRECIENTE:

	// end_function_main ************************************************************************************************

	B fin

	// begin_function_Sum45 *********************************************************************************************

	Suma45: // Comienzo de la función Suma45.

		// begin_epilogue

			// R4 Fué utilizado en el main. Para evitar machacar su valor anterior lo almacenamos en el Stack.

			PUSH { R4 }

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

			// Restauramos el valor de R4 antes de regresar al main.

			POP { R4 }

		// end_prologue

	MOV PC , LR // Retorno a la instrucción correspondiente del main.

	// end_function_Sum45 ***********************************************************************************************

	fin: B .

.end
