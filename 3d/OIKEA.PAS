program gouraud;
uses unit3d,crt;

VAR
  jarj:array[1..6]of integer;
  kulm:real;
  sivu:array[1..6]of record
    p1,p2,p3,p4:record
      x,y,z:integer;
      xr,yr,zr:integer;
    end;
  end;
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

procedure pyorita;

var
  a:integer;

PROCEDURE PYOR(X,Y,Z:INTEGER; XAN,YAN,ZAN:REAL; VAR NEWX,NEWY,NEWZ:INTEGER);
BEGIN
  NEWX:=ROUND(X*(SIN(YAN)*SIN(ZAN)*SIN(XAN)+COS(YAN)*COS(XAN))+Y*(COS(ZAN)*SIN(XAN))+
  Z*(COS(YAN)*SIN(ZAN)*SIN(XAN)-COS(XAN)*SIN(YAN)));
  NEWY:=ROUND(X*(COS(XAN)*SIN(YAN)*SIN(ZAN)-COS(YAN)*SIN(XAN))+Y*(COS(ZAN)*COS(XAN))+
  Z*(COS(YAN)*COS(XAN)*SIN(ZAN)+SIN(YAN)*SIN(XAN)));
  NEWZ:=ROUND(X*(COS(YAN)*SIN(ZAN)*SIN(XAN)-COS(XAN)*SIN(YAN))+
  Y*(-SIN(ZAN))+Z*(COS(YAN)*COS(ZAN)));
END;

begin
  for a:=1 to 6 do
  begin
    pyor(sivu[a].p1.x,sivu[a].p1.y,sivu[a].p1.z,kulm,kulm,kulm,sivu[a].p1.xr,sivu[a].p1.yr,sivu[a].p1.zr);
    pyor(sivu[a].p2.x,sivu[a].p2.y,sivu[a].p2.z,kulm,kulm,kulm,sivu[a].p2.xr,sivu[a].p2.yr,sivu[a].p2.zr);
    pyor(sivu[a].p3.x,sivu[a].p3.y,sivu[a].p3.z,kulm,kulm,kulm,sivu[a].p3.xr,sivu[a].p3.yr,sivu[a].p3.zr);
    pyor(sivu[a].p4.x,sivu[a].p4.y,sivu[a].p4.z,kulm,kulm,kulm,sivu[a].p4.xr,sivu[a].p4.yr,sivu[a].p4.zr);
  end;
  kulm:=kulm+0.01;
end;

procedure jarjesta;
var
  temp:array[1..4]of integer;
  tem,i,j:integer;

begin
  for i:=1 to 6 do jarj[i]:=i;
  for i:=1 to 5 do
  for j:=i+1 to 6 do
  begin
    if (((sivu[i].p1.zr+sivu[i].p2.zr+sivu[i].p3.zr+sivu[i].p4.zr)/4)>
      ((sivu[j].p1.zr+sivu[j].p2.zr+sivu[j].p3.zr+sivu[j].p4.zr)/4))
      then
      begin
        temp[1]:=sivu[i].p1.zr;
        temp[2]:=sivu[i].p2.zr;
        temp[3]:=sivu[i].p3.zr;
        temp[4]:=sivu[i].p4.zr;
        sivu[i].p1.zr:=sivu[j].p1.zr;
        sivu[i].p2.zr:=sivu[j].p2.zr;
        sivu[i].p3.zr:=sivu[j].p3.zr;
        sivu[i].p4.zr:=sivu[j].p4.zr;
        sivu[j].p1.zr:=temp[1];
        sivu[j].p2.zr:=temp[2];
        sivu[j].p3.zr:=temp[3];
        sivu[j].p4.zr:=temp[4];
        tem:=jarj[i];
        jarj[i]:=jarj[j];
        jarj[j]:=tem;
      end;
  end;


end;

procedure piirra;
var
  i:integer;

