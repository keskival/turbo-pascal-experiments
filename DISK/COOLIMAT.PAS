Program satun;
uses graf,crt;

var
  xsu,ysu:integer;
  x,y,vari:integer;
  i:longint;

procedure lisaapaletti;
var
  a,b,c:byte;
  e,d:integer;

begin
  waitretrace;
  for i:=11 downto 1 do
  begin
    d:=i;
    e:=d-1;
    if d=1 then e:=11;
    getpal(e,a,b,c);
    pal(d,a,b,c);
  end;
end;

procedure play;
begin
  for i:=0 to 10 do begin
    vari:=vari+1;
    box(x-i,y-i,x+i,y+i,vari,vga);
    if vari=11 then vari:=1;
  end;
  if x>=288 then xsu:=-xsu;
  if x<=29 then xsu:=-xsu;
  if y>=168 then ysu:=-ysu;
  if y<=29 then ysu:=-ysu;
  x:=x+xsu;
  y:=y+ysu;
  lisaapaletti;
end;

begin
  setupvirtual;
  setmcga;
  cls(0,vaddr);
  vari:=1;
  x:=159;
  y:=99;
  xsu:=1;
  ysu:=1;
  box(18,18,299,179,20,vga);
  repeat
    play;
    i:=i+1;
  until keypressed;
  shutdown;
  settext;
end.
