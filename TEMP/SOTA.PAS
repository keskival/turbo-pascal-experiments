program kuva;
uses graph,crt;

type maailma=record
  vaesto:longint;
  p2rahat,p1rahat:longint;
  b,a,driver,modus : integer;

var
 dev,mix,stat,pro,loop : integer;
 md : string;
 ch: char;

procedure alusta;
begin
  driver:=detect;
  initgraph(driver,modus,'c:\turbo\bgi');
  cleardevice;
end;

procedure ruudukko;
begin
  setfillstyle(1,green);
  bar(0,0,300,300);
  for a:=0 to 10 do line(a*30,0,a*30,300);
  for a:=0 to 10 do line(0,a*30,300,a*30);
  for b:=0 to 9 do begin
    for a:=0 to 9 do putpixel(a*30+15,b*30+15,15);
  end;
end;

begin
  alusta;
  ruudukko;
  readkey;
end.
