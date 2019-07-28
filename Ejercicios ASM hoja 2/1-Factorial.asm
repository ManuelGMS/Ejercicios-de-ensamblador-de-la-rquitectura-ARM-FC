/*	​

	1º) Escriba un programa en lenguaje de alto nivel que llame a una función   ​
	    "fact" que calcule el factorial de un número ​usando un bucle.
	    Traduzca el programa al lenguaje ensamblador del ARM.

	#include<stdio.h>

	void fact(int);

	void main(void)
	{

		int number = 0;

		fact( number );

	}

	void fact( int n )
	{

		int i = n - 1;

		while( i > 1 )
		{

			n = n * i;

			i--;

		}

	}

*/

.global start

.data

.bss

.text

	start:

		/*

		Recordamos el estándar del ARM para el uso de funciones:

		Los registros: R0, R1, R2 y R3 se utilizarán para el paso de parámetros.

		NOTA: El valor de los registros R0-R3 pueden ser utilizados por la sub-rutina,
		      son los registros cuyo valor no se preserva.

		El registro R0 se utiliza a modo de valor de retorno.

		NOTA:

			- Registros que no se preservan al ejecutar funciones: R0-R3 ( Proposito general ) , R12 ( Registro temporal ).

			- Registros que se han de preservar al ejecutar funciones: R4-R11 ( Proposito general ) , R13 ( Stack Pointer ) y
			  R14 ( Link Register ).

		*/

		// begin_function_main --> void main(void) *******************************************************************************************

		MOV R0, #5 // R0 será el prámetro a pasar.

		BL function_factorial // Saltamos a la función factorial y almacenamos en el Link Register la dirección de la siguiente instrucción.

		B fin // Finalizamos el programa.

		// end_function_main *****************************************************************************************************************

		// begin_function_fact --> int fact(int) *********************************************************************************************

		function_factorial: // Comienzo de la función factorial.

			MOV R1, R0 // R1 será nuestro iterador. i = n;

			SUB R1, R1, #1 // i--;

			while:

			CMP R1, #1 // Cuando el iterador valga 1, habremos terminado de calcular el factorial.

			BEQ End_While

				MUL R0, R1, R0 // n = i * n;

				SUB R1, R1, #1 // i--;

				B while

			End_While:

		MOV PC, LR // Final de la función factorial y regreso a la instrucción correspondiente del main.

		// end_function_fact *****************************************************************************************************************

	fin: B .

.end
