program piippi;
uses crt;

var
  viive:longint;
  taajuus:integer;

begin
  writeln('Anna taajuus: ');
  readln(taajuus);
  sound(taajuus);
  for viive:=0 to 49999999 do;
  nosound;
end.