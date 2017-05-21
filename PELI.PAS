program peli;
uses crt;

var
  x:integer;
  kumpi:integer;
  tulos,yht,yht2,i:longint;

procedure play;
begin
  x:=random(10)+1;
  kumpi:=random(2)+1;
  if kumpi=1 then tulos:=x;
  if kumpi=2 then tulos:=2*x;
  if kumpi=1 then yht:=yht+2*x;
  if kumpi=2 then yht:=yht+x;
  if kumpi=1 then yht2:=yht2+x;
  if kumpi=2 then yht2:=yht2+2*x;
  i:=i+1;
  write(yht/i,' : ');
  writeln(yht2/i);
end;

begin
  yht:=0;
  tulos:=0;
  i:=0;
  kumpi:=0;
  randomize;
  repeat play;
  until keypressed;
end.