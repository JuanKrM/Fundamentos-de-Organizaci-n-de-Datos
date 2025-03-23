{
	2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
	creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
	promedio de los números ingresados. El nombre del archivo a procesar debe ser
	proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
	contenido del archivo en pantalla.
}

program ejercicio1;
type
	archivo_enteros = file of integer;
	
var
	enteros : archivo_enteros;
	nombre_fisico : string;
	num, suma, cantidad, menores  :integer;
	prom:real;

BEGIN
	readln(nombre_fisico); // Leo nombre fisico del archivo
	
	assign(enteros, nombre_fisico+'.dat'); // Asigno el nombre fisico al archivo
	
	reset(enteros); // Abro archivo modo lectura
	
	suma:=0;cantidad:=0;menores:=0;prom:=0;
	
	while not EOF(enteros)do begin // mientras que no llegue al final recorro el archivo
		read(enteros,num);
		writeln(num);
		
		
		suma := suma + num;
		cantidad:=cantidad+1;
		
		if (num < 1500) then
			menores:=menores+1;
	end;
	
	close (enteros);
	
	prom := suma/cantidad;
	
	writeln('Cantidad de números menores a 1500: ', menores);
    writeln('Promedio de los números ingresados: ', prom:0:2);
END.
