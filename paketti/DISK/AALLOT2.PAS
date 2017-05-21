program vesi;
uses kamaa,crt;

var
  j,i:integer;
  edekerroin,kerroin,muutos:integer;
  sini:array[-20..20,0..319]of byte;
  lonk:longint;

procedure laskesin;
begin
  for i:=-20 to 20 do
  for j:=0 to 319 do sini[i,j]:=99+round(sin(j/10)*i);
end;

procedure piirravesi;
begin
  for i:=0 to 314 do
  begin
    putpixel(i+2,sini[kerroin,i],5,vga);
  end;
end;

procedure pyyhivesi;
begin
  for i:=0 to 314 do
  begin
    putpixel(i+2,sini[edekerroin,i],0,vga);
  end;
end;

begin
  setmcga;
  box(1,78,317,120,2,vga);
  laskesin;
  kerroin:=0;
  muutos:=1;
  repeat
    edekerroin:=kerroin;
    kerroin:=kerroin+muutos;
    if kerroin>=20 then muutos:=-1;
    if kerroin<=-20 then muutos:=1;
    pyyhivesi;
    piirravesi;
    for lonk:=0 to 100000 do;
  until keypressed;
  settext;
end.
