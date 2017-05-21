program neliojuuri;

function laskex (theta,roe:real):real;

  begin
    laskex:=roe*(cos(theta));
  end;

function laskey (theta,roe:real):real;

  begin
    laskey:=roe*(sin(theta));
  end;

function lasketheta (x,y:real):real;

  begin
    lasketheta:=arctan(x/y);
  end;

function laskeroe (x,y:real):real;

  begin
    laskeroe:=sqrt((x*x)+(y*y));
  end;

begin
writeln (laskeroe(3,4),lasketheta(3,4));
writeln (laskex(laskeroe(3,4),lasketheta(3,4)));
writeln (laskey(laskeroe(3,4),lasketheta(3,4)));
end.
