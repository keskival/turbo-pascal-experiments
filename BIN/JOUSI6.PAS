program jousi;
uses unit3d,crt;

var
  piste:array[1..30] of record
    et,x,y:real;
    xvel,yvel:real;
    xkiih,ykiih:real;
  end;
  i,max:integer;
  a:char;
  j,k,d:longint;
  dx,dy,oikeax,oikeay,korx,kory:real;

procedure play;
begin
  for i:=2 to max do
  begin
    piste[i].xkiih:=0;
    piste[i].ykiih:=0.2;
    dx:=piste[i-1].x-piste[i].x;
    dy:=piste[i-1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i].et;
    korx:=(dx-oikeax)/400;
    kory:=(dy-oikeay)/400;
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel+0.00062;
  end;
{  for i:=2 to 10 do
  begin
    piste[i].ykiih:=piste[i].ykiih+1;
  end;}
  for i:=2 to max-1 do
  begin
    dx:=piste[i+1].x-piste[i].x;
    dy:=piste[i+1].y-piste[i].y;
    oikeax:=dx/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    oikeay:=dy/(sqrt(sqr(dx)+sqr(dy)))*piste[i+1].et;
    korx:=(dx-oikeax)/400;
    kory:=(dy-oikeay)/400;
    piste[i].xvel:=korx+piste[i].xvel;
    piste[i].yvel:=kory+piste[i].yvel;
  end;
{  for i:=2 to 10 do
  begin
    piste[i].ykiih:=piste[i].ykiih/(sqrt(sqr(piste[i].xkiih)+sqr(piste[i].ykiih)));
    piste[i].xkiih:=piste[i].xkiih/(sqrt(sqr(piste[i].xkiih)+sqr(piste[i].ykiih)));
  end;}
  for i:=2 to max do
  begin
    piste[i].xvel:=piste[i].xvel/1.0005;
    piste[i].yvel:=piste[i].yvel/1.0005;
  end;
  for i:=2 to max do
  begin
    piste[i].x:=piste[i].x+piste[i].xvel;
    piste[i].y:=piste[i].y+piste[i].yvel;
  end;
  for i:=2 to max do
  begin
    line(round(piste[i-1].x),round(piste[i-1].y),round(piste[i].x),round(piste[i].y),5,vaddr);
  end;
  for i:=1 to max do putpixel(round(piste[i].x),round(piste[i].y),4,vaddr);
  flip;
end;

procedure alusta;
begin
  max:=20;
  randomize;
  piste[1].x:=160;
  piste[1].y:=1;
  for i:=2 to max do
  begin
    piste[i].x:=piste[i-1].x-(random(5)+1);
    piste[i].y:=piste[i-1].y+random(2);
  end;
  for i:=1 to max do
  begin
    piste[i].xvel:=0;
    piste[i].yvel:=0;
    piste[i].xkiih:=0;
    piste[i].ykiih:=0;
  end;
  for i:=2 to max do
  begin
    piste[i].et:=sqrt(sqr(piste[i].x-piste[i-1].x)+sqr(piste[i].y-piste[i-1].y));
  end;
end;

begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat
  alusta;
  d:=0;
  repeat
    cls(0,vaddr);
    play;
    d:=d+1;
    if (keypressed)and(readkey='s') then piste[6].xvel:=1;
  until ((keypressed)and((readkey='a')or(readkey='q')))or(d>7999);
  d:=0;
  if keypressed then a:=readkey;
  until a='q';
  shutdown;
  settext;
end.