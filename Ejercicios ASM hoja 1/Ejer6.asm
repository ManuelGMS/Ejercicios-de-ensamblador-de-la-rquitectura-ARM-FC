/*

	* 6º) Pasar el algoritmo de Euclides cuyo código entá escrito en un lenguaje de
		  alto nivel a lenguaje Ensamblador.

		  int a = 5;

		  int b = 15;

		  int mcd;

		  while( a != b )
		  {

		  	if ( a > b )
		  	{

		  		a = a - b;

		  	}
		  	else
		  	{

		  		b = b - a;

		  	}

		  }

*/

.global start // El programa comenzará en la etiqueta start.

.data // Sección que se utiliza para la declaración de variables.

	a: .word 5 // a es un alias de una dirección de memoria que contiene el dato 5
	b: .word 15 // b es un alias de una dirección de memoria qie contiene el dato 15.

.bss // Sección que se utiliza para la reserva de memoria.

	mcd: .space 4 // mcd es un alias de una dirección de memoria ( 4 bytes -> 32 bits -> 1 palabra )
				  // que reservamos para inicializarla más tarde.

.text // Sección que contiene el cuerpo de nuestro programa.

	start: // Etiqueta que marca donde ha de comenzarse a ejecutar el programa.

		//***************************************************************************************************

		LDR R0, =a // Cargamos en R0 la dirección de memoria "a".
		LDR R1, =b // Cargamos en R1 la dirección de memoria de "b".

		LDR R0, [R0] // Cargamos en R0 el dato contenido en la dirección de este mismo registro.
		LDR R1, [R1] // Cargamos en R1 el dato contenido en la dirección de este mismo registro.

		//***************************************************************************************************

		while: // Etiqueta que marca la evaluación lógica del bucle WHILE.

		CMP R0, R1 // Comando "If". Comparación lógica.
		BNE do // Branch_If Not Equal ~ Saltamos a la etiqueta "Do" Si R0 != R1.

		B End_While // Si R0 == R1 entonces saltamos a la etiqueta "End_While".

		do: // Etiqueta que contiene el cuerpo de la

			//***********************************************************************************************

				CMP R0, R1 // Instrucción "If". Comparación lógica.
				BGT Then // Branch_If Greather Than ~ Saltar a la etiqueta "Then" Si R0 > R1.

				B Else // Saltar a la etiqueta "Else".

				Then: // Etiqueta que marca el comienzo del cuerpo de la estructura de control "if".

					SUB R0, R0, R1 // R0 = R0 - R1;

					LDR R2, =a // Almacenamos la dirección "a" en R2.

					STR R0, [R2] // Almacenamos el dato que contenga R0 en la dirección que contenga R2.

					B End_If // Final del bloque "if". Saltamos a la etiqueta "End_If".

				Else: // Etiqueta que marca el comienzo del bloque "Else".

					SUB R1, R1, R0 // R1 = R1 - R0;

					LDR R2, =b // Almacenamos la dirección "b" en R2.

					STR R1, [R2] // Almacenamos el dato que contenga R0 en la dirección que contenga R2.

				End_If:

			//************************************************************************************************

		B while // Hacemos que el bucle vuelva a iterar saltando a la etiqueta "while".

		End_While: // Etiqueta que marca el final del bucle while.

		//****************************************************************************************************

		LDR R2, =mcd // Almacenamos la dirección "mcd" en R2.

		STR R0, [R2] // Almacenamos el dato R0 en la posición de memoria de R2.

		//****************************************************************************************************

	FIN: B . // Final de programa.

.end // Final de programa.
