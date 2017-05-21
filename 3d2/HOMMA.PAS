program homma;
uses unit3d,crt,tpr;

var
  kolmio:array[1..50]of record
    x,y,z:array[1..3]of real;
    nx,ny,nz:array[1..3]of real;
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
  for i:=1 to 63 do pal(i,63-i,63-i,63-i);
end;

procedure lopeta;
begin
  shutdown;
  settext;
end;

procedure play;

procedure pyorita;
var
  t,p,r:real;

begin
  kulm:=kulm+0.03;
  for i:=1 to maxkolm do
  for j:=1 to 3 do
  begin
    t:=theta(kolmio[i].x[j],kolmio[i].y[j]);
    r:=tdroe(kolmio[i].x[j],kolmio[i].y[j],kolmio[i].z[j]);
    p:=phi(kolmio[i].z[j],r);
    kolmio[i].nx[j]:=tdx(t+kulm,p+kulm,r);
    kolmio[i].ny[j]:=tdy(t+kulm,p+kulm,r);
    kolmio[i].nz[j]:=z(p+kulm,r);
  end;
end;

procedure sorttaa;
var
  apu:real;
  vert,vert2,d:integer;

begin
  for i:=1 to maxkolm-1 do
  for j:=i+1 to maxkolm do
  begin
    vert:=round((kolmio[i].nz[1]+kolmio[i].nz[2]+kolmio[i].nz[3])/3);
    vert2:=round((kolmio[j].nz[1]+kolmio[j].nz[2]+kolmio[j].nz[3])/3);
    if vert2<vert then
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
  end;
end;

procedure piirra;
begin
  waitretrace;
  for i:=1 to maxkolm do
  begin
    gkolm(round(kolmio[i].nx[1]+159),round(kolmio[i].ny[1]+99),
      round(kolmio[i].nx[2]+159),round(kolmio[i].ny[2]+99),
      round(kolmio[i].nx[3]+159),round(kolmio[i].ny[3]+99),
      round(kolmio[i].nz[1]+40),round(kolmio[i].nz[2]+40),round(kolmio[i].nz[3]+40),vaddr);
  end;
end;

begin
  pyorita;
  sorttaa;
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