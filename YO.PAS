program lippu;
uses unit3d,crt;

var
  i,j:integer;
  d,a:real;
  apunayt:array[0..319,0..199]of byte;

procedure play;

begin
  for i:=100 to 200 do
  begin
    for j:=50 to 120 do
    begin
       putpixel(i,j,apunayt[i+round(sin((sqrt(sqr(150-i)+sqr(99-j))+d)*0.1)),
         (j+round(cos((sqrt(sqr(150-i)+sqr(99-j))+d)*0.1)))]
         -round((3*((sin((sqrt(sqr(150-i)+sqr(99-j))+d)*0.1))+1)+(3*(cos((sqrt(sqr(150-i)+sqr(99-j))+d)*0.1)+1)))),vaddr);
    end;
  end;
  a:=a+0.01;
  d:=d+8;
  flip;
end;

begin
  setupvirtual;
  setmcga;
  cls(0,vaddr);
  for i:=150 to 213 do pal(i,i-150,i-150,i-150);
  for i:=86 to 149 do pal(i,0,0,i-50);
  for i:=0 to 85 do pal(i,0,0,0);
  for i:=0 to 319 do for j:=0 to 199 do apunayt[i,j]:=85;
  for i:=102 to 198 do for j:=52 to 118 do apunayt[i,j]:=213;
  {for i:=102 to 198 do for j:=52 to 118 do apunayt[i,j]:=random(255);}
  for i:=102 to 198 do for j:=78 to 92 do apunayt[i,j]:=149;
  for i:=127 to 141 do for j:=52 to 118 do apunayt[i,j]:=149;
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.