program verkko;
uses unit3d,crt;

var
  p:array[1..32,1..20]of record
    x,y:real;
    xvel,yvel:real;
  end;
  i,j,k:integer;
  dx,dy,et,c:real;

procedure alusta;
begin
  for i:=1 to 32 do for j:=1 to 20 do
  begin
    p[i,j].xvel:=0;
    p[i,j].yvel:=0;
    p[i,j].x:=(i-1)*10;
    p[i,j].y:=(j-1)*10;
  end;
{  p[16,10].x:=136;
  p[16,10].y:=64;}
end;

procedure voima1;
begin
  for i:=2 to 31 do for j:=2 to 19 do
  begin
    dx:=p[i,j-1].x-p[i,j].x;
    dy:=p[i,j-1].y-p[i,j].y;
    et:=sqrt(sqr(dx)+sqr(dy));
    p[i,j].xvel:=p[i,j].xvel+(dx-(dx/et*10))/10;
    p[i,j].yvel:=p[i,j].yvel+(dy-(dy/et*10))/10;
  end;
end;
procedure voima2;
begin
  for i:=2 to 31 do for j:=2 to 19 do
  begin
    dx:=p[i+1,j].x-p[i,j].x;
    dy:=p[i+1,j].y-p[i,j].y;
    et:=sqrt(sqr(dx)+sqr(dy));
    p[i,j].xvel:=p[i,j].xvel+(dx-(dx/et*10))/10;
    p[i,j].yvel:=p[i,j].yvel+(dy-(dy/et*10))/10;
  end;
end;
procedure voima3;
begin
  for i:=2 to 31 do for j:=2 to 19 do
  begin
    dx:=p[i,j+1].x-p[i,j].x;
    dy:=p[i,j+1].y-p[i,j].y;
    et:=sqrt(sqr(dx)+sqr(dy));
    p[i,j].xvel:=p[i,j].xvel+(dx-(dx/et*10))/10;
    p[i,j].yvel:=p[i,j].yvel+(dy-(dy/et*10))/10;
  end;
end;
procedure voima4;
begin
  for i:=2 to 31 do for j:=2 to 19 do
  begin
    dx:=p[i-1,j].x-p[i,j].x;
    dy:=p[i-1,j].y-p[i,j].y;
    et:=sqrt(sqr(dx)+sqr(dy));
    p[i,j].xvel:=p[i,j].xvel+(dx-(dx/et*10))/10;
    p[i,j].yvel:=p[i,j].yvel+(dy-(dy/et*10))/10;
  end;
end;

procedure play;
begin
  voima1;
  voima2;
  voima3;
  voima4;
  for i:=2 to 31 do for j:=2 to 19 do
  begin
    p[i,j].x:=p[i,j].x+p[i,j].xvel;
    p[i,j].y:=p[i,j].y+p[i,j].yvel;
    if p[i,j].x<0 then p[i,j].x:=0;
    if p[i,j].x>310 then p[i,j].x:=310;
    if p[i,j].y<0 then p[i,j].y:=0;
    if p[i,j].y>190 then p[i,j].y:=190;
  end;
  p[16,10].x:=150+sin(c)*5;
  p[16,10].y:=90+cos(c)*5;
  c:=c+0.2;
{  for i:=2 to 32 do for j:=2 to 20 do
  begin
    line(round(p[i,j].x),round(p[i,j].y),round(p[i-1,j].x),round(p[i-1,j].y),6,vaddr);
    line(round(p[i,j].x),round(p[i,j].y),round(p[i,j-1].x),round(p[i,j-1].y),6,vaddr);
  end;
  line(round(p[1,1].x),round(p[1,1].y),round(p[32,1].x),round(p[32,1].y),6,vaddr);
  line(round(p[1,1].x),round(p[1,1].y),round(p[1,20].x),round(p[1,20].y),6,vaddr);}
  for i:=1 to 32 do for j:=1 to 20 do
  begin
    putpixel(round(p[i,j].x),round(p[i,j].y),5,vaddr);
  end;
  flip;
  cls(0,vaddr);
end;

begin
  c:=0;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  alusta;
  repeat play;
  until keypressed;
  shutdown;
  settext;
end.


