program hiiri;
uses crt,dos;

procedure luetila (var x,y,nappi1,nappi2 : word);
var regs : registers ;
    stop : integer;
begin
  regs.ax:=3;
  intr(51,regs);
  x:=regs.cx;
  y:=regs.dx;
  nappi1:=(regs.bx and 1);
  nappi2:=(regs.bx and 2) shr 1;
end;

var x1,y1,a,b:word;begin

repeat
luetila(x1,y1,a,b);
writeln(x1,' ',y1,' ',a,' ',b);
until keypressed;
end.