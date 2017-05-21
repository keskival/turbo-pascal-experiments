program test;

uses
    graph,crt,drivers,objects,mouse;
var
   graphdriver:integer;
   graphmode:integer;
   c:char;
   x,y:integer;
   oldx,oldy:integer;
   viive:integer;
   a:boolean;
   tyhja:integer;
   entinen:boolean;

begin
a:=mouse_clicked(1);
oldx:=0;
oldy:=0;
graphdriver:=1;
graphmode:=1;
initgraph(graphdriver,graphmode,'c:\turbo\bgi');
clearviewport;
cleardevice;
x:=0;
y:=0;
tyhja:=getpixel(1,1);
entinen:=false;
cleardevice;
repeat
oldx:=x;
x:=mousex;
oldy:=y;
y:=mousey;
c:=' ';
if keypressed then c:=readkey;
if ((oldx<>x)or(oldy<>y))and(not(mouse_clicked(3)))and(entinen=true) then putpixel(oldx,oldy,tyhja);
if getpixel(x,y)<>tyhja then entinen:=true else entinen:=false;
putpixel(x,y,11);
until c='5'
end.