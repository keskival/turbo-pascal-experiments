program ratk;
uses crt;

var
  ala,a,b,d:real;
  c:longint;

begin
  ala:=3.1415986535897932385/8;
  a:=0;
  b:=2.352;
  repeat
    b:=b+0.0000001;
    a:=0;
    d:=0;
    repeat
      a:=a+0.0001;
      d:=d+(sqrt(1-(a-0.00005)*(a-0.00005))-b*(a-0.00005)*(a-0.00005))*0.0001;
    until (d>=ala)or(a>1);
  clrscr;
  writeln(d);
  writeln(b);
  until ((sqrt(1-a*a)-b*a*a)<0.00001)and((sqrt(1-a*a)-b*a*a)>-0.00001);
  writeln(b);
end.