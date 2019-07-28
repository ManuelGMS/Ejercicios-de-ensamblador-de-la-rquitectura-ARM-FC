.global start

	// Definimos el tipo BOOLEAN.

	.EQU TRUE  , 1

	.EQU FALSE , 0

	// Definimos la longitud del vector A.

	.EQU M , 4

.data

	// Declaramos explícitamente el vector con 4 datos.

	A: .word 6, 20, 28, 36

	// "cuenta_bonitos" variable que almacena cuantos números bonitos hay en el vector.

	cuenta_bonitos: .word 0

.bss

	// N --> Número que pasaremos como parámetro a la función mediante algún registro.

	N: .space 4

.text

	start:

		// begin_function_main ********************************************************************************************

		LDR R4 , =A // R4 contiene la dirección del vector.

		MOV R5 , #0 // R5 como iterador del bucle.

	 	MOV R6 , #0 // R6 para contar los números bonitos.

		LDR R7 , =cuenta_bonitos // Dirección "cuenta_bonitos".

		LDR R8 , =N // R8 Contiene la dirección de N.

		while:

		CMP R5 , #M

		BEQ End_While

			// es_bonito = bonito( int N );

			LDR R0 , [ R4 , R5 , LSL #2 ] // Almacenamos en R0 el dato correspondiente del vector.

			STR R0 , [R8] // Almaceno R0 en N.

			MOV R0 , R8 // Paso N ( dirección ) a R0 para poder pasarlo a la función como parámetro.

			BL bonito // Saltamos a la función bonito y almacenamos en el Link Register
					  // la dirección de la siguiente instrucción.

			// if( es_bonito == true ) { B = true; } else { B = false; }

			CMP R0 , #1

			BNE End_If

				ADD R6, R6, #1 // bonitos++;

				STR R6 , [R7] // Almacenamos el la cantidad de números bonitos en la dirección "cuenta_bonitos".

			End_If:

			// i++;

			ADD R5, R5, #1

		B while

		End_While:

		B fin

		// end_function_main **********************************************************************************************

		// begin_function_bonito ******************************************************************************************

		bonito: // Comienzo de la función.

			// En R0 está N ( dirección ).

			LDR R0 , [R0] // Reutilizamos R0 para almacenar en el el dato cuya dirección contiene el registro.

			MOV R1 , #1 // R1 Para recorrer los números naturales.

			MOV R2 , #0 // R2 Para realizar la suma de los números naturales.

			WHILE:

			CMP R0 , R2 // Comparamos N (R0) ( pasado por parámetro ) con la suma de números naturales (R2).

			BLE END_WHILE

				// Realizo la suma de los números naturales.

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

		MOV PC , LR // Volvemos a la instrucción correspondiente del main.

		// end_function_bonito ********************************************************************************************

	fin:

.end
