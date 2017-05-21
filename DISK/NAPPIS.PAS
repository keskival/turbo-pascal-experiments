PROGRAM NAPPAIMET;
USES DOS,CRT,KAMAA;

const NAPPMAARA=3;
      KEYBOARDINTR = 9;
      KEYBOARDPORT = $60;

var BIOSKeyboardHandler : procedure;
    CallBIOSHandler : boolean;
    LOPPU:BOOLEAN;
    A,B,C:BYTE;
    NAPP:ARRAY[1..NAPPMAARA]OF BOOLEAN;

{$F+}
procedure KeyboardHandler(Flags, CS, IP, AX, BX, CX, DX,
                          SI, DI, DS, ES, BP: Word);
interrupt;
var key : byte;
begin

  key := Port[KEYBOARDPORT];
  IF KEY=30 THEN NAPP[1]:=TRUE;
  IF KEY=30+128 THEN NAPP[1]:=FALSE;
  IF KEY=48 THEN NAPP[2]:=TRUE;
  IF KEY=48+128 THEN NAPP[2]:=FALSE;
  IF KEY=46 THEN NAPP[3]:=TRUE;
  IF KEY=46+128 THEN NAPP[3]:=FALSE;
  IF KEY=1 THEN LOPPU:=TRUE;
  if CallBIOSHandler then
    begin
      asm pushf end;
      BIOSKeyboardHandler;
    end
  else Port[$20] := $20;
end;
{$F-}

BEGIN
  CallBIOSHandler := false;
  GetIntVec(KEYBOARDINTR, @BIOSKeyboardHandler);
  SetIntVec(KEYBOARDINTR, Addr(KeyboardHandler));
  SETMCGA;
  REPEAT
    GETPAL(0,A,B,C);
    IF A=63 THEN A:=62;
    IF A=0 THEN A:=1;
    WAITRETRACE;
    IF NAPP[1]=TRUE THEN PAL(0,A+1,B,C)
    ELSE PAL(0,A-1,B,C);
    GETPAL(0,A,B,C);
    IF B=63 THEN B:=62;
    IF B=0 THEN B:=1;
    WAITRETRACE;
    IF NAPP[2]=TRUE THEN PAL(0,A,B+1,C)
    ELSE PAL(0,A,B-1,C);
    GETPAL(0,A,B,C);
    IF C=63 THEN C:=62;
    IF C=0 THEN C:=1;
    WAITRETRACE;
    IF NAPP[3]=TRUE THEN PAL(0,A,B,C+1)
    ELSE PAL(0,A,B,C-1);
  UNTIL LOPPU=TRUE;
  SETTEXT;
  SetIntVec(KEYBOARDINTR, @BIOSKeyboardHandler);
END.
