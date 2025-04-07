program ejercicio6;
{
	EJERCICIO 5 MODIFICACIONES PUNTO 6
		a. Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado
		b. Modificar el stock de un celular dado.
		c. Exportar el contenido del archivo binario a un archivo de texto denominado:
			”SinStock.txt”, con aquellos celulares que tengan stock 0.
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
	
	procedure AgregarCelulares(var aC : archivo_celular);
	var
		nuevo:celular;
	begin
		writeln('INGRESE LOS DATOS DEL CELULAR');
		write('Ingrese Codigo (para terminar ingrese "-1"): ');readln(nuevo.codigo);
		while (nuevo.codigo <> -1) do begin	
			if (nuevo.codigo <> -1) then begin
				write('Ingrese el nombre: ');readln(nuevo.nombre);
				write('Ingrese la descripcion: ');readln(nuevo.descr);
				write('Ingrese la marca: ');readln(nuevo.marca);
				write('Ingrese el precio: ');readln(nuevo.precio);
				write('Ingrese stock MINIMO: ');readln(nuevo.stockMin);
				write('Ingrese stock DISPONIBLE: ');readln(nuevo.StockDispo);
				
				write('Ingrese Codigo (para terminar ingrese "-1"): ');readln(nuevo.codigo);
			end;
			// cargamos en la ultima posicion del archivo
			seek (aC,filesize(aC));
			write(aC, nuevo);
		end;
	end;
	
	procedure ModificarStock(var aC:archivo_celular);
	var
		codigoBuscado: integer;
		cel: celular;
		encontrado: boolean;
		nuevoStock: integer;
	begin
		encontrado := false;
		writeln('Ingrese el código del celular a modificar:');
		readln(codigoBuscado);
		
		Seek(aC, 0); // Ir al inicio del archivo
		while (not eof(aC)) and (not encontrado) do begin
			Read(aC, cel); // Leer registro actual
			if (cel.codigo = codigoBuscado) then begin
				encontrado := true;
				
				// Mostrar stock actual y solicitar nuevo valor
				writeln('Stock actual: ', cel.stockDispo);
				write('Ingrese nuevo stock disponible: ');
				readln(nuevoStock);
				cel.stockDispo := nuevoStock;
				
				// Sobrescribir el registro
				Seek(aC, FilePos(aC) - 1); // Retroceder una posición
				Write(aC, cel);
				writeln('¡Stock actualizado!');
			end;
		end;
		
		if not encontrado then
			writeln('No se encontró un celular con código ', codigoBuscado);
	end;
	
	procedure ExportarContenido(var A:archivo_celular; var archTexto:text);
	var
		cel:celular;
		encontro:boolean;
	begin
		encontro:=false;
		seek(A, 0);
		assign(archTexto,'sinStock.txt');
		rewrite(archTexto);
		while (not eof(A)) do begin
			read(A,cel);
			if (cel.stockDispo=0) then begin
				with cel do begin
				encontro:=true;
				writeln('---------------------------');
				writeln('Codigo de Celular: ',codigo);
				writeln('Precio',precio);
				writeln('Marca: ',marca);
				writeln('Stock Minimo: ',stockMin);
				writeln('Stock disponible: ',stockDispo);
				writeln('Descripcion: ', descr);
				writeln('Nombre: ',nombre);
				writeln('---------------------------');
				
			
				writeln(archTexto, codigo, ' ', precio:0:2, ' ', marca);
				writeln(archTexto,stockMin, ' ', stockDispo, ' ', descr);
				writeln(archTexto, nombre);
				end;
			end;
			writeln('se ha producido correctamente el archivo "sinStock.txt" ');
		end;
		
		close(A);
		close(archTexto);
		if not encontro then
			writeln('No se encontraron Celulares sin stock');
		end;

	procedure seleccionarOpcion(var aC:archivo_celular;var tx:text);
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
			writeln('---- OPCIONES  NUEVAS ----');
			writeln('3. Añadir celulares por teclado');
			writeln('4. Modificar stock');
			writeln('5. Exportar Archivo de binario a texto');
			writeln('0. Seleccione 0 para finalizar');
			
			readln(opcion);
			case opcion of
				1: ListaCelularesConStockMin(aC);
				2: CelularPorDesc(aC);
				3: AgregarCelulares(aC);
				4: ModificarStock(aC);
				5: ExportarContenido(aC,tx);
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
	aCT,nuevoT: Text;
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
    Close(aC);
    Reset(aC);
    
	// ABRO MENU
	seleccionarOpcion(aC,nuevoT);
	
	Assign(aCT, 'celulares_exportados.txt');
	Rewrite(aCT); // Modo escritura
	exportar(aCT, aC);
	close(aCT);
	close(aC);	
END.
