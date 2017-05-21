program matikka;
uses crt;

var
  i,j,k,d:integer;

begin
  clrscr;
  for i:=1 to 10000 do
  begin
    d:=0;
    for j:=1 to 13 do
    begin
      for k:=1 to i do
      begin
        if (j*(2*k+j-1)/2)=i then d:=d+1;
      end;
    end;
    if (d>3)and((i/5)<>round(i/5))and((i/7)<>round(i/7))and((i/3)<>round(i/3)) then writeln(i);
  end;
  readkey;
{  i:=96;
  for j:=1 to 13 do
  begin
    for k:=1 to i do
    begin
      if (j*(2*k+j)/2)=i then writeln(j,' ',k);
    end;
  end;}
end.
