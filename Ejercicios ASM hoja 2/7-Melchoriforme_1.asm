/*

	7�) Se dice que un vector es Melchoriforme si por lo menos tiene algun eolemento rubio.
		Un elemento V[i] es rubio si cumple lo siguiente:

		La sumatoria de todos los elementos de ese vector debe de ser igual al doble del valor de ese elemento.

		a) Cree una subrutina SumaVector ( V , N ) que sume los N elementos del vector V.

*/

.global start

	.EQU N , 4 // Definimos el n�mero de elementos del vector con una constante N cuyo valor inicial es 4.

.data

	V: .word 1 , 7 , 8 , 6 // Declaramos el vector de datos V. Total suma: 22.

.bss

.text

	start:

	// begin_function_main ********************************************************************************************************

		LDR R0 , =V // Pasamos la direcci�n del vector como par�metro a la funci�n.

		MOV R1 , #N // Pasamos el n�mero de elementos del vector como par�metro.

		BL SumaVector // Saltamos a la funci�n y almacenamos en el Link Register la direcci�n de la siguiente instrucci�n.

	// end_function_main **********************************************************************************************************

	B fin

	// begin_function_SumaVector **************************************************************************************************

	SumaVector: // Comienza la funci�n SumaVector.

		// begin_epilogue

			// En este caso no es necesario guardar nada en el Stack ya que no hay usos anteriores de los registros R4-R11
			// que puedan ser machacados.

			// En caso de que hubieramos usado anteriormente registros como R4 si que habr�amos que haberlos guardado en el
			// Stack mediante PUSH { R4 } y antes de volver haberlo restaurado mediante POP { R3 }

		// end_epilogue

		// begin_function_body

		MOV R2 , #0 // R2 Va a hacer de iterador en nuestro bucle while.

		MOV R3 , #0 // R3 Ser� donde almacenemos los datos del vector.

		MOV R4 , #0 // R4 En �l guardaremos los resultados de las sumas.

		while:

		CMP R2 , #N

		BEQ End_While

			// Obtener V[i]

			LDR R3 , [ R0 , R2 , LSL #2 ]

			// Sumamos los elementos.

			ADD R4 , R4 , R3

			// i++;

			ADD R2 , R2 , #1

		B while

		End_While:

		// end_function_body

		// begin_prologue

			// No hay nada que desapilar.

		// end_prologue

	MOV PC , LR // Indicamos al contador de programa que ejecute la instrucci�n almacenada en la direcci�n que contiene el
				// Link Register. ( Indicamos al programa que RETORNE al main y ejecute la siguiente instrucci�n correspondiente ).

	// ****************************************************************************************************************************

	fin: B .

.end
