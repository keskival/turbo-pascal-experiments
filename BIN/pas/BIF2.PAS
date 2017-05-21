program bif;
uses unit3d,crt;

var
  a,b,c:integer;
  d,e,f:real;

begin
  setmcga;
  d:=0;
  repeat
    e:=d;
    for a:=0 to 100 do
    begin
      if (e<9999999)and(e>-9999999) then e:=d*e*(1-e);
    end;
    for a:=0 to 200 do
    begin
      if (e<10)and(e>-10) then putpixel(round(79.75*d),round(199-(e*199)),5,vga);
      if (e<9999999)and(e>-9999999) then e:=d*e*(1-e);
    end;
    d:=d+0.0001;
  until d>=4;
  readkey;
end.