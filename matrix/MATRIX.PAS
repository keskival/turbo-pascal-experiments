program matrix;
uses unit3d,crt;

var
  matriisi: array[0..1,0..1]of real;
  x,y:integer;
  a,b:byte;

procedure play;
begin
  for y:=0 to 99 do for x:=0 to 319 do
  begin
    a:=getpixel(x,y*2,vga);
    b:=getpixel(x,y*2+1,vga);
    putpixel(x,y*2,round(matriisi[0,0]*a+matriisi[1,0]*b),vaddr);
    putpixel(x,y*2+1,round(matriisi[0,1]*a+matriisi[1,1]*b),vaddr);
  end;
  flip;
end;


begin
  randomize;
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  matriisi[0,0]:=1;
  matriisi[1,0]:=-1.3;
  matriisi[0,1]:=7;
  matriisi[1,1]:=2.9;

  for x:=0 to 319 do for y:=0 to 199 do putpixel(x,y,random(255),vga);
  repeat play;
  until keypressed;
  settext;
  shutdown;
end.
