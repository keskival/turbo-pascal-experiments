program koe;

uses graph;
var d,e,a,b,c : integer;
    f : string;
begin
a := 50;
b := 0;
initgraph(d,e,f);
 repeat;
   if b = 16 then b := 0;
   circle(a,b,c);
   a:=a-1;
   b:=b+1;
 until a=0;
readln;
end.