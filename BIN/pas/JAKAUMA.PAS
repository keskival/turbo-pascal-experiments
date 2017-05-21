program jakauma;
uses crt,unit3d;

var
  a,b,i:integer;
  c:array[2..12]of longint;
  korkeus:array[2..12]of integer;
  yht:longint;

procedure pelaa;
begin
  a:=random(6)+1;
  b:=random(6)+1;
  c[a+b]:=c[a+b]+1;
  yht:=0;
  for i:=2 to 12 do yht:=yht+c[i];
  for i:=2 to 12 do korkeus[i]:=round((c[i]/yht)*300);
  cls(0,vaddr);
  line(50,190-korkeus[2],100,190-korkeus[7],6,vaddr);
  line(100,190-korkeus[7],150,190-korkeus[12],6,vaddr);
  for i:=2 to 12 do line(30+10*i,190,30+10*i,190-korkeus[i],5,vaddr);
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