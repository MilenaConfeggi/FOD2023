program ejercicio3TP2;
const
	valoralto=9999;
	cants = 10;
type
	cadena=string[50];
	producto=record
		cod:integer;
		nombre:cadena;
		descripcion:cadena;
		stockDispo:integer;
		stockMin:integer;
		precio:real;
	end;
	
	venta=record
		cod:integer;
		cant:integer;
	end;
	
	master=file of producto;
	detail=file of venta;
	
	details= array[1..cants] of detail;
	reg_detalles= array [1..cants] of venta;




//procedure para crear detalles
procedure crear_detalles(var s: details);
var
	i:integer;
	nombre: string;
begin
	for i:=0 to cants do begin
	    writeln ('ingrese un nombre: ');
	    read(nombre);
		assign(s[i], nombre);     
        reset(s[i]);
        rewrite(s[i]);
    end;
end;
	
	
//procedures para actualizar maestro

procedure leer_detalles(var detalles:details; var vector:reg_detalles);
var
	i:integer;
begin
	for i:=0 to cants do begin
		if not eof(detalles[i]) then
			read(detalles[i],vector[i])
		else
			vector[i].cod:=valoralto;
	end;
end;


procedure leer (var reg:venta; var arch:detail);
begin
	if not eof(arch) then
		read(arch,reg)
	else
		reg.cod:=valoralto;
end;

procedure minimo(var vector:reg_detalles; var min: venta; var detalles:details);
var
	i,codMin,indiceMin:integer;
begin
	codMin:=valoralto;
	indiceMin:=-1;
	for i:=0 to 30 do begin
		if vector[i].cod < codMin then
			indiceMin:=i;
	end;
	if indiceMin<> -1 then begin
		min.cod:=vector[indiceMin].cod;
		min.cant:=vector[indiceMin].cant;
		leer(vector[indiceMin],detalles[indiceMin]);
	end;
end;
			


procedure actualizar_maestro(var maestro:master;var detalles:details);
var
	vectorD:reg_detalles;
	min:venta;
	regM:producto;
begin
	leer_detalles(detalles,vectorD);
	minimo(vectorD,min,detalles);
	while min.cod <> valoralto do begin
		read(maestro,regM);
		while (regm.cod <> min.cod) do
			read(maestro,regM);
		while (regM.cod = min.cod) do begin
			regM.stockDispo:= regM.stockDispo-min.cant;
			minimo(vectorD,min,detalles);
		end;
		seek(maestro,filepos(maestro)-1);
		write(maestro,regM);
	end;
end;
	
	
var
	detalles:details;
	maestro:master;	
begin
	crear_detalles(detalles);
	assign(maestro,'archivo_maestro');
	actualizar_maestro(maestro,detalles);
end.
