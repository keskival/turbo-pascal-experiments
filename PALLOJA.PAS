program pallot;
uses unit3d,crt;

var
  x1,x2,y1,y2:real;
  normx,normy,tormx,tormy:real;
  xsu1,ysu1,xsu2,ysu2:real;

procedure play;
begin
  if (x1+xsu1>=306) then xsu1:=-1;
  if (x1+xsu1<=13) then xsu1:=1;
  if (y1+ysu1>=186) then ysu1:=-1.5;
  if (y1+ysu1<=13) then ysu1:=1.5;
  if (x2+xsu2>=312) then xsu2:=-1.5;
  if (x2+xsu2<=7) then xsu2:=1.5;
  if (y2+ysu2>=192) then ysu2:=-1;
  if (y2+ysu2<7) then ysu2:=1;
  if (sqr((x1+xsu1)-(x2+xsu2))+sqr((y1+ysu1)-(y2+ysu2)))<=400 then
  begin
    normx:=y1-y2;
    normy:=x2-x1;
    tormx:=x1-x2;
    tormy:=y1-y2;

  end;
  circle(round(x1),round(y1),13,0,vaddr);
  circle(round(x2),round(y2),7,0,vaddr);
  x1:=x1+xsu1;
  y1:=y1+ysu1;
  x2:=x2+xsu2;
  y2:=y2+ysu2;
  circle(round(x1),round(y1),13,3,vaddr);
  circle(round(x2),round(y2),7,4,vaddr);
  flip;
end;


begin
  x1:=50;
  y1:=20;
  xsu1:=1;
  ysu1:=1.5;
  x2:=140;
  y2:=150;
  xsu2:=-1.5;
  ysu2:=-1;
  setmcga;
  setupvirtual;
  cls(0,vga);
  cls(0,vaddr);
  repeat play;
  until keypressed;
  shutdown;
  settext;
end.