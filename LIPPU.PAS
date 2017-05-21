program lippu;
uses unit3d,crt;

var
  i,j:integer;
  d,a:real;
  apunayt:array[0..319,0..199]of byte;

procedure play;

begin
  for i:=100 to 200 do for j:=50 to 120 do
  begin
       putpixel(i,j,apunayt[i+round(2*sin(((j+d))/10)),j+round(2.2*cos((i+d)/10))],vaddr);
  end;
  a:=a+0.01;
  d:=d+10*sin(a);
  flip;
end;

begin
  setupvirtual;
  setmcga;
  cls(0,vaddr);
  for i:=0 to 319 do for j:=0 to 199 do apunayt[i,j]:=0;
  {for i:=102 to 198 do for j:=52 to 118 do apunayt[i,j]:=15;}
  for i:=102 to 198 do for j:=52 to 118 do apunayt[i,j]:=random(255);
  for i:=102 to 198 do for j:=78 to 92 do apunayt[i,j]:=1;
  for i:=127 to 141 do for j:=52 to 118 do apunayt[i,j]:=1;
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.