program life;
uses unit3d,crt;

var
  i,j,a:integer;

procedure alusta;
begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  randomize;
  pal(1,63,63,1);
  for i:=1 to 318 do
  for j:=1 to 198 do if random(2)=1 then putpixel(i,j,1,vaddr);
  flip;
end;

procedure play;
begin
  for i:=1 to 318 do
  for j:=1 to 198 do
  begin
    a:=getpixel(i-1,j-1,vga);
    a:=a+getpixel(i,j-1,vga);
    a:=a+getpixel(i+1,j-1,vga);
    a:=a+getpixel(i-1,j,vga);
    a:=a+getpixel(i+1,j,vga);
    a:=a+getpixel(i+1,j+1,vga);
    a:=a+getpixel(i,j+1,vga);
    a:=a+getpixel(i-1,j+1,vga);
    putpixel(i,j,0,vaddr);
    if (getpixel(i,j,vga)=1)and((a>1)and(a<4)) then putpixel(i,j,1,vaddr);
    if (getpixel(i,j,vga)=0)and(a=3) then putpixel(i,j,1,vaddr);
  end;
  flip;
end;

begin
  alusta;
  repeat play;
  until keypressed;
  shutdown;
  settext;
end.