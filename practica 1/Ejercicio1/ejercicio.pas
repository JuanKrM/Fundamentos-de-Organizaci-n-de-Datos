{
1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
	incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
	cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
	archivo debe ser proporcionado por el usuario desde teclado   
}

program ejercicio1;
type
	archivo_numeros = file of integer;

VAR 
	Enteros: archivo_numeros;
	nombreArchivo: string;
	numero: integer;
	
BEGIN
	writeln('Ingrese el nombre del archivo');
	Readln(nombreArchivo);
	
	Assign(Enteros, nombreArchivo + '.dat');
	Rewrite(Enteros);
	
	writeln('Ingrese un número entero');
	readln(numero);
	while (numero <> 30000) do begin
		write(Enteros, numero);
		writeln('Ingrese un número entero');
		readln(numero);
	end;
	
	close(Enteros);
	writeln('Programa finalizado');
END.


