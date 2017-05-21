program ovet;
uses crt;

var
  oikein,vaarin,kaikki:longint;
  a,g,palkinto:integer;


procedure play;
begin
  a:=random(3)+1;
  palkinto:=random(3)+1;
  repeat
    g:=random(3)+1;
  until (g<>palkinto)and(g<>a);
  if (g<>a) then
  begin
    if a=palkinto then oikein:=oikein+1;
  end;
  if a<>palkinto then vaarin:=vaarin+1;
  kaikki:=kaikki+1;
  writeln(oikein/kaikki);

end;


begin
  randomize;
  repeat
    play;
  until keypressed;
end.