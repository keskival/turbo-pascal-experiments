program sahko;
uses unit3d,crt,tpr;

var
  x,y,vari,vari2,x1,x2,y1,y2,xsu1,ysu1,xsu2,ysu2:integer;

begin
  x1:=100;
  y1:=99;
  x2:=250;
  y2:=130;
  xsu1:=6;
  ysu1:=4;
  xsu2:=-4;
  ysu2:=-6;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat
  begin
  for x:=0 to 63 do pal(x,x,x,x);
  for x:=0 to 319 do for y:=0 to 199 do
  begin
    if (ddroe(abs(x-x1),abs(y-y1)))<>0 then vari:=round(10000/(ddroe(abs(x-x1),abs(y-y1))))
    else vari:=0;
    if (ddroe(abs(x-x2),abs(y-y2)))<>0 then vari2:=round(10000/(ddroe(abs(x-x2),abs(y-y2))))
    else vari2:=0;
    putpixel(x,y,abs(vari-vari2),vaddr);
  end;
  flip;
  if (x2+xsu2<=0)or(x2+xsu2>=319) then xsu2:=-xsu2;
  if (y2+ysu2<=0)or(y2+ysu2>=199) then ysu2:=-ysu2;
  x2:=x2+xsu2;
  y2:=y2+ysu2;
  if (x1+xsu1<=0)or(x1+xsu1>=319) then xsu1:=-xsu1;
  if (y1+ysu1<=0)or(y1+ysu1>=199) then ysu1:=-ysu1;
  x1:=x1+xsu1;
  y1:=y1+ysu1;
  end;
  until keypressed;

end.