/*

	* 5�) Codificar en Ensamblador el siguiente bucle FOR:

	for( i = 2 ; i <= n ; i++ )
	{
		f = f + f;
	}

*/

.global start // El programa comenzar� en la etiqueta start.

.data // Secci�n empleada para declarar variables.

	n: .word 4 // n es un alias de una direcci�n que guarda el dato 10.
	f: .word 2 // f es un alias de una direcci�n de memoria que guarda el dato 2.

.bss // Secci�n empleada para la reserva de memoria.

	// Reservamos 4 bytes ( 32 bits -> 1 Palabra ) de memoria para mas tarde inicializar el
	// valor de "i" con el bucle for.

	i: .space 4

.text // Secci�n que contiene el cuerpo del programa.

	start: // Etiqueta que indica el comienzo del programa.

		LDR R0, =n // Cargamos en R0 la direcci�n "n".
		LDR R1, =f // Cargamos en R1 la direcci�n "f".

		LDR R0, [R0] // Cargamos en R0 el contenido de la direcci�n que contiene.
		LDR R1, [R1] // Cargamos en R1 el contenido de la direcci�n que contiene.

		// Estructura de control del flujo del programa "FOR": ***********************************

		MOV R2, #2 // Movemos 2 al registro R0.

		LDR R3, =i // Cargamos en R3 la direcci�n "i".

		STR R2, [R3] // Cargamos en la direcci�n que contiene R3 el dato almacenado en R2.

		FOR: // Etiqueta que marca la evaluaci�n l�gica del bucle for.

		CMP R2, R0 // Comando "if". Comparaci�n l�gica.
		BLE do // Branch_If Less or Equal ~ Saltar a la etiqueta "do" si R2 ( i ) <= R0 ( n ).

		B Exit_For // Si R2 ( i ) > R0 ( n ) entonces salimos del bucle saltando e la etiqueta "Exit_For".

		do: // Etiqueta que marca el comienzo del cuerpo del bucle for.

			ADD R1, R1, R1 // R1 = R1 + R1

			LDR R3, =f // Cargamos en R4 la direcci�n "f".

			STR R1, [R3] // f = R1

			ADD R2, R2, #1 // R2 = R2 + 1

			LDR R3, =i // Cargamos en R3 la direcci�n de "i".

			STR R2, [R3] // Cargamos en la direcci�n que contiene R3 el dato que contenga R2.

		B FOR // Hacemos que el bucle vuelva a iterar llamando a la etiqueta "FOR".

		Exit_For: // Etiqueta que marca el final del bucle for.

		// ****************************************************************************************

	FIN:	B . // Final del programa.

.end			// Final del programa.
