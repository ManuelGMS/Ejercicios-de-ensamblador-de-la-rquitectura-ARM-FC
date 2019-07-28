/*

	* 1º) Codificar en Ensamblador el siguiente bloque IF-ELSE:

	if( x >= y )
	{
		x = x + 2;
		y = y - 2;
	}

*/

.global start // El programa comenzará en la etiqueta start.

.data // Sección empleada para declarar variables.

	// Pseudo instrucciónes para la declaración de las variables A y B.

	// X e Y como "alias" de una dirección de memoria, que no el dato de esas direcciones.

	X: .word 0x0000000A
	Y: .word 0x00000008

.bss // Sección empleada para la reserva de memoria.

.text // Sección que contiene el cuerpo del programa.

	start: // Etiqueta que indica el comienzo del programa...

		LDR R0, =X // R0 Contiene la dirección de la variable X. R0 = Dirección de X
		LDR R1, =Y // R1 Contiene la dirección de la variable y. R1 = Dirección de Y

		MOV R2, R0 // R2 Contiene la dirección de memoria de X.
		MOV R3, R1 // R3 Contiene la dirección de memoria de Y.

		LDR R0, [R0] // Cargamos el contenido de R0 en su mismo registro. R0 = Dato de la dirección de X
		LDR R1, [R1] // Cargamos el contenido de R1 en su mismo registro. R1 = Dato de la dirección de Y.

		CMP R0, R1 // Sentencia "if". Comparación lógica.
		BHS Then // Branch_If Higher or Same ~ Saltar a la etiqueta "Then" si R1 (A) >= R0 (B)

		B End_If // Si la condición no se cumple, salimos del bloque if.

		Then: // Cuerpo del if.

			ADD R0, R0, #2 // R0 = R0 + 2;

			STR R2, [R0] // X = R0

			SUB R1, R1, #2 // B = B - 2;

			STR R3, [R1] // Y = R1

		End_If: // Final del bloque if.

	FIN:	B . // Final del programa.

.end			// Final del programa.



