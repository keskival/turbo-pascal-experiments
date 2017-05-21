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
    putpixel(x,y,round((p1+p2)/2),vaddr);
  end;
  flip;
end;

procedure play2;
var
  tr,tg,tb:byte;
  r,g,b:array[1..255]of byte;

begin
  getpal(1,tr,tg,tb);
  for x:=255 downto 1 do
  begin
    getpal(x,r[x],g[x],b[x]);
  end;
  waitretrace;
  for x:=254 downto 1 do
  begin
    pal(x,r[x+1],g[x+1],b[x+1]);
    for y:=0 to 5000 do;
  end;
  pal(255,tr,tg,tb);
end;

begin
  setmcga;
  randomize;
  setupvirtual;
  cls(0,vga);
  cls(0,vaddr);
  for x:=0 to 63 do pal(x,x,0,0);
  for x:=64 to 127 do pal(x,63-(x-64),0,0);
  for x:=128 to 191 do pal(x,x-128,0,0);
  for x:=192 to 255 do pal(x,63-(x-192),0,0);
  for x:=0 to 319 do for y:=0 to 199 do putpixel(x,y,random(255),vga);
  repeat play;
  until keypressed;
  readkey;
  pal(30,random(63),random(63),random(63));
  pal(94,random(63),random(63),random(63));
  pal(158,random(63),random(63),random(63));
  pal(222,random(63),random(63),random(63));
  repeat play2;
  until keypressed;
  settext;
end.
