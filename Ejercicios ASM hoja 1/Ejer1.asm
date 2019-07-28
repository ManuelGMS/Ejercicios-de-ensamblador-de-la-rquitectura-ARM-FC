/*

	* 1�) Codificar en Ensamblador el siguiente bloque IF-ELSE:

	if( x >= y )
	{
		x = x + 2;
		y = y - 2;
	}

*/

.global start // El programa comenzar� en la etiqueta start.

.data // Secci�n empleada para declarar variables.

	// Pseudo instrucci�nes para la declaraci�n de las variables A y B.

	// X e Y como "alias" de una direcci�n de memoria, que no el dato de esas direcciones.

	X: .word 0x0000000A
	Y: .word 0x00000008

.bss // Secci�n empleada para la reserva de memoria.

.text // Secci�n que contiene el cuerpo del programa.

	start: // Etiqueta que indica el comienzo del programa...

		LDR R0, =X // R0 Contiene la direcci�n de la variable X. R0 = Direcci�n de X
		LDR R1, =Y // R1 Contiene la direcci�n de la variable y. R1 = Direcci�n de Y

		MOV R2, R0 // R2 Contiene la direcci�n de memoria de X.
		MOV R3, R1 // R3 Contiene la direcci�n de memoria de Y.

		LDR R0, [R0] // Cargamos el contenido de R0 en su mismo registro. R0 = Dato de la direcci�n de X
		LDR R1, [R1] // Cargamos el contenido de R1 en su mismo registro. R1 = Dato de la direcci�n de Y.

		CMP R0, R1 // Sentencia "if". Comparaci�n l�gica.
		BHS Then // Branch_If Higher or Same ~ Saltar a la etiqueta "Then" si R1 (A) >= R0 (B)

		B End_If // Si la condici�n no se cumple, salimos del bloque if.

		Then: // Cuerpo del if.

			ADD R0, R0, #2 // R0 = R0 + 2;

			STR R2, [R0] // X = R0

			SUB R1, R1, #2 // B = B - 2;

			STR R3, [R1] // Y = R1

		End_If: // Final del bloque if.

	FIN:	B . // Final del programa.

.end			// Final del programa.



