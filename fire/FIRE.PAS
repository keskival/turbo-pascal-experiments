program fire;
uses unit3d,crt;

var
  apu:integer;
  apuruutu:array[0..319,0..199]of byte;

procedure play;
var
  i,j:integer;

begin
  for i:=0 to 319 do
  for j:=139 to 199 do
  begin
    apuruutu[i,j]:=getpixel(i,j,vaddr);
  end;
  for i:=1 to 318 do
  for j:=140 to 198 do
  begin
    putpixel(i,j,round((apuruutu[i,j-random(3)]+apuruutu[i+random(3)-1,j+random(2)]+apuruutu[i+random(3)-1,j+random(3)])/3)
      ,vaddr);
  end;
  for i:=0 to 319 do putpixel(i,199,random(40)+215,vaddr);
  for i:=0 to 319 do putpixel(i,198,random(40)+215,vaddr);
  flip;
end;

begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  for apu:=255 downto 200 do pal(apu,apu,round(apu*2),0);
  for apu:=0 to 199 do pal(apu,0,0,0);
  randomize;
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.