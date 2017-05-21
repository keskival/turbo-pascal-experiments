program phong;
uses unit3d,crt;

var
  kol,kol2,pii:real;
  piste:array[1..8]of record
    x,y,z:real;
    ax,ay,vari:integer;
    t,p:real;
  end;
  i:integer;


procedure alusta;
begin
  pii:=3.1415926535897932385;
  kol:=sqrt(300);
  piste[1].x:=-10;
  piste[1].y:=-10;
  piste[1].z:=-10;
  piste[1].t:=3*pii/2;
  piste[1].p:=pii/2;
  piste[2].x:=10;
  piste[2].y:=-10;
  piste[2].z:=-10;
  piste[2].t:=pii/2;
  piste[2].p:=pii/2;
  piste[3].x:=10;
  piste[3].y:=10;
  piste[3].z:=-10;
  piste[3].t:=-pii/2;
  piste[3].p:=pii/2;
  piste[4].x:=-10;
  piste[4].y:=10;
  piste[4].z:=-10;
  piste[4].t:=-3*pii/2;
  piste[4].p:=pii/2;
  piste[5].x:=-10;
  piste[5].y:=-10;
  piste[5].z:=10;
  piste[5].t:=3*pii/2;
  piste[5].p:=-pii/2;
  piste[6].x:=10;
  piste[6].y:=-10;
  piste[6].z:=10;
  piste[6].t:=pii/2;
  piste[6].p:=-pii/2;
  piste[7].x:=10;
  piste[7].y:=10;
  piste[7].z:=10;
  piste[7].t:=-pii/2;
  piste[7].p:=-pii/2;
  piste[8].x:=-10;
  piste[8].y:=10;
  piste[8].z:=10;
  piste[8].t:=-3*pii/2;
  piste[8].p:=-pii/2;
end;

procedure pyorita;
begin
  for i:=1 to 8 do
  begin
    piste[i].p:=piste[i].p+0.004;
    piste[i].t:=piste[i].t+0.003;
    if piste[i].p<-pii then piste[i].p:=piste[i].p+2*pii;
    if piste[i].p>pii then piste[i].p:=piste[i].p-2*pii;
    if piste[i].t<-pii then piste[i].t:=piste[i].t+2*pii;
    if piste[i].t>pii then piste[i].t:=piste[i].t-2*pii;

    piste[i].z:=kol*sin(piste[i].p);
    kol2:=sqrt(300-sqr(piste[i].z));
    piste[i].y:=kol2*sin(piste[i].t);
    piste[i].x:=kol2*cos(piste[i].t);
  end;
end;

procedure piirra;
begin
  cls(0,vaddr);
  for i:=1 to 8 do
  begin
    piste[i].vari:=round((piste[i].t+pii)/(2*pii)*255);
    piste[i].ax:=round(piste[i].x*piste[i].z/2+160);
    piste[i].ay:=round(piste[i].y*piste[i].z/2+100);
    putpixel(piste[i].ax,piste[i].ay,piste[i].vari,vaddr);
  end;

  polygon(piste[1].ax,piste[1].ay,piste[2].ax,piste[2].ay,piste[3].ax,piste[3].ay,
    piste[4].ax,piste[4].ay,piste[1].vari,vaddr);
  polygon(piste[5].ax,piste[5].ay,piste[6].ax,piste[6].ay,piste[7].ax,piste[7].ay,
    piste[8].ax,piste[8].ay,piste[5].vari,vaddr);
  gpolygon(piste[1].ax,piste[1].ay,piste[2].ax,piste[2].ay,piste[3].ax,piste[3].ay,
    piste[4].ax,piste[4].ay,piste[1].vari,piste[2].vari,piste[3].vari,
    piste[4].vari,vaddr);
  gpolygon(piste[3].ax,piste[3].ay,piste[4].ax,piste[4].ay,piste[7].ax,piste[7].ay,
    piste[8].ax,piste[8].ay,piste[3].vari,piste[4].vari,piste[7].vari,
    piste[8].vari,vaddr);
  gpolygon(piste[5].ax,piste[5].ay,piste[6].ax,piste[6].ay,piste[7].ax,piste[7].ay,
    piste[8].ax,piste[8].ay,piste[5].vari,piste[6].vari,piste[7].vari,
    piste[8].vari,vaddr);


end;

procedure play;
begin
  pyorita;
  piirra;
  flip;
end;

begin
  alusta;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat
    play;
  until keypressed;
  settext;
  shutdown;
end.