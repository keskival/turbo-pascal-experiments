program test;

uses
    graph,crt,drivers,objects;
var
   nopeus:real;
   p:pointer;
   graphdriver:integer;
   graphmode:integer;
   c:char;
   ysu,xsu:real;
   x,y:real;
   oldx,oldy:real;
   viive:integer;
   ix,iy,ioldx,ioldy:integer;

begin
graphdriver:=0;
graphmode:=1;
initgraph(graphdriver,graphmode,'c:\turbo\bgi');
clearviewport;
cleardevice;
x:=100;
y:=100;
putpixel(0,0,10);
putpixel(4,0,10);
putpixel(1,1,10);
putpixel(2,1,10);
putpixel(3,1,10);
putpixel(1,2,10);
putpixel(3,2,10);
putpixel(1,3,10);
putpixel(2,3,10);
putpixel(3,3,10);
putpixel(1,4,10);
putpixel(3,4,10);
putpixel(0,5,10);
putpixel(1,5,10);
putpixel(3,5,10);
putpixel(4,5,10);
getimage(0,0,4,5,p^);
cleardevice;
nopeus:=0.001;
repeat
oldx:=x;
oldy:=y;
c:=' ';
if keypressed then c:=readkey;
if c='4' then xsu:=xsu-nopeus;
if c='6' then xsu:=xsu+nopeus;
if c='8' then ysu:=ysu-nopeus;
if c='2' then ysu:=ysu+nopeus;
if x+xsu>743 then xsu:=-xsu;
if x+xsu<0 then xsu:=-xsu;
if y+ysu<0 then ysu:=-ysu;
if y+ysu>480 then ysu:=-ysu;
x:=x+xsu;
y:=y+ysu;
xsu:=xsu+0.0001;
ysu:=ysu+0.0001;
iy:=round(y);
ix:=round(x);
ioldy:=round(oldy);
ioldx:=round(oldx);
if (oldx<>x)or(oldy<>y) then putimage(ioldx,ioldy,p^,xorput);
putimage(ix,iy,p^,normalput);
for viive:=0 to 200 do ;
until c='5'
end.