program homma;
uses unit3d,crt,tpr;

var
  kolmio:array[1..50]of record
    x,y,z:array[1..3]of real;
    nx,ny,nz:array[1..3]of real;
    nakyy:boolean;
    vari:array[1..3]of byte;
  end;
  maxkolm:integer;
  kulm,kulmx,kulmy,kulmz:real;
  tied:text;
  i,j:integer;

procedure alusta;
var
  luku:string;
  num,num2,code:integer;

begin
  assign(tied,'tiedot.dat');
  reset(tied);
  readln(tied,luku);
  val(luku,num,code);
  maxkolm:=num;
  for i:=1 to num do
  begin
    for j:=1 to 3 do
    begin
      readln(tied,luku);
      val(luku,num2,code);
      kolmio[i].x[j]:=num2;

      readln(tied,luku);
      val(luku,num2,code);
      kolmio[i].y[j]:=num2;

      readln(tied,luku);
      val(luku,num2,code);
      kolmio[i].z[j]:=num2;
    end;
  end;
  close(tied);
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  pal(0,0,0,20);
  for i:=1 to 63 do pal(i,round(63-i*1.3),round(63-i*1.3),round(63-i*1.3));
{  for i:=32 to 63 do pal(i,0,0,63-(i-32));}
end;

procedure lopeta;
begin
  shutdown;
  settext;
end;

procedure play;

function backface(x1,y1,x2,y2,x3,y3:real):boolean;
var dx1,dy1,dx2,dy2:real;

begin
  dx1:=x3-x1;
  dy1:=y3-y1;
  dx2:=x3-x2;
  dy2:=y3-y2;
  if ((dx1*(dy2-dy1)-(dx2-dx1)*dy1)>0) then backface:=true
  else backface:=false;
end;

procedure pyorita;
var
  x,y,z:real;

begin
  kulmx:=kulmx+0.05;
  kulmy:=kulmy+0.05;
  kulmz:=kulmz+0.05;
  for i:=1 to maxkolm do
  for j:=1 to 3 do
  begin
    x:=kolmio[i].x[j];
    y:=kolmio[i].y[j];
    z:=kolmio[i].z[j];
    kolmio[i].nx[j]:=ROUND(X*(SIN(kulmy)*SIN(kulmz)*SIN(kulmx)+COS(kulmy)*COS(kulmx))+Y*(COS(kulmz)*SIN(kulmx))+
      Z*(COS(kulmy)*SIN(kulmz)*SIN(kulmx)-COS(kulmx)*SIN(kulmy)));
    kolmio[i].ny[j]:=ROUND(X*(COS(kulmx)*SIN(kulmy)*SIN(kulmz)-COS(kulmy)*SIN(kulmx))+Y*(COS(kulmz)*COS(kulmx))+
      Z*(COS(kulmy)*COS(kulmx)*SIN(kulmz)+SIN(kulmy)*SIN(kulmx)));
    kolmio[i].nz[j]:=ROUND(X*(COS(kulmy)*SIN(kulmz)*SIN(kulmx)-COS(kulmx)*SIN(kulmy))+
      Y*(-SIN(kulmz))+Z*(COS(kulmy)*COS(kulmz)));
    if backface(kolmio[i].nx[1],kolmio[i].ny[1],kolmio[i].nx[2],kolmio[i].ny[2],kolmio[i].nx[3],
      kolmio[i].ny[3])=true then kolmio[i].nakyy:=true
      else kolmio[i].nakyy:=false;
  end;

end;

procedure sorttaa;
var
  apu:real;
  vert,vert2,d:integer;

begin
{  for i:=1 to maxkolm do
  for j:=i to maxkolm do
  begin
    vert:=round((kolmio[i].nz[1]+kolmio[i].nz[2]+kolmio[i].nz[3])/3);
    vert2:=round((kolmio[j].nz[1]+kolmio[j].nz[2]+kolmio[j].nz[3])/3);
    if vert2>vert then
    begin
      for d:=1 to 3 do
      begin
        apu:=kolmio[i].z[d];
        kolmio[i].z[d]:=kolmio[j].z[d];
        kolmio[j].z[d]:=apu;
        apu:=kolmio[i].x[d];
        kolmio[i].x[d]:=kolmio[j].x[d];
        kolmio[j].x[d]:=apu;
        apu:=kolmio[i].y[d];
        kolmio[i].y[d]:=kolmio[j].y[d];
        kolmio[j].y[d]:=apu;
        apu:=kolmio[i].nz[d];
        kolmio[i].nz[d]:=kolmio[j].nz[d];
        kolmio[j].nz[d]:=apu;
        apu:=kolmio[i].nx[d];
        kolmio[i].nx[d]:=kolmio[j].nx[d];
        kolmio[j].nx[d]:=apu;
        apu:=kolmio[i].ny[d];
        kolmio[i].ny[d]:=kolmio[j].ny[d];
        kolmio[j].ny[d]:=apu;
      end;
    end;
  end;}
end;

procedure piirra;
var
  z:array[1..3]of real;

begin
  waitretrace;
  for i:=1 to maxkolm do
  begin
{    z[1]:=(kolmio[i].z[1]+40)/20;
    z[2]:=(kolmio[i].z[2]+40)/20;
    z[3]:=(kolmio[i].z[3]+40)/20;}
    if (kolmio[i].nakyy=true) then
      gkolm(round(kolmio[i].nx[1]+159),round(kolmio[i].ny[1]+99),
      round(kolmio[i].nx[2]+159),round(kolmio[i].ny[2]+99),
      round(kolmio[i].nx[3]+159),round(kolmio[i].ny[3]+99),
      round(kolmio[i].nz[1]/4+30),round(kolmio[i].nz[2]/4+30),round(kolmio[i].nz[3]/4+30),vaddr);
{    if (kolmio[i].nakyy=true)and(z[1]<>0)and(z[2]<>0)and(z[3]<>0) then
      gkolm(round(kolmio[i].nx[1]/z[1]+159),round(kolmio[i].ny[1]/z[1]+99),
      round(kolmio[i].nx[2]/z[2]+159),round(kolmio[i].ny[2]/z[2]+99),
      round(kolmio[i].nx[3]/z[3]+159),round(kolmio[i].ny[3]/z[3]+99),
      round(kolmio[i].nz[1]/3+30),round(kolmio[i].nz[2]/3+30),round(kolmio[i].nz[3]/3+30),vaddr);}
  end;
end;

begin
  pyorita;
{  sorttaa;}
  piirra;
  flip;
  cls(0,vaddr);
end;

begin
  alusta;
  repeat play;
  until keypressed;
  lopeta;
  writeln(maxkolm);
  for i:=1 to maxkolm do
  for j:=1 to 3 do
  writeln(kolmio[i].nx[j],kolmio[i].ny[j],kolmio[i].nz[j]);
end.