program lotto;

uses crt;

type rivitype = set of 1..37;

var rivi:rivitype;
    numero:integer;
    i:integer;
    r:integer;
    k:integer;
begin
clrscr;
write ('montako rivi„ arvotaan: ');
readln (k);
 for r:=1 to k do
 begin
  clrscr;
  randomize;
  rivi := [];
  for i:=1 to 7 do
  begin
   repeat
    numero :=random(37) + 1;
    until not(numero in rivi);
    rivi := rivi + [numero];
    write(numero:3);
   end;
   writeln;
   writeln('  siin„ rivi numero: ',r,' paina <enter>...');
   readln;
  clrscr;
  end;
end.