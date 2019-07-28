/*

	* 3º) Codifica en ensamblador el siguiente programa.

	A = 81;
	B = 18;

	do
	{

		a = a - b;

	} while ( a > 0 );

*/

.global start // El programa comenzará en la etiqueta start

.data // Sección empleada para la declaración de variables.

	A: .word 81 // A es una alias de una dirección en la cual se almacena el dato 81
	B: .word 18 // B es un alias de una dirección en la cual se almacena el dato 18

.bss // Sección empleada para la reserva de memoria.

.text // Sección que contiene el cuerpo del programa.

	start: // Etiqueta que marca donde comienza a ejecutarse el programa.

		LDR R0, =A // Cargamos en R0 la dirección de A.
		LDR R1, =B // Cargamos en R1 la dirección de B.

		MOV R2, R0 // Pasamos la dirección de A contenida en R0 al registro R2.

		LDR R0, [R0] // Cargamos en R0 el contenido de la dirección que contiene R0.
		LDR R1, [R1] // Cargamos en R1 el contenido de la dirección que contiene R1.

		do: // Etiqueta "do", marcará el pricipio de la estructura de control DO-WHILE

			SUB R0, R0, R1 // R0 = R0 - R1;

			STR R0, [R2] // A = R2

		CMP R0, R1 // Sentencia "if". Comparación lógica.
		BGT do // Brach_If Greather Than ~ Saltar a la etiqueta "do" si R0 > R1.

	FIN: B . // Final del programa.

.end // Final del programa.
