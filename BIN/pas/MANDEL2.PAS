program mandelbrot;
uses unit3d, crt;

var
  a:char;
  xsivus,ysivus,xkerr,ykerr,h,tarkkuus:real;

procedure alusta;
var g:integer;
begin
  randomize;
  setmcga;
  for g:=1 to 254 do pal(g,random(63),random(63),random(63));
  pal(51,0,0,0);
end;

procedure piirra;
var
  a,x,y:integer;
  zr,zi,tzr,tzi:real;
  col:integer;

begin
  for x:=0 to 319 do
  for y:=0 to 199 do
  begin
    col:=-round(tarkkuus);
    zr:=0;
    zi:=0;
    while (col<=50)and(sqr(zr)+sqr(zi)<=4) do
    begin
      tzr:=zr;
      tzi:=zi;
      zr:=tzr*tzr-tzi*tzi+x/xkerr-xsivus;
      zi:=tzr*tzi+tzr*tzi+y/ykerr-ysivus;
      col:=col+1;
    end;
    putpixel(x,y,col,vga);
  end;
end;

begin
  alusta;
  ysivus:=1.3848;
  xsivus:=2.8274;
  xkerr:=73.125;
  ykerr:=70.75;
  h:=0.1;
  tarkkuus:=0;
  repeat
    piirra;
    a:=readkey;
    if a='p' then
    begin
      tarkkuus:=tarkkuus+50;

    end;
    if a='o' then
    begin
      tarkkuus:=tarkkuus-50;

    end;
    if a='l' then
    begin
      tarkkuus:=tarkkuus+1;

    end;
    if a='k' then
    begin
      tarkkuus:=tarkkuus-1;

    end;
    if a='8' then
    begin
      ysivus:=ysivus+40/ykerr;

    end;
    if a='4' then
    begin
      xsivus:=xsivus+40/xkerr;
    end;
    if a='6' then
    begin
      xsivus:=xsivus-40/xkerr;
    end;
    if a='2' then
    begin
      ysivus:=ysivus-40/ykerr;

    end;
    if a='+' then
    begin
      xkerr:=xkerr*2;
      ykerr:=ykerr*2;
      xsivus:=xsivus-180/xkerr;
      ysivus:=ysivus-100/ykerr;
    end;
    if a='-' then
    begin
      xsivus:=xsivus+180/xkerr;
      ysivus:=ysivus+100/ykerr;
      xkerr:=xkerr/2;
      ykerr:=ykerr/2;
    end;
  until a='q';
  settext;
  writeln(xkerr);
  writeln(ykerr);
  writeln(xsivus);
  writeln(ysivus);
end.