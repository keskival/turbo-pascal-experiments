program lotto;
uses crt;

type
  lottonum=array[1..7]of integer;

var
  toisto:integer;
  num:lottonum;

begin
  clrscr;
  for toisto:=1 to 7 do num[toisto]:=(random(32)+1);
  for toisto:=1 to 7 do begin
    write(num[toisto]);
    if toisto<>7 then write(',');
    readkey;
    end;
end.
