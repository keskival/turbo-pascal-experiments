program kolmio;
uses unit3d,crt;

type
  osoitin=^lista;
  lista=record
    x,y:real;
    next:osoitin;
  end;

var
  viive:longint;
  i,j,k,l:integer;
  pit,d,a,b,c:real;
  alku,nyky,loppu,apu:osoitin;
  x1,x2,x3,x4,x5:real;
  y1,y2,y3,y4,y5:real;

begin

  setmcga;
  CLS(0,VGA);
  J:=9;
  new(alku);
  alku^.x:=0;
  alku^.y:=50;
  new(alku^.next);
  nyky:=alku^.next;
  nyky^.x:=319;
  nyky^.y:=50;
  nyky^.next:=nil;
  for i:=0 to 6 do
  begin
    nyky:=alku;
    repeat
      loppu:=nyky^.next;
      new(apu);
      nyky^.next:=apu;
      new(apu^.next);
      apu:=apu^.next;
      new(apu^.next);
      apu:=apu^.next;
      apu^.next:=loppu;

      x1:=nyky^.x;
      x2:=loppu^.x;
      y1:=nyky^.y;
      y2:=loppu^.y;
      x3:=(x2-x1)/3+x1;
      x4:=(x3-x1)*2+x1;
      y3:=(y2-y1)/3+y1;
      y4:=(y3-y1)*2+y1;
      pit:=sqrt(sqr(x2-x1)+sqr(y2-y1));
      d:=pit/3;
      {x5:=x1+(x2-x1)/2;}
      y5:=(y2-y1)/2+y1+15;
      {if ((x3-x1)=0) then
      begin
        x5:=(x2-x1)/2+x1;
        if (y2>y1) then x5:=-d*sin(1.0471975512)+x3
        else x5:=d*sin(1.0471975512)+x3;
      end
      else
      begin

        a:=sqrt(2*sqr(d)-2*sqr(d)*cos(2.09439510239));

        x5:=x3+((sqr(d)*cos(1.0471975512))/(x3-x1));
      end;
      if ((y3-y1)=0) then
      begin
      end
      else
      begin
        y5:=y3+((sqr(d)*cos(1.0471975512))/(y3-y1));
      end;}
      a:=sqrt(2*sqr(d)-2*sqr(d)*cos(2.09439510239));
      if ((x1-x2)=0)or(round((y1-y2)*100)=0) then
      begin
        if (x1-x2)=0 then
        begin
          x5:=(x2-x1)/2+x1;
          if (y2>y1) then x5:=-d*sin(1.0471975512)+x3
            else x5:=d*sin(1.0471975512)+x3;

        end;
        if round((y1-y2)*100)=0 then
        begin
          x5:=(x2-x1)/2+x1;
          if (x2>x1) then y5:=d*sin(1.0471975512)+y3
            else y5:=-d*sin(1.0471975512)+y3

        end;
      end
      else
      begin
        if (y2>y1)and(x2<x1) then x5:=x1-a*cos(arctan((y2-y1)/(x2-x1))+0.523598775598)
          else x5:=x1+a*cos(arctan((y2-y1)/(x2-x1))+0.523598775598);
        if (x2>x1) then y5:=y1+a*sin(arctan((y2-y1)/(x2-x1))+0.523598775598)
          else y5:=y1-a*sin(arctan((y2-y1)/(x2-x1))+0.523598775598);
      end;
      line(round(x3),199-round(y3),round(x4),199-round(y4),J,vga);
      line(round(x4),199-round(y4),round(x5),199-round(y5),J,vga);
      nyky^.next^.x:=x3;
      nyky^.next^.y:=y3;
      nyky^.next^.next^.x:=x5;
      nyky^.next^.next^.y:=y5;
      nyky^.next^.next^.next^.x:=x4;
      nyky^.next^.next^.next^.y:=y4;
      nyky:=loppu;
{      for viive:=0 to 999999 do;}
    until loppu^.next=nil;
      J:=J+1;
  end;
  nyky:=alku;
  repeat
    x1:=nyky^.x;
    y1:=nyky^.y;
    x2:=nyky^.next^.x;
    y2:=nyky^.next^.y;
{    line(round(x1),199-round(y1),round(x2),199-round(y2),6,vga);}
    nyky:=nyky^.next;
  until nyky^.next=nil;
  readkey;
  settext;

end.