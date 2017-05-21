program ilotuli;
uses unit3d,tpr,crt;

var
  tuli:array[0..66]of record
    alkux,alkuy:integer;
    the,ro,ronop:array[0..50]of real;
    vari:array[0..50]of byte;
    nakyy:boolean;
  end;
  i,viive:longint;
  d,vuoro:integer;

procedure play;
begin
  viive:=viive+1;
  if viive=i then
  begin
    vuoro:=vuoro+1;
    if vuoro=61 then vuoro:=0;
    tuli[vuoro].alkux:=random(319);
    tuli[vuoro].alkuy:=random(199);
    tuli[vuoro].nakyy:=true;
    for d:=0 to 50 do
    begin
      tuli[vuoro].the[d]:=0;
      tuli[vuoro].ro[d]:=0;
      tuli[vuoro].ronop[d]:=random(300)/100;
      vari2:=random(3)*64+1;
      tuli[vuoro].vari[d]:=63-(random(10)+
    end;

  end;

end;

begin
  for viive:=1 to 64 do pal(i,i-1,0,0);
  for viive:=65 to 128 do pal(i,0,i-65,0);
  for viive:=129 to 192 do pal(i,0,0,i-129);
  vuoro:=0;
  repeat play;
  until keypressed;
end.

