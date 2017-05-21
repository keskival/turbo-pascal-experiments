program CrtDemo;
uses Crt;
var
  OrigMode,LastCol,LastRow: Word;
  Ch: Char;
  Done: Boolean;

procedure Initialize;
begin
  CheckBreak:=False;
  OrigMode:=LastMode;
  TextMode(Lo(LastMode)+Font8x8);
  LastCol:=Lo(WindMax)+1;
  LastRow:=Hi(WindMax)+1;
  GoToXY(1,LastRow);
  TextBackground(Black);
  TextColor(White);
  Write(' Ins-InsLine  ',
        'Del-DelLine  ',
        #27#24#25#26'-Cursor  ',
        'Alt-R-Random  ',
        'Esc-Exit');
    Randomize;
gotoxy(30,1);
textcolor(red+blink);
writeln ('krapula testeri');
textcolor(green+blink);
writeln ('                        katso ruutua minuutin ajan');
textcolor(yellow);
writeln ('                              paina alt+r');
end;

procedure RandomText;
begin
  repeat
    TextBackground(Random(8));
    TextColor(Random(7)+blink);
    Write(' ');
  until KeyPressed;
end;

begin
  Initialize;
  Done:=False;
  repeat
    Ch:=ReadKey;
    case Ch of
      #0:
      begin
        Ch:=ReadKey;
        case Ch of
          #19: RandomText;
          #45: Done:=True;
          #82: InsLine;
          #83: DelLine;
        end;
      end;
      #3: Done:=True;
      #13: WriteLn;
      #27: Done:=True;
    else
      Write(Ch);
    end;
  until Done;
  TextMode(OrigMode);
clrscr;
textcolor(lightgray+blink);
writeln('          jos n„pp„imist”ll„si on oksennusta niin olet krapulassa');
writeln('                              paina nappia');
readkey;
end.