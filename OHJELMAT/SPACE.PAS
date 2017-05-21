program planets;
uses graph,crt,tpr,kamaa;

var
   edemaax,edemaay,edekuux,edekuuy:integer;
   viive:longint;
   temp,maax,maay,kuux,kuuy:extended;
   maar,maat,kuur,kuut:extended;

begin
     setmcga;
     putpixel(159,99,14);
     repeat
     temp:=0;
     repeat
     begin
         maat:=temp;
         maar:=60;
         kuur:=20;
         maax:=ddx(maat,maar);
         maay:=ddy(maat,maar);
         if kuut>=6.283 then kuut:=0;
         kuux:=ddx(kuut,kuur);
         kuuy:=ddy(kuut,kuur);
         kuut:=kuut+0.0036;
         putpixel(edekuux,edekuuy,16);
         putpixel(edemaax,edemaay,16);
         putpixel(round((maax+159)+kuux),round((maay+99)+kuuy),7);
         putpixel(159+round(maax),99+round(maay),9);
         edekuux:=round((maax+159)+kuux);
         edekuuy:=round((maay+99)+kuuy);
         edemaax:=159+round(maax);
         edemaay:=99+round(maay);
         temp:=temp+0.0003;
         end;
     until temp>=6.283185307;
     until keypressed;
end.

