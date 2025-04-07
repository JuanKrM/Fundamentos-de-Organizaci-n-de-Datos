program untitled;

type
	productos = record
		codigo: integer;
		nombre: string[20];
		precio: real;
		stockActual: integer;
		stockMinimo: integer;
	end;
	
	ventas = record
		codigo: integer;
		vendidos: integer;
	end;
	
	archivo_detalle = file of ventas;
	archivo_maestro = file of productos;
	texto = text;
	
procedure ActualizarMestro (var mae:archivo_maestro; var det:archivo_detalle);
var
	refM:productos;
	refD:ventas;
	total,act:integer;
begin
	reset(mae);
	reset(det);
	
	while (not EOF (det)) do begin
		read(det,refD);
		act:=refD.codigo;
		total:=0;
		
		while (refD.codigo = act) and (not eof(det)) do begin
			total:=total+refD.vendidos;
			read(det, refD);
		end;
		
		repeat //Buscamos maestro
			read(mae, refM);
		until (refM.codigo = act) or eof(mae);
		
		//ACTUALIZAMOS
		if (refM.codigo = act) then begin
			refM.stockActual := refM.stockActual - total;
			seek(mae, filepos(mae)-1);
			write(mae,refM);
		end;
		
		seek(mae, 0); //Posiciono nuevamente puntero al maestro
		end;
		
		close(mae);
		close(det);
end;
	
procedure StockMinimoTexto (var maestro:archivo_maestro);
var
	producto:productos;
	txt:texto;
begin
	assign(txt, 'stock_minimo.txt');
	rewrite(txt);
	reset(maestro);
	
	while (not eof(maestro)) do begin
		read(maestro, producto);
		if (producto.stockActual < producto.stockMinimo) then begin
			writeln(txt, 'Código: ', producto.codigo);
            writeln(txt, 'Nombre: ', producto.nombre);
            writeln(txt, 'Stock actual: ', producto.stockActual);
            writeln(txt, 'Stock mínimo: ', producto.stockMinimo);
            writeln(txt, '---------------------');
		end;
	end;	
end;

VAR
	maestro :archivo_maestro;
	detalle :archivo_detalle;
	opcion: integer;
BEGIN
	assign(maestro, 'maestro.dat');
	assign(detalle, 'detalle.dat');
	
	repeat
		writeln('1. Actualizar stock');
        writeln('2. Listar productos con stock bajo mínimo');
        writeln('3. Salir');
        write('Opción: ');
        readln(opcion);

        case opcion of
            1: ActualizarMestro(maestro, detalle);
            2: StockMinimoTexto(maestro);
        end;
    until opcion = 3;
END.

