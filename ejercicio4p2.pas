program Practica2ejercicio4;

uses Windows;
const
valoralto = 9999;
type
maquina=record
  cod: integer;
  fecha: String;
  tiempo: integer;
  end;
detalle= file of maquina;
arreglo = array[1..5] of maquina;
var
vec: arreglo;
min, nuevo: maquina;
det1, det2, det3, det4, det5, ma: detalle;
cod, cantiempo: integer;

procedure leer(var archivo: detalle; var dato: maquina);
begin
  if (not EOF(archivo)) then
    read(archivo, dato)
  else
    dato.cod:= valoralto;
end;

procedure minimo (var v: arreglo; var min: maquina);
var
  i, mincod, indimin: integer;
begin
  mincod:= 9998;
  indimin:= -1;
  for i:= 1 to 5 do begin
    if v[i].cod < mincod then begin
      mincod:= v[i].cod;
      indimin:= i;
    end;
  end;
  min:= v[indimin];
  case indimin of
    1: leer(det1, v[1]);
    2: leer(det2, v[2]);
    3: leer(det3, v[3]);
    4: leer(det4, v[4]);
    5: leer(det5, v[5]);
  end;
end;

begin
  assign(ma, '/var/log');
  assign (det1, 'detalle1');
  assign (det2, 'detalle2');
  assign (det3, 'detalle3');
  assign (det4, 'detalle4');
  assign (det5, 'detalle5');

  rewrite(ma);
  reset(det1);
  reset(det2);
  reset(det3);
  reset(det4);
  reset(det5);

  leer(det1, vec[1]);
  leer(det2, vec[2]);
  leer(det3, vec[3]);
  leer(det4, vec[4]);
  leer(det5, vec[5]);

  minimo (vec, min);

  while (min.cod <> valoralto) do begin
    cod:= min.cod;
    cantiempo:= 0;
    while (cod =  min.cod) do begin
       cantiempo:= cantiempo + min.tiempo;
       minimo (vec, min);
    end;
    nuevo.cod:= min.cod;
    nuevo.fecha:= min.fecha;
    nuevo.tiempo:= cantiempo;
    write(ma, nuevo);
  end;
close(det1);
close(det2);
close(det3);
close(det4);
close(det5);
close(ma);
end.

