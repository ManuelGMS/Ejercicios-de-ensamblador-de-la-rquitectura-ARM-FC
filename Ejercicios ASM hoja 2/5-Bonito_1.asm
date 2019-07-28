/*

	5º) Un número es bonito si en menor que cien mil y además su valor se puede obtener como
		la suma de números naturales ( 1 + 2 + 3 + ... + n --> Suma de los n primeros términos: ((n*(n-1))/2) ).
		El programa escribirá 1 en la ariable B si el número es bonito y un 0 si no.

*/

.global start

	// Definimos el tipo BOOLEAN

	/*

		Estilo C/C++

		Forma 1:

			#define TRUE  1

			#define FALSE 0

		Forma 2:

			typedef enum boolean { FALSE = 0 , TRUE = 1 } bool;

	*/

	// Estilo ensamblador del ARM

	.EQU TRUE  , 1
	.EQU FALSE , 0

.data

	N: .word 37 // Numero a comprobar si es bonito.

.bss

	B: .space 4 // Reservamos 4 bytes ( Espacio para un palabra de 32 bits ).

.text

	start:

		LDR R0, =N
		LDR R0, [R0] // R0 contendrá el dato de la dirección N (37).

		MOV R1, #0 // Usaremos R1 para almacenar los resultados de las sumas.

		MOV R2, #1 // Usaremos R2 para recorrer los términos naturales a sumar.

		while:

		CMP R0, R1

		BLE End_While

			ADD R1, R1, R2 // Acumulamos los resultados de las sumas en R1.

			ADD R2, R2, #1 // Incrementamos el número natural.

		B while

		End_While:

		CMP R0, R1

		BNE else // Si el numero no es bonito saltamos a la etiqueta ELSE.

			LDR R0, =B // Reutilizo R0 para obtener la dirección B.

			MOV R1, #TRUE // R1 = 1

			STR R1 , [R0] // Grabamos en B un 1 indicando que el número es bonito.

			B End_If

		else:

			LDR R0, =B // Reutilizo R0 para obtener la dirección B.

			MOV R1 , #FALSE // R1 = 0

			STR R1 , [R0] // Grabamos en B un 0 indicando que el número no es bonito.

		End_If:

	fin:

.end
