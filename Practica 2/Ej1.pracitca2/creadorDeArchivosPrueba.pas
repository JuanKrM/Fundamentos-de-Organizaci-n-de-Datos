program GenerarComisiones;
type
  strCodigo = string[10];
  
  empleado = record
    codigo: strCodigo;
    nombre: string[30];
    monto: real;
  end;

var
  archivo: file of empleado;
  datos: array[1..6] of empleado = (
    (codigo: '001'; nombre: 'Ana Pérez      '; monto: 150.50),
    (codigo: '001'; nombre: 'Ana Pérez      '; monto: 200.00),
    (codigo: '002'; nombre: 'Carlos Gómez   '; monto: 300.00),
    (codigo: '003'; nombre: 'Luisa Martínez '; monto: 100.00),
    (codigo: '003'; nombre: 'Luisa Martínez '; monto: 250.00),
    (codigo: '003'; nombre: 'Luisa Martínez '; monto: 75.50)
  );
  i: integer;

begin
  assign(archivo, 'comisiones.dat');
  rewrite(archivo);
  
  for i := 1 to 6 do
    write(archivo, datos[i]);
  
  close(archivo);
  writeln('Archivo de prueba generado: comisiones.dat');
end.
