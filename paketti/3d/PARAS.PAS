program gouraud;
uses unit3d,crt;

VAR
  color1su,color2su,color3su,xp1,xp2,xp3,yp1,yp2,yp3:integer;
  xsu1,ysu1,xsu2,ysu2,xsu3,ysu3:integer;
  color1,color2,color3:byte;
  VIIVE:LONGINT;

procedure ghline(x1,x2:longint;c1,c2,y:longint; where:word);
var
  dc:longint;
  a:longint;

begin
  if x2<x1 then
  begin
    a:=x2;
    x2:=x1;
    x1:=a;
    a:=c2;
    c2:=c1;
    c1:=a;
  end;

  if x2<>x1 then dc:=round(((c2-c1)*65536)/(x2-x1))
  else dc:=c2*65536;

  if x2>319 then x2:=319;
  if x1<0 then x1:=0;
  c1:=c1*65536;
  for a:=x1 to x2 do
  begin
    putpixel(a,y,round(c1/65536),where);
    c1:=c1+dc;
  end;
end;

procedure gkolm(x1,y1,x2,y2,x3,y3:longint; c1,c2,c3:byte; where:word);
var
  a:longint;
  x,y:array[0..2]of longint;
  c:array[0..2]of byte;
  dc:array[0..2]of real;
  d:array[0..2]of real;
  delta_c,delta_x,delta_y:array[0..2]of longint;


begin
  c[0]:=c1;
  c[1]:=c2;
  c[2]:=c3;
  x[0]:=x1;
  y[0]:=y1;
  x[1]:=x2;
  y[1]:=y2;
  x[2]:=x3;
  y[2]:=y3;
  if y[0]>y[1] then
  begin
    a:=y[1];
    y[1]:=y[0];
    y[0]:=a;
    a:=x[1];
    x[1]:=x[0];
    x[0]:=a;
    a:=c[0];
    c[0]:=c[1];
    c[1]:=a;
  end;
  if y[1]>y[2] then
  begin
    a:=y[2];
    y[2]:=y[1];
    y[1]:=a;
    a:=x[2];
    x[2]:=x[1];
    x[1]:=a;
    a:=c[1];
    c[1]:=c[2];
    c[2]:=a;
  end;
  if y[0]>y[1] then
  begin
    a:=y[1];
    y[1]:=y[0];
    y[0]:=a;
    a:=x[1];
    x[1]:=x[0];
    x[0]:=a;
    a:=c[0];
    c[0]:=c[1];
    c[1]:=a;
  end;
  delta_c[0]:=c[1]-c[0];
  delta_c[1]:=c[2]-c[1];
  delta_c[2]:=c[0]-c[2];
  delta_x[0]:=x[1]-x[0];
  delta_x[1]:=x[2]-x[1];
  delta_x[2]:=x[0]-x[2];
  delta_y[0]:=y[1]-y[0];
  delta_y[1]:=y[2]-y[1];
  delta_y[2]:=y[0]-y[2];

  for a:=0 to 2 do
  begin
    if (delta_y[a]<>0) then d[a]:=delta_x[a]/delta_y[a]
    else d[a]:=delta_x[a];
  end;
  for a:=0 to 2 do
  begin
    if (delta_y[a]<>0) then dc[a]:=delta_c[a]/delta_y[a]
    else dc[a]:=delta_c[a];
  end;
  for a:=y[0] to y[1] do ghline(round(x[0]+(a-y[0])*d[0]),
    round(x[0]+(a-y[0])*d[2]),
    round(c[0]+(a-y[0])*dc[0]),
    round(c[0]+(a-y[0])*dc[2]),a,where);
  for a:=y[1] to y[2] do ghline(round(x[1]+(a-y[1])*d[1]),
    round(x[0]+(a-y[0])*d[2]),
    round(c[1]+(a-y[1])*dc[1]),
    round(c[0]+(a-y[0])*dc[2]),a,where);

end;

begin
  setmcga;
  color1:=random(255);
  color2:=random(255);
  color3:=random(255);
  xsu1:=1;
  ysu1:=-1;
  xsu2:=-2;
  ysu2:=1;
  xsu3:=1;
  ysu3:=2;
  color1su:=1;
  color2su:=-1;
  color3su:=1;
  xp1:=random(319);
  xp2:=random(319);
  xp3:=random(319);
  yp1:=random(199);
  yp2:=random(199);
  yp3:=random(199);
  setupvirtual;
  cls(0,vaddr);
  FOR VIIVE:=0 TO 255 DO PAL(VIIVE,round(viive/4.1),0,0);
  repeat gkolm(xp1,yp1,xp2,yp2,xp3,yp3,
    color1,color2,color3,vaddr);
    if (color1+color1su<0)or(color1+color1su>255) then color1su:=-color1su;
    if (color2+color2su<0)or(color2+color2su>255) then color2su:=-color2su;
    if (color3+color3su<0)or(color3+color3su>255) then color3su:=-color3su;
    color1:=color1+color1su;
    color2:=color2+color2su;
    color3:=color3+color3su;
    if (xp1+xsu1>319)or(xp1+xsu1<0) then xsu1:=-xsu1;
    if (yp1+ysu1>199)or(yp1+ysu1<0) then ysu1:=-ysu1;
    if (xp2+xsu2>319)or(xp2+xsu2<0) then xsu2:=-xsu2;
    if (yp2+ysu2>199)or(yp2+ysu2<0) then ysu2:=-ysu2;
    if (xp3+xsu3>319)or(xp3+xsu3<0) then xsu3:=-xsu3;
    if (yp3+ysu3>199)or(yp3+ysu3<0) then ysu3:=-ysu3;
    xp1:=xp1+xsu1;
    yp1:=yp1+ysu1;
    xp2:=xp2+xsu2;
    yp2:=yp2+ysu2;
    xp3:=xp3+xsu3;
    yp3:=yp3+ysu3;
    flip;
    cls(0,vaddr);

  until keypressed;
  shutdown;
  settext;
end.
