program matrix;
uses unit3d,crt;

var
  x1,y1,x2,y2:integer;
  p1,p2:integer;
  matriisi: array[0..1,0..1]of real;
  x,y:integer;
  a,b:byte;

procedure play2;
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
    putpixel(x,y,round((p1+p2)/2),vaddr);
  end;
  flip;
end;

procedure play;
begin
  for y:=0 to 99 do for x:=0 to 319 do
  begin
    a:=getpixel(x,y*2,vga);
    b:=getpixel(x,y*2+1,vga);
    putpixel(x,y*2,round(matriisi[0,0]*a+matriisi[1,0]*b),vaddr);
    putpixel(x,y*2+1,round(matriisi[0,1]*a+matriisi[1,1]*b),vaddr);
  end;
  flip;
end;


begin
  randomize;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  matriisi[0,0]:=1;
  matriisi[1,0]:=-1.3;
  matriisi[0,1]:=7;
  matriisi[1,1]:=2.9;
  for x:=0 to 319 do for y:=0 to 199 do putpixel(x,y,random(255),vga);
  repeat play2;
  until keypressed;
  readkey;
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.