begin
  for i:=1 to 6 do
  begin
    gkolm(
      round(sivu[jarj[i]].p1.xr * sivu[jarj[i]].p1.zr/10)+159,round(sivu[jarj[i]].p1.yr * sivu[jarj[i]].p1.zr/10)+99,
      round(sivu[jarj[i]].p2.xr * sivu[jarj[i]].p2.zr/10)+159,round(sivu[jarj[i]].p2.yr * sivu[jarj[i]].p2.zr/10)+99,
      round(sivu[jarj[i]].p3.xr * sivu[jarj[i]].p3.zr/10)+159,round(sivu[jarj[i]].p3.yr * sivu[jarj[i]].p3.zr/10)+99,
      sivu[jarj[i]].p1.zr,sivu[jarj[i]].p2.zr,sivu[jarj[i]].p3.zr,vaddr);
    gkolm(
      round(sivu[jarj[i]].p2.xr * sivu[jarj[i]].p1.zr/10)+159,round(sivu[jarj[i]].p2.yr * sivu[jarj[i]].p3.zr/10)+99,
      round(sivu[jarj[i]].p3.xr * sivu[jarj[i]].p2.zr/10)+159,round(sivu[jarj[i]].p3.yr * sivu[jarj[i]].p3.zr/10)+99,
      round(sivu[jarj[i]].p4.xr * sivu[jarj[i]].p3.zr/10)+159,round(sivu[jarj[i]].p4.yr * sivu[jarj[i]].p3.zr/10)+99,
      sivu[jarj[i]].p2.zr,sivu[jarj[i]].p3.zr,sivu[jarj[i]].p4.zr,vaddr);
  end;
end;

begin
  sivu[1].p1.x:=-10;
  sivu[1].p1.y:=-10;
  sivu[1].p1.z:=10;
  sivu[1].p2.x:=-10;
  sivu[1].p2.y:=10;
  sivu[1].p2.z:=10;
  sivu[1].p3.x:=10;
  sivu[1].p3.y:=-10;
  sivu[1].p3.z:=10;
  sivu[1].p4.x:=10;
  sivu[1].p4.y:=10;
  sivu[1].p4.z:=10;

  sivu[2].p1.x:=-10;
  sivu[2].p1.y:=-10;
  sivu[2].p1.z:=-10;
  sivu[2].p2.x:=-10;
  sivu[2].p2.y:=10;
  sivu[2].p2.z:=-10;
  sivu[2].p3.x:=10;
  sivu[2].p3.y:=-10;
  sivu[2].p3.z:=-10;
  sivu[2].p4.x:=10;
  sivu[2].p4.y:=10;
  sivu[2].p4.z:=-10;

  sivu[3].p1.x:=10;
  sivu[3].p1.y:=0;
  sivu[3].p1.z:=0;
  sivu[3].p2.x:=10;
  sivu[3].p2.y:=0;
  sivu[3].p2.z:=0;
  sivu[3].p3.x:=10;
  sivu[3].p3.y:=0;
  sivu[3].p3.z:=0;
  sivu[3].p4.x:=10;
  sivu[3].p4.y:=0;
  sivu[3].p4.z:=0;

  sivu[4].p1.x:=-10;
  sivu[4].p1.y:=0;
  sivu[4].p1.z:=0;
  sivu[4].p2.x:=-10;
  sivu[4].p2.y:=0;
  sivu[4].p2.z:=0;
  sivu[4].p3.x:=-10;
  sivu[4].p3.y:=0;
  sivu[4].p3.z:=0;
  sivu[4].p4.x:=-10;
  sivu[4].p4.y:=0;
  sivu[4].p4.z:=0;

  sivu[5].p1.x:=0;
  sivu[5].p1.y:=10;
  sivu[5].p1.z:=0;
  sivu[5].p2.x:=0;
  sivu[5].p2.y:=10;
  sivu[5].p2.z:=0;
  sivu[5].p3.x:=0;
  sivu[5].p3.y:=10;
  sivu[5].p3.z:=0;
  sivu[5].p4.x:=0;
  sivu[5].p4.y:=10;
  sivu[5].p4.z:=0;

  sivu[6].p1.x:=0;
  sivu[6].p1.y:=-10;
  sivu[6].p1.z:=0;
  sivu[6].p2.x:=0;
  sivu[6].p2.y:=-10;
  sivu[6].p2.z:=0;
  sivu[6].p3.x:=0;
  sivu[6].p3.y:=-10;
  sivu[6].p3.z:=0;
  sivu[6].p4.x:=0;
  sivu[6].p4.y:=-10;
  sivu[6].p4.z:=0;

  setmcga;
  setupvirtual;
  cls(0,vaddr);
  FOR VIIVE:=0 TO 255 DO PAL(VIIVE,round(viive/4.1),0,0);
  repeat
    pyorita;
    jarjesta;
    piirra;
    flip;
    cls(0,vaddr);
  until keypressed;
  shutdown;
  settext;
end.
