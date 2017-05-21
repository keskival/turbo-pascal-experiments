program matikka;
uses crt;

var
  i,j,k,d:integer;

begin
  clrscr;
  for i:=1 to 50 do
  begin
    d:=0;
    for j:=1 to 13 do
    begin
      for k:=1 to i do
      begin
        if (j*(2*k+j-1)/2)=i then d:=d+1;
      end;
    end;
    writeln(i,' ',d);
  end;
  readkey;
  for i:=51 to 100 do
  begin
    d:=0;
    for j:=1 to 13 do
    begin
      for k:=1 to i do
      begin
        if (j*(2*k+j-1)/2)=i then d:=d+1;
      end;
    end;
    writeln(i,' ',d);
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
