
Program kokeilu;

uses crt ;
var rivi : integer;
    nuoli : char;
begin
 { clrscr;
  Sound(220);
  delay(750);
  nosound;
  write('montako rivi„ haluat tehd„: ');
  readln(rivi);
  writeLn('halusit tehd„ : ',rivi,' rivi„');
  write('paina nappia jatkaaksesi'); }
  clrscr;
  write ('k„yt„ nuolinappeja');
  repeat
  nuoli :=readkey;
  until nuoli = #72 ;
       begin
       writeln('painoit oikealle');
       end;
  until nuoli = #80 ;
      begin
      writeln('painoit vasemmalle');
      end;
  until nuoli = #75 do
     begin
     writeln('painoit alas');
     end;
  until nuoli = #77 do
    begin
    writeln('painoit yl”s');
    end;
end;
end.