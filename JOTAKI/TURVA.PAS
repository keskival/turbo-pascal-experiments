program turva;
uses crt;

var a :integer;
    b :integer;
    c :integer;

procedure alku;
begin
clrscr;
readln(a);
clrscr;
readln(b);
clrscr;
readln(c);
clrscr;
if a < 5 then
  alku;
if a > 5 then
  alku;
if b < 7 then
  alku;
if b > 7 then
  alku;
if c < 2 then
  alku;
if c > 2 then
  alku;
end;

begin
  alku
end.

