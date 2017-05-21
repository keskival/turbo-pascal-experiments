program cool;
uses crt,kamaa;

var
  Pall,Pall2 : Array[0..255,1..3] of Byte;
  r,g,b,i,j:byte;
  loop,z,col:integer;

procedure varit;
begin
  for i:=1 to 255 do begin
    waitretrace;
    pal(i,i,0,0);
  end;
end;

Procedure PalPlay;
  { This procedure mucks about with our "virtual pallette", then shoves it
    to screen. }
Var Tmp : Array[1..3] of Byte;
  { This is used as a "temporary color" in our pallette }
    loop1 : Integer;
BEGIN
   Move(Pall[200],Tmp,3);
     { This copies color 200 from our virtual pallette to the Tmp variable }
   Move(Pall[0],Pall[1],200*3);
     { This moves the entire virtual pallette up one color }
   Move(Tmp,Pall[0],3);
     { This copies the Tmp variable to the bottom of the virtual pallette }
   WaitRetrace;
   For loop1:=1 to 255 do
     pal (loop1,pall[loop1,1],pall[loop1,2],pall[loop1,3]);
END;

begin
  setmcga;
  blackout;
  for z:=0 to 319 do begin
    line (159,99,z,0,col);
    col:=col+1;
    if col>=199 then col:=1;
  end;
  for z:=0 to 199 do begin
    line (159,99,319,z,col);
    col:=col+1;
    if col>=199 then col:=1;
  end;
  for z:=319 downto 0 do begin
    line (159,99,z,199,col);
    col:=col+1;
    if col>=199 then col:=1;
  end;
  for z:=199 downto 0 do begin
    line (159,99,0,z,col);
    col:=col+1;
    if col>=199 then col:=1;
  end;
  varit;
  For Loop := 0 to 200 do BEGIN
    Pall[Loop,1] := Loop mod 64;
  END;
repeat
  palplay;
  until keypressed=true;
end.
