{$X+}{$G+}
USES Crt;

CONST VGA = $A000;
      MaxLines = 12;
      Obj : Array [1..MaxLines,1..2,1..3] of integer =
        (
        ((10,0,0),(0,0,0)),((0,10,0),(0,0,0)),
        ((0,0,10),(0,0,0)),((0,0,0),(-10,-10,-10)),
        ((0,0,0),(0,0,0)),((0,0,0),(0,0,0)),
        ((0,0,0),(0,0,0)),((0,0,0),(0,0,0)),
        ((0,0,0),(0,0,0)),((0,0,0),(0,0,0)),
        ((0,0,0),(0,0,0)),((0,0,0),(0,0,0))
        );  { The 3-D coordinates of our object ... stored as (X1,Y1,Z1), }
            { (X2,Y2,Z2) ... for the two ends of a line }


Type Point = Record
               x,y,z:real;                { The data on every point we rotate}
             END;
     Virtual = Array [1..64000] of byte;  { The size of our Virtual Screen }
     VirtPtr = ^Virtual;                  { Pointer to the virtual screen }


VAR Lines : Array [1..MaxLines,1..2] of Point;  { The base object rotated }
    Translated : Array [1..MaxLines,1..2] of Point; { The rotated object }
    degx,degy,degz,Xoff,Yoff,Zoff:Integer;               { Used for movement of the object }
    lookup : Array [0..360,1..2] of real; { Our sin and cos lookup table }
    Virscr : VirtPtr;                     { Our first Virtual screen }
    Vaddr  : word;                        { The segment of our virtual screen}


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure SetMCGA;  { This procedure gets you into 320x200x256 mode. }
BEGIN
  asm
     mov        ax,0013h
     int        10h
  end;
END;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure SetText;  { This procedure returns you to text mode.  }
BEGIN
  asm
     mov        ax,0003h
     int        10h
  end;
END;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure Cls (Where:word;Col : Byte);
   { This clears the screen to the specified color }
BEGIN
     asm
        push    es
        mov     cx, 32000;
        mov     es,[where]
        xor     di,di
        mov     al,[col]
        mov     ah,al
        rep     stosw
        pop     es
     End;
END;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure SetUpVirtual;
   { This sets up the memory needed for the virtual screen }
BEGIN
  GetMem (VirScr,64000);
  vaddr := seg (virscr^);
END;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure ShutDown;
   { This frees the memory used by the virtual screen }
BEGIN
  FreeMem (VirScr,64000);
END;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
procedure flip(source,dest:Word);
  { This copies the entire screen at "source" to destination }
begin
  asm
    push    ds
    mov     ax, [Dest]
    mov     es, ax
    mov     ax, [Source]
    mov     ds, ax
    xor     si, si
    xor     di, di
    mov     cx, 32000
    rep     movsw
    pop     ds
  end;
end;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure Pal(Col,R,G,B : Byte);
  { This sets the Red, Green and Blue values of a certain color }
Begin
   asm
      mov    dx,3c8h
      mov    al,[col]
      out    dx,al
      inc    dx
      mov    al,[r]
      out    dx,al
      mov    al,[g]
      out    dx,al
      mov    al,[b]
      out    dx,al
   end;
End;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Function rad (theta : real) : real;
  {  This calculates the degrees of an angle }
BEGIN
  rad := theta * pi / 180
END;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure SetUpPoints;
  { This sets the basic offsets of the object, creates the lookup table and
    moves the object from a constant to a variable }
VAR loop1:integer;
BEGIN
  Xoff:=160;
  Yoff:=100;
  Zoff:=-256;
  For loop1:=0 to 360 do BEGIN
    lookup [loop1,1]:=sin (rad (loop1));
    lookup [loop1,2]:=cos (rad (loop1));
  END;
  For loop1:=1 to MaxLines do BEGIN
    Lines [loop1,1].x:=Obj [loop1,1,1];
    Lines [loop1,1].y:=Obj [loop1,1,2];
    Lines [loop1,1].z:=Obj [loop1,1,3];
    Lines [loop1,2].x:=Obj [loop1,2,1];
    Lines [loop1,2].y:=Obj [loop1,2,2];
    Lines [loop1,2].z:=Obj [loop1,2,3];
  END;
END;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure Putpixel (X,Y : Integer; Col : Byte; where:word);
  { This puts a pixel on the screen by writing directly to memory. }
BEGIN
  Asm
    mov     ax,[where]
    mov     es,ax
    mov     bx,[X]
    mov     dx,[Y]
    mov     di,bx
    mov     bx, dx                  {; bx = dx}
    shl     dx, 8
    shl     bx, 6
    add     dx, bx                  {; dx = dx + bx (ie y*320)}
    add     di, dx                  {; finalise location}
    mov     al, [Col]
    stosb
  End;
END;



