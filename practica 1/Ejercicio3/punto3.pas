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
		
		repeat
			write('Ingrese el Apellido : '); readln(unEmpleado.apellido);
			if (unEmpleado.apellido <> 'fin') then begin
				write('Ingrese el Nombre : '); readln(unEmpleado.nombre);
				write('Ingrese el Numero de empleado : '); readln(unEmpleado.numero);
				write('Ingrese la Edad : '); readln(unEmpleado.edad);
				write('Ingrese el DNI : '); readln(unEmpleado.dni);
			end;
		until (unEmpleado.apellido = 'fin');
		close(archivo);
		writeln('archivo creado exitosamente');
		end;





VAR
	nombre_fisico,nombre_buscar,apellido_buscar:str20;
	archivo:archivo_empleados;
	
BEGIN
	write('Ingrese nombre fisico : '); readln(nombre_fisico);
	crearArchivo(archivo,nombre_fisico);						 //Crear Archivo
	
	write('Ingrese el nombre buscado : '); readln(nombre_buscar);
	write('Ingrese el apellido buscado : '); readln(apellido_buscar);
END.

