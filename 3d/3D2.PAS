program sortti;
uses tpr,unit3d,crt;

var
  jarj:array[1..4]of integer;
  sivu:array[1..4] of record
    x,y,z:array[1..3] of integer;
    newx,newy,newz:array[1..3] of integer;
  end;
  kulmax,kulmay,kulmaz:real;

PROCEDURE PYORITA(X,Y,Z:INTEGER; XAN,YAN,ZAN:REAL; VAR NEWX,NEWY,NEWZ:INTEGER);
BEGIN
  NEWX:=ROUND(X*(SIN(YAN)*SIN(ZAN)*SIN(XAN)+COS(YAN)*COS(XAN))+Y*(COS(ZAN)*SIN(XAN))+
  Z*(COS(YAN)*SIN(ZAN)*SIN(XAN)-COS(XAN)*SIN(YAN)));
  NEWY:=ROUND(X*(COS(XAN)*SIN(YAN)*SIN(ZAN)-COS(YAN)*SIN(XAN))+Y*(COS(ZAN)*COS(XAN))+
  Z*(COS(YAN)*COS(XAN)*SIN(ZAN)+SIN(YAN)*SIN(XAN)));
  NEWZ:=ROUND(X*(COS(YAN)*SIN(ZAN)*SIN(XAN)-COS(XAN)*SIN(YAN))+
  Y*(-SIN(ZAN))+Z*(COS(YAN)*COS(ZAN)));
END;

procedure alusta;
var i:integer;
begin
  for i:=0 to 126 do pal(i,round(i/2),0,0);
  sivu[1].x[1]:=1;
  sivu[1].x[2]:=40;
  sivu[1].x[3]:=1;
  sivu[1].y[1]:=1;
  sivu[1].y[2]:=40;
  sivu[1].y[3]:=-60;
  sivu[1].z[1]:=60;
  sivu[1].z[2]:=1;
  sivu[1].z[3]:=1;

  sivu[2].x[1]:=1;
  sivu[2].x[2]:=-40;
  sivu[2].x[3]:=1;
  sivu[2].y[1]:=1;
  sivu[2].y[2]:=40;
  sivu[2].y[3]:=-60;
  sivu[2].z[1]:=60;
  sivu[2].z[2]:=1;
  sivu[2].z[3]:=1;

  sivu[3].x[1]:=1;
  sivu[3].x[2]:=40;
  sivu[3].x[3]:=-40;
  sivu[3].y[1]:=1;
  sivu[3].y[2]:=40;
  sivu[3].y[3]:=40;
  sivu[3].z[1]:=60;
  sivu[3].z[2]:=1;
  sivu[3].z[3]:=1;

  sivu[4].x[1]:=1;
  sivu[4].x[2]:=40;
  sivu[4].x[3]:=-40;
  sivu[4].y[1]:=-60;
  sivu[4].y[2]:=40;
  sivu[4].y[3]:=40;
  sivu[4].z[1]:=1;
  sivu[4].z[2]:=1;
  sivu[4].z[3]:=1;
end;

procedure laske;
var
  t,p,r:real;
  j,i:integer;

begin
  for i:=1 to 4 do
  for j:=1 to 3 do
  begin
    pyorita(sivu[i].x[j],sivu[i].y[j],sivu[i].z[j],kulmax,kulmay,kulmaz,
      sivu[i].newx[j],sivu[i].newy[j],sivu[i].newz[j]);
  end;
end;

procedure sort;
var
  i:integer;
begin
  for i:=1 to 4 do jarj[i]:=i;
  for i:=1 to 4 do
  begin
    if (((sivu[jarj[1]].newz[1])+(sivu[jarj[1]].newz[2])+(sivu[jarj[1]].newz[3]))/3)
      >
      (((sivu[jarj[2]].newz[1])+(sivu[jarj[2]].newz[2])+(sivu[jarj[2]].newz[3]))/3)
    then
    begin
      i:=jarj[2];
      jarj[2]:=jarj[1];
      jarj[1]:=i;
    end;

    if (((sivu[jarj[2]].newz[1])+(sivu[jarj[2]].newz[2])+(sivu[jarj[2]].newz[3]))/3)
      >
      (((sivu[jarj[3]].newz[1])+(sivu[jarj[3]].newz[2])+(sivu[jarj[3]].newz[3]))/3)
    then
    begin
      i:=jarj[3];
      jarj[3]:=jarj[2];
      jarj[2]:=i;
    end;

    if (((sivu[jarj[3]].newz[1])+(sivu[jarj[3]].newz[2])+(sivu[jarj[3]].newz[3]))/3)
      >
      (((sivu[jarj[4]].newz[1])+(sivu[jarj[4]].newz[2])+(sivu[jarj[4]].newz[3]))/3)
    then
    begin
      i:=jarj[4];
      jarj[4]:=jarj[3];
      jarj[3]:=i;
    end;
  end;
end;

procedure piirra;
var
  i:integer;

begin
  for i:=1 to 4 do
  begin
    gkolm(round(sivu[jarj[i]].newx[1])+159,round(sivu[jarj[i]].newy[1])+99,
      round(sivu[jarj[i]].newx[2])+159,round(sivu[jarj[i]].newy[2])+99,
      round(sivu[jarj[i]].newx[3])+159,round(sivu[jarj[i]].newy[3])+99,
      round(sivu[jarj[i]].newz[1])+90,round(sivu[jarj[i]].newz[2])+90,
      round(sivu[jarj[i]].newz[3])+90,vaddr);
  end;
  flip;
  cls(0,vaddr);
end;

procedure play;
begin
  kulmax:=kulmax+0.05;
  kulmay:=kulmay+0.07;
  kulmaz:=kulmaz+0.02;
  laske;
  sort;
  piirra;
end;

begin
  setmcga;
  setupvirtual;
  alusta;
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.