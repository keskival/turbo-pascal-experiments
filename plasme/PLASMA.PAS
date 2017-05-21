program plasma;
uses unit3d,crt;

var
  x1,y1,x2,y2:integer;
  p1,p2:integer;
  x,y:integer;

procedure play;
begin
  cls(0,vaddr);
  for x:=0 to 319 do
  for y:=0 to 199 do
  begin
    x1:=x-3+random(7);
    y1:=y-3+random(7);
    if x1<0 then x1:=x1+319;
    if y1<0 then y1:=y1+199;
    if x1>319 then x1:=x1-319;
    if y1>199 then y1:=y1-199;
    p1:=getpixel(x1,y1,vga);
    x2:=x-3+random(7);
    y2:=y-3+random(7);
    if x2<0 then x2:=x2+319;
    if y2<0 then y2:=y2+199;
    if x2>319 then x2:=x2-319;
    if y2>199 then y2:=y2-199;
    p2:=getpixel(x2,y2,vga);
    putpixel(x,y,round((p1+p2)/2+random(4)-1),vaddr);
  end;
  flip;
end;


begin
  setmcga;
  randomize;
  setupvirtual;
  cls(0,vga);
  cls(0,vaddr);
  for x:=0 to 319 do for y:=0 to 199 do putpixel(x,y,random(255),vga);
  repeat play;
  until keypressed;
  settext;
end.
