program urpo;
uses graf,crt;

var
  x,y:longint;
  v:byte;

procedure muuta;
begin
  for x:=10 to 310 do begin
    for y:=10 to 190 do
    begin
      putpixel(x,y,getpixel(x,y,vga)+random(9),vga);
    end;
  end;
end;

begin
  setmcga;
  cls(10,vga);
  repeat
    muuta;
  until keypressed;
  settext;
end.
