program testi;
uses crt;

var
  key:char;

begin
  repeat
    key:=readkey;
    writeln(ord(key));
  until key='l';
end.
