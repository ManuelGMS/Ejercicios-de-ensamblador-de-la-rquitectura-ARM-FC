.global start

	// Definimos el tipo BOOLEAN.

	.EQU TRUE  , 1

	.EQU FALSE , 0

	// Definimos la longitud del vector A.

	.EQU M , 4

.data

	// Declaramos expl�citamente el vector con 4 datos.

	A: .word 6, 20, 28, 36

	// "cuenta_bonitos" variable que almacena cuantos n�meros bonitos hay en el vector.

	cuenta_bonitos: .word 0

.bss

	// N --> N�mero que pasaremos como par�metro a la funci�n mediante alg�n registro.

	N: .space 4

.text

	start:

		// begin_function_main ********************************************************************************************

		LDR R4 , =A // R4 contiene la direcci�n del vector.

		MOV R5 , #0 // R5 como iterador del bucle.

	 	MOV R6 , #0 // R6 para contar los n�meros bonitos.

		LDR R7 , =cuenta_bonitos // Direcci�n "cuenta_bonitos".

		LDR R8 , =N // R8 Contiene la direcci�n de N.

		while:

		CMP R5 , #M

		BEQ End_While

			// es_bonito = bonito( int N );

			LDR R0 , [ R4 , R5 , LSL #2 ] // Almacenamos en R0 el dato correspondiente del vector.

			STR R0 , [R8] // Almaceno R0 en N.

			MOV R0 , R8 // Paso N ( direcci�n ) a R0 para poder pasarlo a la funci�n como par�metro.

			BL bonito // Saltamos a la funci�n bonito y almacenamos en el Link Register
					  // la direcci�n de la siguiente instrucci�n.

			// if( es_bonito == true ) { B = true; } else { B = false; }

			CMP R0 , #1

			BNE End_If

				ADD R6, R6, #1 // bonitos++;

				STR R6 , [R7] // Almacenamos el la cantidad de n�meros bonitos en la direcci�n "cuenta_bonitos".

			End_If:

			// i++;

			ADD R5, R5, #1

		B while

		End_While:

		B fin

		// end_function_main **********************************************************************************************

		// begin_function_bonito ******************************************************************************************

		bonito: // Comienzo de la funci�n.

			// En R0 est� N ( direcci�n ).

			LDR R0 , [R0] // Reutilizamos R0 para almacenar en el el dato cuya direcci�n contiene el registro.

			MOV R1 , #1 // R1 Para recorrer los n�meros naturales.

			MOV R2 , #0 // R2 Para realizar la suma de los n�meros naturales.

			WHILE:

			CMP R0 , R2 // Comparamos N (R0) ( pasado por par�metro ) con la suma de n�meros naturales (R2).

			BLE END_WHILE

				// Realizo la suma de los n�meros naturales.

				ADD R2, R2, R1

				// i++;

				ADD R1, R1, #1

			B WHILE

			END_WHILE:

			// if( R0 == R2 ) { return true; } else { return false; }

			CMP R0 , R2

			BNE ELSE

				MOV R0 , #TRUE // return true;

			B END_IF

			ELSE:

				MOV R0 , #FALSE // return false;

			END_IF:

		MOV PC , LR // Volvemos a la instrucci�n correspondiente del main.

		// end_function_bonito ********************************************************************************************

	fin:

.end