{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure Line(a,b,c,d:integer;col:byte;where:word);
  { This draws a solid line from a,b to c,d in colour col }
  function sgn(a:real):integer;
  begin
       if a>0 then sgn:=+1;
       if a<0 then sgn:=-1;
       if a=0 then sgn:=0;
  end;
var i,s,d1x,d1y,d2x,d2y,u,v,m,n:integer;
begin
     u:= c - a;
     v:= d - b;
     d1x:= SGN(u);
     d1y:= SGN(v);
     d2x:= SGN(u);
     d2y:= 0;
     m:= ABS(u);
     n := ABS(v);
     IF NOT (M>N) then
     BEGIN
          d2x := 0 ;
          d2y := SGN(v);
          m := ABS(v);
          n := ABS(u);
     END;
     s := m shr 1;
     FOR i := 0 TO m DO
     BEGIN
          putpixel(a,b,col,where);
          s := s + n;
          IF not (s<m) THEN
          BEGIN
               s := s - m;
               a:= a + d1x;
               b := b + d1y;
          END
          ELSE
          BEGIN
               a := a + d2x;
               b := b + d2y;
          END;
     end;
END;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure DrawLogo;
  { This draws 'ASPHYXIA' at the top of the screen in little balls }
CONST ball : Array [1..5,1..5] of byte =
         ((0,1,1,1,0),
          (1,4,3,2,1),
          (1,3,3,2,1),
          (1,2,2,2,1),
          (0,1,1,1,0));

VAR Logo : Array [1..5] of String;
    loop1,loop2,loop3,loop4:integer;
BEGIN
  pal (13,0,63,0);
  pal (1,0,0,40);
  pal (2,0,0,45);
  pal (3,0,0,50);
  pal (4,0,0,60);
  Logo[1]:=' O  OOO OOO O O O O O O OOO  O ';
  Logo[2]:='O O O   O O O O O O O O  O  O O';
  Logo[3]:='OOO OOO OOO OOO  O   O   O  OOO';
  Logo[4]:='O O   O O   O O  O  O O  O  O O';
  Logo[5]:='O O OOO O   O O  O  O O OOO O O';
  For loop1:=1 to 5 do
    For loop2:=1 to 31 do
      if logo[loop1][loop2]='O' then
        For loop3:=1 to 5 do
          For loop4:=1 to 5 do
            putpixel (loop2*10+loop3,loop1*4+loop4,ball[loop3,loop4],vaddr);
END;



{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure RotatePoints (X,Y,Z:Integer);
  { This rotates object lines by X,Y and Z; then places the result in
    TRANSLATED }
VAR loop1:integer;
    temp:point;
BEGIN
  For loop1:=1 to maxlines do BEGIN
    temp.x:=lines[loop1,1].x;
    temp.y:=lookup[x,2]*lines[loop1,1].y - lookup[x,1]*lines[loop1,1].z;
    temp.z:=lookup[x,1]*lines[loop1,1].y + lookup[x,2]*lines[loop1,1].z;

    translated[loop1,1]:=temp;

    If y>0 then BEGIN
      temp.x:=lookup[y,2]*translated[loop1,1].x - lookup[y,1]*translated[loop1,1].y;
      temp.y:=lookup[y,1]*translated[loop1,1].x + lookup[y,2]*translated[loop1,1].y;
      temp.z:=translated[loop1,1].z;
      translated[loop1,1]:=temp;
    END;

    If z>0 then BEGIN
      temp.x:=lookup[z,2]*translated[loop1,1].x + lookup[z,1]*translated[loop1,1].z;
      temp.y:=translated[loop1,1].y;
      temp.z:=-lookup[z,1]*translated[loop1,1].x + lookup[z,2]*translated[loop1,1].z;
      translated[loop1,1]:=temp;
    END;

    temp.x:=lines[loop1,2].x;
    temp.y:=cos (rad(X))*lines[loop1,2].y - sin (rad(X))*lines[loop1,2].z;
    temp.z:=sin (rad(X))*lines[loop1,2].y + cos (rad(X))*lines[loop1,2].z;

    translated[loop1,2]:=temp;

    If y>0 then BEGIN
      temp.x:=cos (rad(Y))*translated[loop1,2].x - sin (rad(Y))*translated[loop1,2].y;
      temp.y:=sin (rad(Y))*translated[loop1,2].x + cos (rad(Y))*translated[loop1,2].y;
      temp.z:=translated[loop1,2].z;
      translated[loop1,2]:=temp;
    END;

    If z>0 then BEGIN
      temp.x:=cos (rad(Z))*translated[loop1,2].x + sin (rad(Z))*translated[loop1,2].z;
      temp.y:=translated[loop1,2].y;
      temp.z:=-sin (rad(Z))*translated[loop1,2].x + cos (rad(Z))*translated[loop1,2].z;
      translated[loop1,2]:=temp;
    END;
  END;
END;



{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure DrawPoints;
  { This draws the translated object to the virtual screen }
VAR loop1:Integer;
    nx,ny,nx2,ny2:integer;
    temp:integer;
BEGIN
  For loop1:=1 to MaxLines do BEGIN
    If (translated[loop1,1].z+zoff<0) and (translated[loop1,2].z+zoff<0) then BEGIN
      temp:=round (translated[loop1,1].z+zoff);
      nx :=round (256*translated[loop1,1].X) div temp+xoff;
      ny :=round (256*translated[loop1,1].Y) div temp+yoff;
      temp:=round (translated[loop1,2].z+zoff);
      nx2:=round (256*translated[loop1,2].X) div temp+xoff;
      ny2:=round (256*translated[loop1,2].Y) div temp+yoff;
      If (NX > 0) and (NX < 320) and (NY > 25) and (NY < 200) and
         (NX2> 0) and (NX2< 320) and (NY2> 25) and (NY2< 200) then
           line (nx,ny,nx2,ny2,13,vaddr);
    END;
  END;
END;

{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure ClearPoints;
  { This clears the translated object from the virtual screen ... believe it
    or not, this is faster then a straight "cls (vaddr,0)" }
VAR loop1:Integer;
    nx,ny,nx2,ny2:Integer;
    temp:integer;
BEGIN
  For loop1:=1 to MaxLines do BEGIN
    If (translated[loop1,1].z+zoff<0) and (translated[loop1,2].z+zoff<0) then BEGIN
      temp:=round (translated[loop1,1].z+zoff);
      nx :=round (256*translated[loop1,1].X) div temp+xoff;
      ny :=round (256*translated[loop1,1].Y) div temp+yoff;
      temp:=round (translated[loop1,2].z+zoff);
      nx2:=round (256*translated[loop1,2].X) div temp+xoff;
      ny2:=round (256*translated[loop1,2].Y) div temp+yoff;
      If (NX > 0) and (NX < 320) and (NY > 25) and (NY < 200) and
         (NX2> 0) and (NX2< 320) and (NY2> 25) and (NY2< 200) then
           line (nx,ny,nx2,ny2,0,vaddr);
    END;
  END;
END;


{컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴}
Procedure MoveAround;
  { This is the main display procedure. Firstly it brings the object towards
    the viewer by increasing the Zoff, then passes control to the user }
VAR deg,loop1:integer;
    ch:char;
BEGIN
  deg:=0;
  ch:=#0;
  Cls (vaddr,0);
  DrawLogo;
  For loop1:=-256 to -40 do BEGIN
    zoff:=loop1*2;
    RotatePoints (degx,degy,degz);
    DrawPoints;
    flip (vaddr,vga);
    ClearPoints;
  END;

  Repeat
    if keypressed then BEGIN
      ch:=upcase (Readkey);
      Case ch of 'A' : degz:=degz+1;
                 'Z' : degz:=degz-1;
                 ',' : degx:=degx-1;
                 '.' : degx:=degx+1;
                 'S' : degy:=degy-1;
                 'X' : degy:=degy+1;
      END;
    END;
    DrawPoints;
    flip (vaddr,vga);
    ClearPoints;
    RotatePoints (degx,degy,degz);
    deg:=(deg+5) mod 360;
  Until ch=#27;
END;


BEGIN
  SetUpVirtual;
  Writeln ('Greetings and salutations! Hope you had a great Christmas and New');
  Writeln ('year! ;-) ... Anyway, this tutorial is on 3-D, so this is what is');
  Writeln ('going to happen ... a wireframe square will come towards you.');
  Writeln ('When it gets close, you get control. "A" and "Z" control the Z');
  Writeln ('movement, "," and "." control the X movement, and "S" and "X"');
  Writeln ('control the Y movement. I have not included rotation control, but');
  Writeln ('it should be easy enough to put in yourself ... if you have any');
  Writeln ('hassles, leave me mail.');
  Writeln;
  Writeln ('Read the main text file for ideas on improving this code ... and');
  Writeln ('welcome to the world of 3-D!');
  writeln;
  writeln;
  Write ('  Hit any key to contine ...');
  Readkey;
  SetMCGA;
  SetUpPoints;
  MoveAround;
  SetText;
  ShutDown;
  Writeln ('All done. This concludes the eigth sample program in the ASPHYXIA');
  Writeln ('Training series. You may reach DENTHOR under the names of GRANT');
  Writeln ('SMITH/DENTHOR/ASPHYXIA on the ASPHYXIA BBS. I am also an avid');
  Writeln ('Connectix BBS user, and occasionally read RSAProg.');
  Writeln ('For discussion purposes, I am also the moderator of the Programming');
  Writeln ('newsgroup on the For Your Eyes Only BBS.');
  Writeln ('The numbers are available in the main text. You may also write to me at:');
  Writeln ('             Grant Smith');
  Writeln ('             P.O. Box 270');
  Writeln ('             Kloof');
  Writeln ('             3640');
  Writeln ('I hope to hear from you soon!');
  Writeln; Writeln;
  Write   ('Hit any key to exit ...');
  Readkey;
END.
