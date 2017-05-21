program peli;

uses graph,mouse;

const
     gd:integer=detect;
var
     gm:integer;
     maxx,maxy:integer;
     ekax,ekay,x,y,edex,edey:integer;
     entinen:integer;
     col:integer;
     aarg:boolean;

procedure alku;
begin
     initgraph(gd,gm,'c:\turbo\bgi');
     maxx:=getmaxx;
     maxy:=getmaxy;
     edex:=0;
     edey:=0;
     x:=0;
     y:=0;
     ekax:=1;
     ekay:=1;
     col:=1;
     setlinestyle(0,0,3);
     aarg:=true;
end;

begin
     alku;
     repeat
     edex:=x;
     edey:=y;
     x:=mousex;
     y:=mousey;
     if (not(edex=x))or(not(edey=y)) then putpixel(edex,edey,entinen);
     if (not(edex=x))or(not(edey=y)) then entinen:=getpixel(x,y);putpixel(x,y,15);
     if ((mousebutton=1))and((not(edex=x))or(not(edey=y))) then line(ekax,ekay,x,y);ekax:=x;ekay:=y;
     if mouse_clicked(1) then col:=col+1;
     if col=16 then col:=0;
     setcolor(col);
     rectangle(0,0,3,3);
     until mousebutton=3;
     closegraph;
end.
