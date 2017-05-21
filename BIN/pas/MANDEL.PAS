program mandelbrot;
uses unit3d, crt;

var
  xsivus,ysivus,xkerr,ykerr:real;

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
    col:=0;
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
  ysivus:=1.5;
  xsivus:=2.3;
  xkerr:=79.5;
  ykerr:=66;
  piirra;
  xsivus:=1;
  ysivus:=1;
{  repeat
    piirra;

    xkerr:=xkerr*10;
    ykerr:=ykerr*10;
    xsivus:=xsivus/(xkerr/2);
    ysivus:=ysivus/(ykerr/2);
  until keypressed;}
  readkey;
  settext;
end.