
Program kokeilu;

uses crt ;
var rivi : integer;
    mkr : char;
begin
  clrscr;
  Sound(220);
  delay(750);
  nosound;
  delay(100);
  Sound(220);
  delay(750);
  nosound;
  delay(100);
  Sound(220);
  delay(750);
  nosound;
  write('montako rivi„ haluat tehd„: ');
  readln(rivi);
  writeLn('halusit tehd„ : ',rivi,' rivi„');
  write('paina nappia jatkaaksesi');
  mkr :=readkey;
end.
