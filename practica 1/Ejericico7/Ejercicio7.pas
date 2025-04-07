program untitled;
{$mode objfpc}
type
	novelas = record
		codigo:integer;
		nombre:string[20];
		genero:string[20];
		precio:real;
		end;

	archivo_nuevo = file of novelas; 

	procedure CargarRegistro (var NovelaT:text;var NovelaB:archivo_nuevo);
	var
		aux:novelas;
	begin
		Reset(NovelaT);
		Rewrite(NovelaB);
		while (not eof(NovelaT)) do begin
			with aux do begin // SE REPITE MIENTRAS EL TEXTO TENGA DATOS
					Readln(NovelaT, codigo, precio, genero);
					Readln(NovelaT, nombre);
					
					Write(NovelaB, aux); // Cargo el binario con el record Aux lleno 
			end;
		end;
		close(NovelaT);close(NovelaB);
	end;

	Procedure AgregarNovela (var bin:archivo_nuevo);
	var
		aux:novelas;
	begin
		Reset(bin);
		writeln('Ingrese los datos de la novela');
		write('Ingrese Codigo (para terminar ingrese "-1"): ');readln(aux.codigo);
		while (aux.codigo <> -1) do begin	
			if (aux.codigo <> -1) then begin
				write('Ingrese el nombre: ');readln(aux.nombre);
				write('Ingrese el genero: ');readln(aux.genero);
				write('Ingrese el precio: ');readln(aux.precio);
				
				// cargamos en la ultima posicion del archivo
				seek (bin,filesize(bin)); //Seek mueve el puntero y filesize(bin) da la ultima posicion del archivo binario
				write(bin, aux); // Cargamos
			end;
			write('Ingrese Codigo (para terminar ingrese "-1"): ');readln(aux.codigo);
		end;
		Close(bin);
	end;

	procedure ModificarNovela (var bin:archivo_nuevo);
	var
		encontrado:boolean;
		codigoBuscado:integer;
		novela:novelas;
		nuevoStr:string[20];
		nuevoReal:real;
	begin
		reset(bin);
		encontrado:=false;
		write('Ingrese el código de la novela a modificar: ');readln(codigoBuscado);
		Seek(bin, 0); // Ir al inicio del archivo
		
		while (not eof(bin)) and (not encontrado) do begin
			Read(bin, novela); // Leer registro actual
			if (novela.codigo = codigoBuscado) then begin
				encontrado := true;
				
				// Mostrar y modificar NOMBRE
				writeln('nombre actual: ', novela.nombre);
				write('Ingrese nuevo nombre : ');
				readln(nuevoStr);
				novela.nombre := nuevoStr;
				
				// Mostrar y modificar GENERO
				writeln('genero actual: ', novela.genero);
				write('Ingrese nuevo genero : ');
				readln(nuevoStr);
				novela.genero := nuevoStr;
				
				// Mostrar y modificar PRECIO
				writeln('precio actual: ', novela.precio);
				write('Ingrese nuevo precio : ');
				readln(nuevoReal);
				novela.precio := nuevoReal;
				
				// Sobrescribir el registro
				Seek(bin, FilePos(bin) - 1); // Retroceder una posición
				Write(bin, novela);
				writeln('¡Stock actualizado!');
			end;
		end;
		close(bin);
	end;
	
	procedure Imprimir (var NovelaB:archivo_nuevo);
	var
		aux:novelas;
	begin
		Reset(NovelaB);
		while (not eof(NovelaB)) do begin
			read(NovelaB,aux);
			writeln('Codigo :',aux.codigo,' nombre : ',aux.nombre,' genero :',aux.genero,' precio ',aux.precio);
		end;
		close(NovelaB);
	end;

	Procedure Menu (var NovelaT:text;var NovelaB:archivo_nuevo);
	var
		opcion:integer;
	begin
		opcion := -1;
		while (opcion <> 0) do begin
		writeln('---------------- Ingrese su opcion ---------------');
		writeln('--------------------------------------------------');
		writeln('1. Pasar de Texto a Binario el Archivo Novelas.txt');
		writeln('2. Agregar Novelas al Binario');
		writeln('3. Modificar Novela Existen');
		writeln('4. Imprimir');
		writeln('0. Finalzar');
		writeln('--------------------------------------------------');
		Readln(opcion);
			case (opcion) of
				1:CargarRegistro(NovelaT,NovelaB);
				2:AgregarNovela(NovelaB);
				3:ModificarNovela(NovelaB);
				4:Imprimir(NovelaB);
				0:writeln(' PROGRAMA FINALIZADO ')
			else
				writeln(' Codigo Invalido ');
			end;
		end;
	end;

VAR
	NovelaB:archivo_nuevo;
	NovelaT:text;
	nombre_fisico:string;
BEGIN
	writeln('Ingrese el nombre fisico del archivo');
	Readln(nombre_fisico);
	Assign(NovelaB,nombre_fisico+'.dat');
	Assign(NovelaT, 'novelas.txt');
	Menu(NovelaT,NovelaB);
END.
