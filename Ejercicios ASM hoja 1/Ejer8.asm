/*

	* 8º) Realizar un program en ensamblador que lea los elementos de un vector de 6 elementos
		  y cuente cuantos de ellos son mayores que 0.

*/

.global start // El programa comienza a ejecutarse en la etiqueta start.

.data // Sección empleada para la declaración de variables.

	V: .word 5, -7, -9, -15, 7, -3 // V es un alias de una dirección que apunta a la primera
								   // posición de un vector.

.bss // Seccion empleada para la reserva de memoria.

.text // Sección que contiene el cuerpo de nuestro programa.

	start: // Etiqueta que marca donde comienza e ejecutarse el programa.

		LDR R0, =V // R0 Contendrá la dirección de "V". Lo utilizaremos para movernos por el vector.

		MOV R1, #0 // Inicializamos R1 a 0. Utilizaremos R1 para operar con los datos que contiene el vector.
		MOV R2, #0 // Inicializamos R2 a 0. Utilizaremos R2 como contador del bucle FOR.
		MOV R3, #0 // Inicializamos R3 a 0. Utilizaremos R3 para contar cuantos de los datos del vector son > 0.

		//*****************************************************************************************************

		FOR: // Etiqueta que marca el comienzo

		CMP R2, #5 // Comparamos R2 con 5 ( R2 - 5 ).
		BLE do // Si el resultado de la comparación es R2 <= 5 entonces saltamos a la etiqueta "do".

		B Exit_For // Si R2 > 5 Entonces saltamos a la etiqueta "Exit_For" para que finalice el bucle.

		do: // Etiqueta que marca el comienzo del cuerpo del bucle FOR.

			LDR R1, [R0] // Cargamos en R1 el contenido de la dirección a la que apunta R0.

			//**************************************************************************************************

			CMP R1, #0 // Compara R1 con 0. Por debajo se realiza la resta del contenido de R1 - 0.
			BGT Then // Saltamos a la etiqueta "Then" si R1 > 0.

			B End_If // Si R1 < 1 Entonces saltamos a la etiqueta "End_If".

			Then: // Etiqueta que marca el comienzo del cuerpo de la estructura de control "if".

				ADD R3, R3, #1 // R3 = R3 + 1;

			End_If: // Etiqueta que marca el final de la estructura de control "if".

			//**************************************************************************************************

			ADD R0, R0, #4 // R0 = R0 + 4; // R0 apunta a la siguiente dirección de memoria del vector.

			ADD R2, R2, #1 // R2 = R2 + 1;

		B FOR // Hacemos que el bucle for vuelva a iterar llamando a la etiqueta FOR.

		Exit_For: // Etiqueta que marca el final del bucle FOR.

		//*****************************************************************************************************

	FIN: B . // Final del programa.

.end // Final del programa.
