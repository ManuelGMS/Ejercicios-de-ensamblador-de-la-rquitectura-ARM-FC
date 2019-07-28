/*

	* 7º) Sea un vector de 10 elementos cualesquiera, realizar un programa en ensamblador
		  que sume uno a uno cada uno de sus componentes.

	NOTA: En este caso, declaro un vector ordenado de 1 a n, de esta forma puedo comprobar
		  el resultado aplicacndo la fórmula de la suma de los n primeros términos: ( ( n * (n + 1) ) / 2 )
		  Siendo 55 el resultado de la suma de los 10 primeros términos ( 55 = 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10 ).

	NOTA: Suponiendo que un programa en alto nivel sea de la forma especificada a continuación. Codifico
		  a lenguaje ensamblador.

		  int i;

		  int Resultado = 0;

		  int V[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

		  for( i = 0 ; i < 10 ; i++ )
		  {

		  	Resultado = Resultado + V[i];

		  }

*/

.global start // El programa comienza en la etiqueta "start".

.data // Sección empleada para la declaración de variables.

	V: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 // V es un alias a la primera dirección de un vector de 10 elementos.

	Resultado: .word 0 // Resultado es un alias a una posición de memoria que contiene el dato 0.

.bss // Sección empleada para la reserva de memoria.

	i: .space 4 // i es un alias de una posición de la memoria a partir de la cual reservamos 4 bytes (1 Palabra).

.text // Sección que contiene el cuerpo de nuestro programa.

	start: // Etiqueta que marca donde comienza a ejecutarse nuestro programa.

		LDR R0, =i // Cargamos en R0 la dirección "i".
		LDR R1, =Resultado // Cargamos en R1 la dirección "Resultado".

		LDR R0, [R0] // Cargamos en R0 el dato de la dirección contenida en ese mismo registro.
		LDR R1, [R1] // Cargamos en R1 el dato de la dirección contenida en ese mismo registro.

		MOV R2, #0 // Inicializamos R2 a cero. Lo utilizaremos para cargar datos de distintas direcciones.

		//******************************************************************************************************

		MOV R3, #0 // Cargamos el dato 0 en R3, utilizaré este registro como "puntero" para ir apuntando a
				   // a distintas posiciones de memoria y así recorrer el vector.

		//******************************************************************************************************

		// i = 0 ;

		MOV R0, #1 // Muevo el dato 1 a R0.

		LDR R2, =i // Cargo la dirección "i" en R2.

		STR R0, [R2] // Almaceno el dato de R0 en la dirección que contenga R2.

		FOR: // Eiqueta que marca el comienzo de la condición lógica de la que depende que se ejecute el bucle FOR.

		// i <= 10 ;

		CMP R0, #10 // Comando "if". Comparación lógica.

		BLE do // Branch_If Less or Equal ~ Saltamos a la etiqueta "do" mientras R0 <= 10.

		B Exit_For // Si R0 > 10 saltamos a la etiqueta "Exit_For" y por tanto salimos del bucle.

		do: // Etiqueta que marca el comienzo del cuerpo del bucle FOR.

			// Resultado = Resultado + V[i];

			LDR R2, =V // Cargamos en R2 la dirección "V".

			LDR R2, [ R2 , R3 ] // R2 Contendrá la dirección del contenido de R2 ( la dirección "V" ) + El contenido del rejistro R3.

			ADD R1, R1, R2 // R1 = R1 + R2

			LDR R2, =Resultado // Cargamos en R2 la dirección "Resultado".

			STR R1, [R2] // Almacenamos el contenido de R1 en la dirección que almacena R2.

			// i++

			ADD R0, R0, #1 // R0 = R0 + 1;

			LDR R2, =i // Cargamos en R2 la dirección "i".

			STR R0, [R2] // Almacenamos R0 en la dirección que contenga el registro R2.

			// R3 Como puntero de desplazamiento.

			ADD R3, R3, #4 // R3 = R3 + 4

		B FOR // Hacemos que el bucle FOR vuelva a iterar llamando a la etiqueta FOR.

		Exit_For: // Etiqueta que marca el final del bucle FOR.

		//******************************************************************************************************

	FIN: B . // Final del programa.

.end // Final del programa.

