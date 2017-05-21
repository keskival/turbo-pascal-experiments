import java.applet.Applet;
import java.awt.Graphics;

public class space extends applet{

  planet: array[1..8] of record
    nimi:string;
    koordx,koordy:real;
    massa:longint;
    nopeus:real;
    sade:real;
    kiertosade:real;
  end;

procedure alusta;
begin
  planet[1].nimi:='Merkurius';
  planet[1].koordx:=50;
  planet[1].koordy:=50;
  planet[1].massa:=330362200000000000000000;
  planet[1].nopeus:=47890;
  planet[1].sade:=5251007.33299;
end;

procedure pyorita;
begin

end;

begin
  setmcga;
  alusta;
  repeat pyorita;
  until keypressed;
  settext;
end.
