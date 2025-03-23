program ProcesarArchivoNumeros;

type
    archivo_enteros = file of integer;

var
    enteros: archivo_enteros;
    nombre_fisico: string;
    num, suma, cantidad, menores1500: integer;
    promedio: real;

begin
    // Solicitar el nombre del archivo al usuario
    write('Ingrese el nombre del archivo de números enteros: ');
    readln(nombre_fisico);

    // Asignar el nombre lógico al nombre físico
    assign(enteros, nombre_fisico);  // Usar assign en Turbo Pascal

    // Abrir el archivo para lectura
    reset(enteros);

    // Inicializar variables
    suma := 0;
    cantidad := 0;
    menores1500 := 0;

    // Leer los números del archivo
    writeln('Contenido del archivo:');
    while not EOF(enteros) do
    begin
        read(enteros, num);
        writeln(num); // Listar el contenido del archivo en pantalla

        // Sumar para el promedio
        suma := suma + num;
        cantidad := cantidad + 1;

        // Contar números menores a 1500
        if num < 1500 then
            menores1500 := menores1500 + 1;
    end;

    // Cerrar el archivo
    close(enteros);

    // Calcular el promedio
    if cantidad > 0 then
        promedio := suma / cantidad
    else
        promedio := 0;

    // Mostrar resultados
    writeln('Cantidad de números menores a 1500: ', menores1500);
    writeln('Promedio de los números ingresados: ', promedio:0:2);
end.
