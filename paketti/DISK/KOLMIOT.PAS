program tunneli;
uses unit3d,crt;

procedure play;
var i,j:integer;

begin
  for i:=0 to 31 do
  for j:=0 to 19 do
  begin
    gkolm(i*10,j*10,i*10+9,j*10+9,i*10+9,j*10,random(255),random(255),random(255),vga);
  end;
end;

begin
  setmcga;
  setupvirtual;
  cls(0,vaddr);
  repeat play;
  until keypressed;
  readkey;
  readkey;
  settext;
  shutdown;
end.