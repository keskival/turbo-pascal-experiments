program jakauma;
uses crt,unit3d;

var
  a:array[1..10]of integer;
  i:integer;
  c:array[10..60]of longint;
  korkeus:array[10..60]of integer;
  yht,kaikki:longint;

procedure pelaa;
begin
  for i:=1 to 10 do a[i]:=random(6)+1;
  for i:=1 to 10 do yht:=yht+a[i];
  c[yht]:=c[yht]+1;
  kaikki:=kaikki+1;
  for i:=10 to 60 do korkeus[i]:=round((c[i]/kaikki)*1600);
  cls(0,vaddr);
{  line(50,190-korkeus[2],100,190-korkeus[7],6,vaddr);
  line(100,190-korkeus[7],150,190-korkeus[12],6,vaddr);}
  for i:=10 to 60 do line(i*2+50,190,i*2+50,190-korkeus[i],5,vaddr);
  flip;
end;

begin
  randomize;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat
    pelaa;
  until keypressed;
  shutdown;
  settext;
end.