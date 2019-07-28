/*

	* 9�) Crear un programa en ensamblador que calcule la sucesi�n de FIBONACCI y la almacene en un vector
		  de longitud N.

		  NOTA: Tener en cuenta V(0) = 0, V(1) = 1, V(n) = V(n-1) + V(n-2)

		  Podemos valernos de este c�digo de alto nivel.

		  for i from 0 to N-2 do:

		  	V[i+2] = V[i] + V[i+1]

		  end for

		  NOTA: Mi vector es un vector de 6 elementos y cada posici�n del vector contendr� su correspondiente
		  		elemento de la sucesi�n de FIBONACCI. En mi caso: 0, 1, 1, 2, 3, 5.

*/

.global start // Secci�n empleada para marcar en que etiqueta va a comenzar a ejecutarse el programa y tambi�n
			  // para declarar constantes.

	.equ N, 6 // Constante empleada para la la longitud del vecotr.

.data // Secci�n que se emplea para la declaraci�n de variables.

	V: .word 0, 1, 0, 0, 0, 0 // V es un alias de una direcci�n de memoria.
				  			  // En este caso de la direcci�n en que empieza el vector.

	i: .word 0

.bss // Secci�n emepleada para la reserva de memoria.

.text // Secci�n que contiene el cuerpo de nuestro programa.

	start: // Etiqueta que marca donde comienza a ejecutarse nuestro programa.

		//********************************************************************************************************

		MOV R0, #0 // Inicializamos R0 a 0.

		LDR R0, =V // Utilizaremos el registro R0 para desplazarnos por las distintas posiciones de memoria
				   // que ocupa el vector ( puntero ).

		MOV R1, #0 // Utilizaremos R1 para operar como V[i]
		MOV R2, #0 // Utilizaremos R2 para operar como V[i+1]
		MOV R3, #0 // Utilizaremos R3 para operar como V[i+2]

		//********************************************************************************************************

		MOV R4, #0 // Utilizaremos R4 como registro para operar con "i".

		LDR R4, =i // Cargo en R4 la direcci�n "i".

		LDR R4, [R4] // Cargo en R4 el dato contenido en la direcci�n "i".

		//********************************************************************************************************

		MOV R5, #0 // Utilizaremos R5 para almacenar alg�n dato o direcci�n de forma puntual.

		//********************************************************************************************************

			//****************************************************************************************************

			FOR: // Etiqueta que marca el comienzo de la cabecera l�gica del bucle FOR.

			MOV R5, #N // Cargamos el valor de N en R5.
			SUB R5, R5, #2 // Calculamos N = N - 1 y lo almacenamos en R5

			CMP R4, R5 // Comando "if" Comparaci�n l�gica.

			BLT do // Branch_If Less or Equal ~ Saltamos a la etiqueta do si R4 <= R5

			B Exit_For // Si R2 > R3 entonces llamamos a la etiqueta "Exit_For" para hacer que el bucle termine.

			do: // Etiqueta que marca el comienzo del cuerpo de nuestro bucle for

				// Cargamos V(i)

				LDR R1, [R0]

				// Cargamos V(i+1)

				LDR R2, [R0,#4]

				// Realizamos la suma V[i+2] = V[i] + V[i+1]

				ADD R3, R2, R1
				STR R3, [R0,#8]

				// Avanzamos el registro R0 a la siguiente posici�n ( Movemos el puntero a la siguente posici�n ).

				ADD R0, R0, #4

				// i++

				ADD R4, R4, #1

				LDR R5, =i

				STR R4, [R5]

			B FOR // Hacemos que el bucle vuelva a iterar llamando a la etiqueta FOR.

			Exit_For: // Etiqueta que marca el final del bucle FOR.

			//****************************************************************************************************

	FIN: B . // Final del programa.

.end // Final del programa.
