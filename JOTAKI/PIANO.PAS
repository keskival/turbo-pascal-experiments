
Program piano;

uses crt ;
var a : char;

begin
  clrscr;
  textcolor(red + blink);
  writeln ('soita jotain S - L');
  repeat
  a := readkey;
    IF a = 's' then
    sound (220);
      IF  a = 'd' then
      sound (240);
        if a = 'f' then
        sound (260);
          if a = 'g' then
          sound (280);
            if a = 'h' then
            sound (300);
              if a = 'j' then
              sound (320);
                if a = 'k' then
                sound (340);
                  if a = 'l' then
                  sound (360);
                    if a = 'a' then
                    nosound;
            until a = 'q';
            nosound;
end.