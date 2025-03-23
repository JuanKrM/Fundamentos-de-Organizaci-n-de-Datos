program ejercicio5;
{
   Realizar un programa para una tienda de celulares, que presente un menú con
	opciones para:
	a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
	ingresados desde un archivo de texto denominado “celulares.txt”. 
	Los registros
	correspondientes a los celulares deben contener: código de celular, nombre,
	descripción, marca, precio, stock mínimo y stock disponible.
   
}
type
	str20=string[20];
	celular = record
		codigo:integer;
		nombre:str20;
		descr:str20;
		marca:str20;
		precio:real;
		stockMin:integer;
		stockDispo:integer;
	end;
	
	archivo_celular = file of celular;
	
	procedure cargarRegistros(var aCT: text; var aC: archivo_celular);
	var
		cel:celular;
	begin
		while (not eof(aCT))do begin
			with cel do begin
				Readln(aCT, codigo, precio, marca);
				Readln(aCT, stockMin, stockDispo, descr);
				Readln(aCT, nombre);
				
				Write(aC, cel);
			end;
		end;
	end;
	
	procedure ListaCelularesConStockMin(var aC:archivo_celular);
	var
		cel:celular;
		flag:boolean;
	begin
		flag:=false;
		seek(aC,0);
		while (not eof(aC)) do begin
			Read(aC, cel);
			
			if (cel.stockMin>cel.stockDispo) then begin
				writeln('Celular con stock menor al mínimo:  Código: ', cel.codigo:7, '. Precio: $', cel.precio:7:2, '. Stock mínimo: ' ,cel.stockMin:7, '. Stock disponible: ', cel.stockDispo:7, '. Nomdbre: ',cel.nombre:7, '. Descripción ',cel.descr:7, '. Marca: ', cel.marca:7, '.');
				flag:= true;
			end;
		end;
		if (flag = false) then begin
			Writeln('No se encontraron celulares con stock menor al mínimo');
		end;
	end;

	procedure CelularPorDesc(var aC: archivo_celular);
	var
		cadenaBusqueda: str20;
		cel: celular;
		flag: boolean;
	begin
		flag := false;
		seek(aC,0);
		Writeln('Ingrese la cadena a buscar');
		Readln(cadenaBusqueda);
		
		while (not EOF(aC)) do
		begin
			Read(aC, cel);
			
			if (Pos(LowerCase(cadenaBusqueda), LowerCase(cel.descr)) > 0) then begin
				writeln('Celular con stock menor al mínimo:  Código: ', cel.codigo:7, '. Precio: $', cel.precio:7:2, '. Stock mínimo: ' ,cel.stockMin:7, '. Stock disponible: ', cel.stockDispo:7, '. Nomdbre: ',cel.nombre:7, '. Descripción ',cel.descr:7, '. Marca: ', cel.marca:7, '.');
				flag := true;
			end;
		end;
		
		if (not flag) then
			Writeln('No se encontraron celulares con esta descripción.');
	end;
	
	procedure seleccionarOpcion(var aC:archivo_celular);
	var
		opcion:integer;
	begin
		opcion:=-1;
		while (opcion <> 0) do begin
			writeln('--------------------------');
			writeln('--- INGRESE UNA OPCION ---');
			writeln('--------------------------');
			writeln('1. Seleccione 1 para ver el celular stock menor al minimo');
			writeln('2. Seleccione 2 para buscar celular por descripcion');
			writeln('0. Seleccione 0 para finalizar');
			
			readln(opcion);
			case opcion of
				1: ListaCelularesConStockMin(aC);
				2: CelularPorDesc(aC);
				0: writeln('--- PROGRAMA FINALIZADO ---');
				else	
					writeln('---- OPCION INVALIDA ----');
			end;
		end;
	end;

	procedure exportar(var aCT: text; var aC: archivo_celular);
	var
		cel: celular;
	begin
		Seek(aC, 0);
		while (not eof(aC)) do
		begin
			Read(aC, cel);
			with cel do 
				begin
				Writeln(aCT, codigo, precio, marca);
				Writeln(aCT, stockMin, stockDispo, descr);
				Writeln(aCT, nombre);
				end;
		end;

	end;

var
	aCT: Text;
	aC: archivo_celular;
	nombre: String;
BEGIN
	Writeln('Ingrese el nombre del archivo de registros');
	Readln(nombre);
	
	// Cargar desde .txt a .dat
    Assign(aCT, 'celulares.txt');
    Reset(aCT); // Modo lectura para cargarRegistros
    Assign(aC, nombre + '.dat');
    Rewrite(aC);
    cargarRegistros(aCT, aC);
    Close(aCT); // Cierra el .txt después de cargar
    
	// ABRO MENU
	seleccionarOpcion(aC);
	
	AssiGN(aCT, 'celulares_exportados.txt');
	Rewrite(aCT); // Modo escritura
	exportar(aCT, aC);
	close(aCT);
	close(aC);	
END.
