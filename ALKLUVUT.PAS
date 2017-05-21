program alkuluvut;
uses crt;

var
  ei:boolean;
  i,j:integer;

begin
  clrscr;
  for i:=1000 to 1700 do
  begin
    for j:=2 to round(sqrt(i)) do
    begin
      if (round(i/j))=(i/j) then ei:=true;
    end;
    if ei=false then
    begin
      writeln(i);
      readkey;
    end;
    ei:=false;
  end;
end.