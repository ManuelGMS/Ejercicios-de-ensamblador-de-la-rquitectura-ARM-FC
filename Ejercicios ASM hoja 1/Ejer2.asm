/*

	* 2º) Codificar en Ensamblador el siguiente bloque IF-THEN-ELSE:

	if( X >= Y )
	{
		X = X + 2;
		Y = Y + 2;
	}
	else
	{
		X = X - 2;
		Y = Y - 2;
	}

*/

.global start // El programa comienza en la instrucción start

.data // Sección en la que se declaran las "variables" mediante Pseudo instrucciones.

	// X e Y como alias de posiciones de memoria, no como los datos que contienen dichas direcciones.

	X: .word 0x0000000A
	Y: .word 0x00000000

.bss // Sección empleada para las declaraciones de reserva de memoria.

.text // Sección que contiene el cuerpo del programa.

	start: // Etiqueta que marca el comienzo del programa.

		LDR R0, =X // R0 carga la dirección de la variable X.
		LDR R1, =Y // R1 carga la dirección de la variable Y.

		MOV R2, R0 // R2 carga la dirección de la variable X.
		MOV R3, R1 // R3 carga la dirección de la variable Y.

		LDR R0, [R0] // R0 carga el valor de la dirección que contiene.
		LDR R1, [R1] // R1 carga el valor de la dirección que contiene.

		CMP R0, R1 // Instrucción "if". Comparación lógica.
		BHS Then // Branch_If Higher or Equal ~ Saltar a la etiqueta "Then" Si el dato de R0 es mayor o igual que el de R1.

		B else // Brach to "else" ~ Saltar a la etiqueta "else"

		Then: // Etiqueta "Then", la cual contiene el código a ejecutar si la condición anterior reultó ser verdadera.

			ADD R0, R0, #2 // R0 = R0 + 2;

			STR R0, [R2] // X = R0

			ADD R1, R1, #2 // R1 = R1 + 2;

			STR R1, [R3] // Y = R1

			B End_If // Brach to "End_If" ~ Saltar a la etiqueta "End_If".

		else: // Etiqueta "else", la cual contiene el código a ejecutar si la condición anterior reultó ser falsa.

			SUB R0, R0, #2 // R0 = R0 - 2;

			STR R0, [R2] // X = R0

			SUB R1, R1, #2 // R1 = R1 - 2;

			STR R1, [R3] // Y = R1

		End_If: // Etiqueta "End_If". marca el final de nuestra estructura IF-THEN-ELSE.

	FIN: B . // Final del programa.

.end // Final del programa.
