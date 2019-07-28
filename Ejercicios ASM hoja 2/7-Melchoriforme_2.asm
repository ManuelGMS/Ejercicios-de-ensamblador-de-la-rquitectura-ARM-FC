/*

	7�) Se dice que un vector es Melchoriforme si por lo menos tiene algun eolemento rubio.
		Un elemento V[i] es rubio si cumple lo siguiente:

		La sumatoria de todos los elementos de ese vector debe de ser igual al doble del valor de ese elemento.

		b) Crear un programa que dado un vector V y su dimensi�n N decida si el vector es Melchoriforme mediante
		   el empleo de la funci�n SumaVector.

*/

.global start

	.EQU N , 4 // Definimos el n�mero de elementos del vector con una constante N cuyo valor inicial es 4.

.data

	V: .word 1 , 3 , 8 , 4 // Declaramos el vector de datos V.
						   // Total suma: 16 ( 8 es el elemento rubio y el vector por tanto es Melchoriforme).

	MELCHORIFORME: .word 0 // MELCHORIFORME ser� utilizado como una variable que al final del programa pudea
						   // tener como valor 0 si el vector no es melchoriforme y 1 si lo es. En principio
						   // suponemos que el vector no es Melchoriforme.
.bss

.text

	start:

	// begin_function_main ********************************************************************************************************

		MOV R4 , #0 // R4 como iterador del bucle.

		MOV R5 , #0 // R5 para almacenar los valores de V[i].

		LDR R6 , =V // R6 contendr� la direcci�n de nuestro vector.

		while:

		CMP R4 , #N

		BEQ End_While

			// CALL SumaVector

			LDR R0 , =V // Pasamos la direcci�n del vector como par�metro a la funci�n.

			MOV R1 , #N // Pasamos el n�mero de elementos del vector como par�metro.

			BL SumaVector // Saltamos a la funci�n y almacenamos en el Link Register la direcci�n de la siguiente instrucci�n.

			// Obtenemos el valor V[i]

			LDR R5 , [ R6 , R4 , LSL #2 ]

			/*

				if ( R0 == ( 2 * V[i] ) ) { i = (N - 1); MELCHORIFORME = 1; }

				// Si la suma que retorna de continuo la funci�n es 2 * V[i] ya sabemos que el vector es Melchoriforme.
				// por tanto saldrmos del bucle para indicar que el vector es melchoriforme.

			*/

			MOV R1 , #2 // Reutilizo R1 ahora que la funci�n ha retornado.

			MUL R5 , R1 , R5 // V[i] = v[i] * 2;

			CMP R0 , R5

			BNE End_If

				// i = (N - 1);

				MOV R4 , #N

				SUB R4 , R4 , #1

				// MELCHORIFORME = 1;

				LDR R0 , =MELCHORIFORME // Reutilizo R0 ya que no lo voy a volver a utilizar.

				MOV R1 , #1 // Reutilizo R1 de nuevo.

				STR R1 , [R0] // Almacenamos 1 en MELCHORIFORME.

			End_If:

			// i++;

			ADD R4 , R4 , #1

		B while

		End_While:

	// end_function_main **********************************************************************************************************

	B fin

	// begin_function_SumaVector **************************************************************************************************

	SumaVector: // Comienza la funci�n SumaVector.

		// begin_epilogue

			PUSH { R4 } // R4 es usado en en main y en esta funci�n, luego lo guardamos en el Stack para poder usarlo aqu� en
						// la subrutina.

		// end_epilogue

		// begin_function_body

			MOV R2 , #0 // R2 Va a hacer de iterador en nuestro bucle while.

			MOV R3 , #0 // R3 Ser� donde almacenemos los datos del vector.

			MOV R4 , #0 // R4 En �l guardaremos los resultados de las sumas.

			WHILE:

			CMP R2 , R1

			BEQ END_WHILE

				// Obtener V[i]

				LDR R3 , [ R0 , R2 , LSL #2 ]

				// Sumamos los elementos.

				ADD R4 , R4 , R3

				// i++;

				ADD R2 , R2 , #1

			B WHILE

			END_WHILE:

			MOV R0 , R4 // Devolvemos el valor de la suma del vector mediante R0.

		// end_function_body

		// begin_prologue

			POP { R4 } // Desapilamos R4 y restauramos por tanto su valor antes de regresar al main.

		// end_prologue

	MOV PC , LR // Indicamos al contador de programa que ejecute la instrucci�n almacenada en la direcci�n que contiene el
				// Link Register. ( Indicamos al programa que RETORNE al main y ejecute la siguiente instrucci�n correspondiente ).

	// ****************************************************************************************************************************

	fin: B .

.end
