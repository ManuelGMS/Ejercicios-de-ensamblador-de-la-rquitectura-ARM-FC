/*

	* 10º) Dado un vector A de 12 componentes se desea generar otro vector B, tal que B solo
	       contienelas componenetes de A que son numeros paresmayores que 0 que contiene.

	       Escriba un programa en lenguaje de alto nivel que implemente el procesamiento
	       descrito y calcule el numero de componentes del vector B. Traduzca el programa
	       de alto nivel a ensamblador de ARM.

		#include<stdio.h>

		void main()
		{

		   int i = 0;

		   int p = 0;

		   int A[12] = { 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3 };

		   int B[12] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
			
		   for( i = 0 ; i < 12 ; i++ )
		   {
		       if( ( mod( A[i] , 2 ) == 0 ) and ( A[i] > 0 ) )
		       {
		           B[p] = A[i];
			   p++;
		       }
		   }			

		}		

*/

.global start // El programa comenzará a ejecutarse en la etiqueta start.

.data // Sección que se emplea para declarar  variables.

    i: .word 0 // i es un alias de una dirección de memoria que contiene el dato 0.
    p: .word 0 // p es un alias de una dirección de memoria que contiene el dato 0.

    // A es un alias de una dirección de memoria que apunta a la primera
    // posición de memoria del vector.
    A: .word 0, 1, 2, 7, -8, 4, 5, 12, 11, -2, 6, 3
   
    // B es un alias de una dirección de meoria que apunta la primera
    // posición de memoria del vector. 
    B: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.bss // Sección empleada para reservar memoria.

.text // Sección que contendrá el cuerpo de neustro programa.

	start: // Etiqueta a partir de la cual comienza a ejecutarse el programa.

	    //*************************************************************************

	    // Utilizaremos R0 para trabajar con "i".	

	    LDR R0, =i 
	    LDR R0, [R0]	    

	    // Utilizaremos R1 para trabajar con "p".

	    LDR R1, =p
	    LDR R1, [R1] 

	    //*************************************************************************

	    // Utilizaremos R2 para trabajar con las direcciones del vector A.
	    
	    LDR R2, =A

	    // Utilizaremos R3 para trabajar con los datos contenidos en las
	    // distintas direcciones del vector A.
	    
	    MOV R3, #0

	    //*************************************************************************

	    // Utilizaremos R4 para trabajar con las direcciones del vecctor B.	    

	    LDR R4, =B

	    // Utilizaremos R5 para trabajar con los datos contenidos en las
	    // distintas direcciones del vector b.

	    LDR R5, [R4]

	    //*************************************************************************

	    // Utilizaremos R6 para trabajar con datos puntuales.

	    MOV R6, #0 

	    //*************************************************************************

	    FOR: // Etiqueta que marca el comienzo del bucle for.

	    CMP R0, #12 // Comando "if". Comparación lógica.
	    BLE do: // Si "i" < 12 ejecutamos el bucle for saltando a la etiqueta do.

	    B Exit_For // Si "i" = 12 Salimos del bucle for.

	    do: // Etiqueta que marca el comienzo del bucle for.

		//*********************************************************************

		// mod( A[i] , 2 ) == 0

		// Capturamos en R3 el dato de la posición actual de A que está
		// en el registro R2.

		LDR R3, [R2] 

		DIV R6, R3, #2 // DIV Cociente, Dividendo, Divisor
		MUL R6, R6, R3 // MUL Resultado, Cociente, Divisor
		SUB R6, R3, R6 // SUB Resto, Dividendo, Resultado

		CMP R6, #0 // Comando "if". Comparación lógica.
		
		// Si el resto de la división es 0 entonces saltamos a la etiqueta
		// "Then_par" para ejecutar los comandos contenidos en el cuerpo
		// de la estructura if.

		BEQ Then_Par 

		B End_If_Par // Si el número no es par entonces salgo del if.

		Then_Par: // Etiqueta que marca el comienzo de la estructura if.

		    //*****************************************************************

		    // A[i] > 0

		    CMP R3, #0
		    BGT Then_Mayor

		    B End_If_Mayor
	
		    Then_Mayor:

			// B[p] = A[i];

			STR R4, R3 

			// R4 apunta a la siguiente dirección de memoria de B.			

			ADD R4, R4, #4 

		    End_If_Mayor: // Etiqueta que marca el final del segundo if.

		    //*****************************************************************

		End_If_Par: // Etiqueta que marca el final del primer if.

		//*********************************************************************

		// Pasamos el puntero R2  a la siguiente direccion de memoria.

		ADD R2, R2, #4

		//*********************************************************************

		// i++

		ADD R0, R0, #1

		LDR R6, =i

		STR R0, R6

	    B FOR // Hacemos que el bucle vuelva a iterar llamando a la etiqueta FOR.

	    Exit_For: // Etiqueta que marca el fin del bucle FOR.

	    //*************************************************************************

	FIN: B . // Final del programa.

.end // Final del programa.
