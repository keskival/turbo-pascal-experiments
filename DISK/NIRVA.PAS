program nirvana;
uses graf,crt;

var
  vari:byte;
  x,y:array[1..4]of integer;
  xsu,ysu:integer;

procedure piirra;
begin
  polygon(x[1],y[1],x[2],y[2],x[3],y[3],x[4],y[4],vari,vga);
  vari:=vari+1;
  if vari=255 then vari:=1;
end;

procedure play;
begin
  if (x[1]+xsu<50)or(x[1]+xsu>269) then xsu:=-xsu;
  if (y[1]+ysu<50)or(y[1]+ysu>149) then ysu:=-ysu;
  x[1]:=x[1]+xsu;
  y[1]:=y[1]+ysu;
  x[2]:=159+(159-x[1]);
  y[2]:=y[1];
  x[3]:=159+(159-x[1]);
  y[3]:=99+(99-y[1]);
  x[4]:=x[1];
  y[4]:=99+(99-y[1]);
  piirra;
end;

begin
  setmcga;
  xsu:=1;
  ysu:=1;
  x[1]:=159;
  y[1]:=99;
  repeat
    play;
  until keypressed;
  settext;
end.
