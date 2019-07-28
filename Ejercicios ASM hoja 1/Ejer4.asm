/*

	* 4º) Codificar en ensamblador el siguiente bucle WHILE-DO:

	n = 5;
	fant = 1;
	f = 1;
	i = 2;
	faux = 0;

	while( i <= n )
	{

		faux = f;

		f = f + fant;

		fant = faux;

		i = i + 1;

	}

*/

.global start // El programa comenzará en la etiqueta start

.data // Sección empleada para la declaración de variables.

	// Declaramos etiquetas como alias a direcciones de la memoria principal ( RAM ).

	n: .word 5 // f es un alias de una dirección de memoria que contiene el dato 5.
	fant: .word 1 // fant es un alias de una dirección de memoria que contiene el dato 1.
	f: .word 1 // f es un alias de una dirección de memoria que contiene el dato 1.
	faux: .word 0 // faux es un alias de una dirección de memoria que contiene el dato 0.
	i: .word 2 // i es una dirección de memoria que contiene el dato 2.

.bss // Sección empleada para la reserva de memoria.

.text // Sección que contiene el cuerpo del programa.

	start: // Etiqueta que marca donde comienza a ejecutarse el programa.

		LDR R0, =n // R0 cotiene la dirección de memoria "n".
		LDR R1, =fant // R1 contiene la dirección de memoria "fant".
		LDR R2, =f // R2 contiene la dirección de memoria "f".
		LDR R3, =i // R3 contiene la dirección de memoria "i".
		LDR R4, =faux // R4 contiene la dirección de memoria "faux".

		MOV R5, #0 // R5 es un registro que se inicializa a 0.

		LDR R0, [R0] // Cargamos en R0 el contenido de la dirección guardada en este registro.
		LDR R1, [R1] // Cargamos en R1 el contenido de la dirección guardada en este registro.
		LDR R2, [R2] // Cargamos en R2 el contenido de la dirección guardada en este registro.
		LDR R3, [R3] // Cargamos en R3 el contenido de la dirección guardada en este registro.
		LDR R4, [R4] // Cargamos en R4 el contenido de la dirección guardada en este registro.

		while: // Etiqueta while. Marca el comienzo de la estructura de control WHILE-DO.

		CMP R3, R0 // Instrucción "if". Comparación lógica.
		BLE do // Branch_If Less or Equal ~ Saltamos a la etiqueta "do" si R3 <= R0.

		B End_While // Si R3 < R0 salimos del bucle saltando a la etiqueta "End_While".

		do: // Etiqueta "do". Marca el comienzo del cuerpo de nuestro WHILE-DO.

			// faux = f *****************************************************************************

			MOV R4, R2 // Cargamos en R4 el contenido de R2.

			LDR R5, =faux // Cargamos en R5 la dirección de memoria "faux".

			STR R4, [R5] // Almacenamos el contenido de R4 en la dirección que contenga R5.

			// f = f + fant *************************************************************************

			ADD R2, R2, R1 // R2 = R2 + R1

			LDR R5, =f // Cargamos en R5 la dirección de memoria "f".

			STR R2, [R5] // f = R2

			// fant = faux **************************************************************************

			LDR R5, =fant // Cargamos en R5 la dirección de fant.

			STR R4, [R5] // Almacenamos R4 ( faux ) en la dirección de R5.


			// i = i + 1 ****************************************************************************

			ADD R3, R3, #1 // R3 = R3 + 1

			LDR R5, =i // Cargamos la dirección de i en R5.

			STR R3, [R5] // Almacenamos R4 ( i ) en la dirección de R5.

			// **************************************************************************************

		B while // Hacemos que el bucle vuelva a iterar llamando a la etiqueta while.

		End_While: // Etiqueta que marca el final del bucle while.


	FIN: B . // Final del programa.

.end // Final del programa.
