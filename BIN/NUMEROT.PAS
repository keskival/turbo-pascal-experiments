program numba;
uses crt;

var
  i:longint;
  a,palloja:real;

begin
  palloja:=0;
  for i:=1 to 5000000 do
  begin
    a:=i;
    palloja:=palloja+(a*(10000001-a));
    writeln(palloja,' ',i);
  end;
end.