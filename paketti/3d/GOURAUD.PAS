program gouraud;
uses unit3d,crt;

VAR VIIVE:LONGINT;

procedure ghline(x1,x2:longint;c1,c2,y:longint);
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
  if x2>319 then x2:=319;
  if x1<0 then x1:=0;

  if x2<>x1 then dc:=round(((c2-c1)*65536)/(x2-x1))
  else dc:=0;
  c1:=c1*65536;
  for a:=x1 to x2 do
  begin
    putpixel(a,y,round(c1/65536),vga);
    c1:=c1+dc;
  end;
end;

procedure gkolm(x1,y1,x2,y2,x3,y3:longint; c1,c2,c3:byte);
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
  delta_c[0]:=c[1]-c[0];
  delta_c[1]:=c[2]-c[1];
  delta_c[2]:=c[0]-c[2];
  if x[0]>x[1] then
  begin
    a:=y[1];
    y[1]:=y[0];
    y[0]:=a;
    a:=x[1];
    x[1]:=x[0];
    x[0]:=a;
    a:=c[1];
    c[1]:=c[0];
    c[0]:=a;
  end;
  if x[1]>x[2] then
  begin
    a:=y[2];
    y[2]:=y[1];
    y[1]:=a;
    a:=x[2];
    x[2]:=x[1];
    x[1]:=a;
    a:=c[2];
    c[2]:=c[1];
    c[1]:=a;
  end;
  delta_x[0]:=x[1]-x[0];
  delta_x[1]:=x[2]-x[1];
  delta_x[2]:=x[0]-x[2];
  if y[0]>y[1] then
  begin
    a:=y[1];
    y[1]:=y[0];
    y[0]:=a;
    a:=x[1];
    x[1]:=x[0];
    x[0]:=a;
    a:=c[1];
    c[1]:=c[0];
    c[0]:=a;
  end;
  if y[1]>y[2] then
  begin
    a:=y[2];
    y[2]:=y[1];
    y[1]:=a;
    a:=x[2];
    x[2]:=x[1];
    x[1]:=a;
    a:=c[2];
    c[2]:=c[1];
    c[1]:=a;
  end;
  delta_y[0]:=y[1]-y[0];
  delta_y[1]:=y[2]-y[1];
  delta_y[2]:=y[0]-y[2];

  for a:=0 to 2 do
  begin
    if (delta_y[a]<>0) then d[a]:=delta_x[a]/delta_y[a]
    else d[a]:=0;
  end;
  for a:=0 to 2 do
  begin
    if (delta_c[a]<>0) then dc[a]:=delta_y[a]/delta_c[a]
    else dc[a]:=0;
  end;
  for a:=y[0] to y[1] do ghline(round(x[0]+(a-y[0])*d[0]),round(x[0]+(a-y[0])*d[2]),round(c[0]+(a-y[0])*dc[0]),
    round(c[0]+(a-y[0])*dc[2]),a);
  for a:=y[1] to y[2] do ghline(round(x[1]+(a-y[1])*d[1]),round(x[0]+(a-y[0])*d[2]),round(c[0]+(a-y[0])*dc[0]),
    round(c[0]+(a-y[0])*dc[2]),a);
end;

begin
  setmcga;
{  FOR VIIVE:=0 TO 126 DO PAL(VIIVE,ROUND(VIIVE/2),0,viive);}
  repeat gkolm(300,150,50,130,100,40,
    1,30,63);
    FOR VIIVE:=0 TO 4999999 DO;
  until keypressed;
  settext;
end.
