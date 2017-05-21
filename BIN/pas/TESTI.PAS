program iq;
uses unit3d,crt;

var
  x,y,oikein,vaarin,kerrat:integer;
  viive:longint;
  vast,k:char;

procedure nayta;
begin
  for x:=140 to 160 do for y:=50 to 150 do putpixel(x,y,6,vga);
  for x:=180 to 200 do for y:=50 to 150 do putpixel(x,y,6,vga);
  for x:=140 to 160 do for y:=50 to 150 do putpixel(x,y,0,vaddr);
  for x:=180 to 200 do for y:=50 to 150 do putpixel(x,y,0,vaddr);
  readkey;
  for viive:=0 to 49999999 do ;
  if random(2)=1 then
  begin
    vast:='a';
    for y:=60 to 140 do putpixel(150,y,7,vaddr);
    for y:=70 to 130 do putpixel(190,y,7,vaddr);
    waitretrace;
    flip;
    for x:=140 to 160 do for y:=50 to 150 do putpixel(x,y,7,vaddr);
    for x:=180 to 200 do for y:=50 to 150 do putpixel(x,y,7,vaddr);
    waitretrace;
    flip;
  end
  else
  begin
    vast:='l';
    for y:=70 to 130 do putpixel(150,y,7,vaddr);
    for y:=60 to 140 do putpixel(190,y,7,vaddr);
    waitretrace;
    flip;
    for x:=140 to 160 do for y:=50 to 150 do putpixel(x,y,7,vaddr);
    for x:=180 to 200 do for y:=50 to 150 do putpixel(x,y,7,vaddr);
    waitretrace;
    flip;
  end;
  k:=readkey;
  if k=vast then
  begin
    oikein:=oikein+1;
    waitretrace;
    cls(5,vga);
    for viive:=0 to 29999999 do;
    waitretrace;
    cls(0,vga);
  end
  else
  begin
    vaarin:=vaarin+1;
    waitretrace;
    cls(4,vga);
    for viive:=0 to 29999999 do;
    waitretrace;
    cls(0,vga);
  end;
  cls(0,vaddr);
end;

begin
  oikein:=0;
  vaarin:=0;
  randomize;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat
    nayta;
    kerrat:=kerrat+1;
  until (k='q')or(kerrat>=20);
  shutdown;
  settext;
  writeln('Oikein: ',oikein);
  writeln('Vaarin: ',vaarin);
end.