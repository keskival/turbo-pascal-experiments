program bif;
uses unit3d,crt;

var
  a,b,c:integer;
  d,e,f:real;

begin
  setmcga;
  d:=-2;
  repeat
  e:=d;
  for a:=0 to 1000 do
  begin
    e:=e*e+d;
  end;
  for a:=0 to 1000 do
  begin
    putpixel(round(159.5*d+319),round(39.8*e+99.5),5,vga);
    e:=e*e+d;
  end;
  for c:=0 to 199 do putpixel(round(159.5*(-0.75)+319),c,6,vga);
  d:=d+0.0001;
  until d>0.01;
  readkey;
end.