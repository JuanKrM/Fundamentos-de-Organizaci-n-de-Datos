{
3. Realizar un programa que presente un menú con opciones para:
	
	a. Crear un archivo de registros no ordenados de empleados y completarlo con
	datos ingresados desde teclado. De cada empleado se registra: número de
	empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
	DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
	
	b. Abrir el archivo anteriormente generado y
	
		i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
		determinado, el cual se proporciona desde el teclado.
	
		ii. Listar en pantalla los empleados de a uno por línea.
	
		iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
	
	NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.

}
program untitled;

type
	str20 = string[20];
	
	empleados = record
		numero : integer;
		apellido : str20;
		nombre : str20;
		edad : integer;
		dni: integer;
	end;
	
	archivo_empleados = file of empleados;
	
	
	procedure crearArchivo (var archivo:archivo_empleados; nombre_fisico : string);
	var
		unEmpleado:empleados;
	begin
		assign(archivo, nombre_fisico+'.dat'); // Asigno el nombre fisico al archivo
		rewrite(archivo);
		
		write('Ingrese el Apellido : '); readln(unEmpleado.apellido);
		while (unEmpleado.apellido <> 'fin') do begin
			write('Ingrese el Nombre : '); readln(unEmpleado.nombre);
			write('Ingrese el Numero de empleado : '); readln(unEmpleado.numero);
			write('Ingrese la Edad : '); readln(unEmpleado.edad);
			write('Ingrese el DNI : '); readln(unEmpleado.dni);
			
			 write(archivo, unEmpleado);  // Escribir el registro en el archivo
			
			write('Ingrese un nuevo Apellido (Ingrese "fin" para finalizar): '); readln(unEmpleado.apellido);
		end;
		close(archivo);
		writeln('archivo creado exitosamente');
		end;

	procedure busquedaDeEstudiante (nom,ape:str20;var archivo:archivo_empleados);
	var
		unEmpleado:empleados;
		encontrado:boolean;
	begin
		encontrado:=false;
		reset(archivo);
		
		while not EOF(archivo)and (not encontrado) do begin
			read(archivo, unEmpleado); // Guardo empleado en variable
			
			if ((unEmpleado.nombre = nom) and (unEmpleado.apellido = ape)) then begin
				writeln('numero : ',unEmpleado.numero,' apellido : ',unEmpleado.apellido,' nombre : ',unEmpleado.nombre); //Imprimir todos los datos
				encontrado:=true;
			end;
		end;
		if not encontrado then
			writeln('No se encontro un empleado con el nombre ', nom, ' y apellido ', ape);
			
		close(archivo); 
	end;

	procedure unoPorLinea (var archivo:archivo_empleados);
	var
		unEmpleado:empleados;
	begin
		reset(archivo);
		while not EOF(archivo) do begin
			read(archivo, unEmpleado);
			writeln('numero : ',unEmpleado.numero,' apellido : ',unEmpleado.apellido,' nombre : ',unEmpleado.nombre);writeln();//Imprimir todos los datos
		end;
		close(archivo);
	end;

	procedure mayores70 (var archivo:archivo_empleados);
	var
		unEmpleado:empleados;
	begin
		reset(archivo);
		while not EOF(archivo) do begin
			read(archivo, unEmpleado);
			if (unEmpleado.edad > 70) then
				writeln('MAYOR A 70 Numero : ',unEmpleado.numero,' apellido : ',unEmpleado.apellido,' nombre : ',unEmpleado.nombre);//Imprimir todos los datos
		end;
		close(archivo);
	end;

	function verificacionExistencia(var archivo: archivo_empleados,integer:num):boolean;
	var
		aux:boolean;
		dato:empleados;
	begin
		aux:=false;
		reset(archivo);
		while not EOF(archivo) do begin
			read(archivo,dato);
			if (dato.numero = num) then
				aux:=true;
		end;
		close(archivo);
		verificacionExistencia:=aux;
	end;
	
	procedure agregarEmpleados(var archivo: archivo_empleados);
	var
		unEmpleado: empleados;
	begin
		write('Ingrese el Apellido : '); readln(unEmpleado.apellido);
		while (unEmpleado.apellido <> 'fin') do begin
			write('Ingrese el Nombre : '); readln(unEmpleado.nombre);
			write('Ingrese el Numero de empleado : '); readln(unEmpleado.numero);
			write('Ingrese la Edad : '); readln(unEmpleado.edad);
			write('Ingrese el DNI : '); readln(unEmpleado.dni);
			
			if (not verificacionExistencia(archivo,unEmpleado.numero)) then
				write(archivo, unEmpleado)  // Escribir el registro en el archivo
			else
				writeln('ya existe un empleado con ese nuemero');
				
			write('Ingrese un nuevo Apellido (Ingrese "fin" para finalizar): '); readln(unEmpleado.apellido);
		end;
		close(archivo);
		writeln('archivo creado exitosamente');
		end;
	end;


VAR
	nombre_fisico,nombre_buscar,apellido_buscar:str20;
	archivo:archivo_empleados;
	
BEGIN
	write('Ingrese nombre fisico : '); readln(nombre_fisico);
	crearArchivo(archivo,nombre_fisico);						 //Crear Archivo
	
	write('Ingrese el nombre buscado : '); readln(nombre_buscar);
	write('Ingrese el apellido buscado : '); readln(apellido_buscar);
	busquedaDeEstudiante(nombre_buscar,apellido_buscar,archivo); // Inciso B i
	writeln(); 
	unoPorLinea(archivo); // Inciso B ii
	writeln(); 
	mayores70(archivo) //Inciso B iii
	
	//Punto 4
	// menu
	repeat
        writeln('Menú:');
        writeln('1. Añadir empleados');
        writeln('2. Modificar edad de un empleado');
        writeln('3. Exportar todos los empleados a texto');
        writeln('4. Exportar empleados sin DNI a texto');
        writeln('5. Salir');
        write('Seleccione una opción: ');
        readln(opcion);
        case opcion of
            '1': agregarEmpleados(archivo);
            '2': modificarEdad(archivo);
            '3': exportarATexto(archivo);
            '4': exportarSinDNI(archivo);
            '5': writeln('Saliendo...');
        else
            writeln('Opción no válida.');
        end;
    until opcion = '5';
	
END.
