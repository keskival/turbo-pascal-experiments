program test;
uses graf,crt;
var
  orig:array[1..10,1..3]of byte;
  vari:byte;
  x,y,i:integer;

procedure valaise;
var
  val,himm,loppu:boolean;
  red,green,blue:byte;
begin
  repeat
    loppu:=false;
    getpal(vari,red,green,blue);
    if red<orig[vari,1] then red:=red+1;
    if blue<orig[vari,3] then blue:=blue+1;
    if green<orig[vari,2] then green:=green+1;
    if (red>=orig[vari,1])and(green>=orig[vari,2])and(blue>=orig[vari,3]) then val:=true;
    waitretrace;
    pal(vari,red,green,blue);
    if vari-1=0 then vari:=11;
    getpal(vari-1,red,green,blue);
    if red>0 then red:=red-1;
    if blue>0 then blue:=blue-1;
    if green>0 then green:=green-1;
    if (red<=0)and(green<=0)and(blue<=0) then himm:=true;
    if (val=true)and(himm=true) then loppu:=true;
    waitretrace;
    pal(vari-1,red,green,blue);
    if vari=11 then vari:=1;
  until loppu=true;
end;

procedure otavarit;
var
  red,green,blue:byte;

begin
  for i:=1 to 10 do
  begin
    getpal(i,red,green,blue);
    orig[i,1]:=red;
    orig[i,2]:=green;
    orig[i,3]:=blue;
    pal(i,orig[i,1],orig[i,2],orig[i,3]);
  end;
end;

procedure piirra;
begin
  cls(0,vga);
  for i:=10 downto 1 do
  begin
    polygon(x-i*3,y-i*3,x+i*3,y-i*3,x+i*3,y+i*3,x-i*3,y+i*3,i,vga);
  end;
end;

procedure play;
begin
  vari:=vari+1;
  if vari=11 then vari:=1;
  valaise;
end;

begin
  x:=159;
  y:=99;
  setmcga;
  cls(0,vga);
  piirra;
  otavarit;
  repeat
    play;
  until keypressed;
  settext;
end.
