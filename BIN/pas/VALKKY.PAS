program valkky;
uses unit3d,crt;
var i:integer;

begin
  setmcga;
  repeat
    for i:=0 to 20 do waitretrace;

    waitretrace;
    pal(0,0,63,63);
    waitretrace;
    pal(0,0,0,0);


  until keypressed;
  settext;
end.