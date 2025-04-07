program ej1.practica2;

type	
	empleados = record
		codigo:integer;
		nombre:string[20];
		monto:real;
	end;
	
	archivo_detalle = file of empleados;
	archivo_maestro = file of empleados;
	
procedure leer(var archivo: archivo_detalle; var dato:empleados);
begin
	if (not EOF(archivo)) then
		read(archivo,dato)
	else
		dato.codigo := 999; //valor alto Indica final
end;
	
var
	detalle : archivo_detalle;
	maestro : archivo_maestro;
	aux, ref : empleados;
	total: real;
begin
	assign (detalle, 'comisiones.dat');
	assign (maestro, 'compacto.dat');
	reset(detalle);
	rewrite(maestro);

	leer (detalle, ref); //Leer primer registro detalle
	
	while (ref.codigo <> 999) do begin
		aux.codigo := ref.codigo; //Inicializamos acumulador para el empleado actual
		aux.nombre := ref.nombre;
		total:=0;
	
		while (ref.codigo = aux.codigo) and (ref.codigo <> 999) do begin
			total:=total+ref.monto;
			leer(detalle, ref);
		end;
		
		//Guardo los datos en maestro
		aux.monto := total;
		write(maestro,aux);
	end;
	
	//cierro
	close(detalle);
	close(maestro);
	
	writeln('Archivo compactado con exito');

end.
