{A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. 

Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: 
nombre de la provincia, código de localidad, cantidad de alfabetizados y cantidad de encuestados.
 
Se pide realizar los módulos necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.}

program untitled;
type

	datoMaestro = record
		provincia:string[20];
		personas:integer; //ALFABETIZADOS
		encuestados:integer;
	end;
	
	datoDetalle = record
		provincia: string[20];
		localidad: integer;
		personas: integer; //ALFABETIZADOS
		encuestados : integer;
	end;
	
	archivoMaestro = file of datoMaestro;
	archivoDetalle = file of datoDetalle;
	
	procedure leerDetalle(var archivo: archivoDetalle; var aux: datoDetalle);
	begin
		if (not eof(archivo)) then
			read(archivo, aux)
		else
			aux.provincia := 'ZZZ'; //VALOR DE FIN
	
	end;
		
	procedure procesarDetalle(var det: archivoDetalle;var regDet: datoDetalle;var totalAlfab, totalEncues: integer);
	var
		provinciaActual: string[30];
	begin
		provinciaActual := regDet.provincia;
		totalAlfab := 0;
		totalEncues := 0;
		
		while (regDet.provincia = provinciaActual) and (regDet.provincia <> 'ZZZ') do begin
			totalAlfab := totalAlfab + regDet.personas;
			totalEncues := totalEncues + regDet.encuestados;
			leerDetalle(det, regDet);
		end;
	end;
	
	procedure ActualizarMaestro(var mae: archivoMaestro; var det1, det2: archivoDetalle);
	var
		regMae: datoMaestro;
		regDet1, regDet2: datoDetalle;
		provinciaActual: string[30];
		totalAlfab1, totalAlfab2, totalEncues1, totalEncues2: integer;
	begin
		reset(mae);
		reset(det1);
		reset(det2);

		leerDetalle(det1, regDet1);
		leerDetalle(det2, regDet2);

		while (regDet1.provincia <> 'ZZZ') or (regDet2.provincia <> 'ZZZ') do begin
			// Determinar la provincia más pequeña
			if (regDet1.provincia < regDet2.provincia) then
				provinciaActual := regDet1.provincia
			else
				provinciaActual := regDet2.provincia;

			// Procesar ambos detalles para la provincia actual
			if regDet1.provincia = provinciaActual then
				procesarDetalle(det1, regDet1, totalAlfab1, totalEncues1)
			else begin
				totalAlfab1 := 0;
				totalEncues1 := 0;
			end;

			if (regDet2.provincia = provinciaActual) then
				procesarDetalle(det2, regDet2, totalAlfab2, totalEncues2)
			else begin
				totalAlfab2 := 0;
				totalEncues2 := 0;
			end;

			// Actualizar maestro
			repeat
				read(mae, regMae);
			until (regMae.provincia = provinciaActual) or eof(mae);

			if (regMae.provincia = provinciaActual) then begin
				regMae.personas := regMae.personas + totalAlfab1 + totalAlfab2;
				regMae.encuestados := regMae.encuestados + totalEncues1 + totalEncues2;
				seek(mae, filepos(mae)-1);
				write(mae, regMae);
			end;

			seek(mae, 0);  // Resetear puntero
		end;

		close(mae);
		close(det1);
		close(det2);
	end;

var
    maestro: archivoMaestro;
    detalle1, detalle2: archivoDetalle;
begin
    assign(maestro, 'maestro.dat');
    assign(detalle1, 'detalle1.dat');
    assign(detalle2, 'detalle2.dat');
    
    ActualizarMaestro(maestro, detalle1, detalle2);
    writeln('Actualización completada.');
end.
