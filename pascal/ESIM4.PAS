program esim;
uses crt;

var {T„ss„ osassa m„„ritell„„n muuttujat}
  i,j,apu,d,montako:integer; {Kokonaislukumuuttujia}
  uusiluku:boolean; {Totuusarvomuuttuja}
  numero:array[1..7]of integer; {Taulukko kokonaislukumuuttujia}

begin
  clrscr; {Tyhjennet„„n n„ytt”}
  randomize; {Alustetaan satunnaislukugeneraattori}
  textcolor(4); {Textcolor(luku) valitsee tekstin v„rin. Luku on numero yhdest„ viiteentoista.}
  writeln('Montako lottorivi„ arvotaan? '); {N„ytt„„ tekstin}
  textcolor(3); {Asetetaan tekstin v„ri}
  readln(montako); {Kysyt„„n lottorivien lukum„„r„}
  textcolor(1); {Ja taas}
  writeln(''); {Tyhj„ rivi}
  for d:=1 to montako do {Luodaan montako-muuttujan m„„r„„m„ m„„r„ lottorivej„}
  begin
    for i:=1 to 7 do {Arvotaan seitsem„n lukua}
    begin
      repeat {Toistetaan kunnes on arvottu uusi luku}
        numero[i]:=random(39)+1; {random(39) on kokonaisluku v„lilt„ 0-38, johon lis„t„„n 1}
        uusiluku:=true;
        for j:=1 to i-1 do if numero[j]=numero[i] then uusiluku:=false; {Jos numero on jo arvottu, niin arvotaan uudelleen}
      until uusiluku=true;
    end;

    for j:=1 to 6 do for i:=1 to 6 do {K„yd„„n l„pi numero-taulukkoa}
    begin
      if numero[i]>numero[i+1] then
      begin {Vaihdetaan numero-taulukon alkioiden paikkaa}
        apu:=numero[i+1];
        numero[i+1]:=numero[i];
        numero[i]:=apu;
      end;
    end;

    writeln('Lottorivi ',d,':'); {Tulostetaan teksti}
    for i:=1 to 6 do
    begin
      write(numero[i],', '); {Tulostetaan kuusi ensimm„ist„ numeroa}
    end;
    writeln(numero[7]); {Tulostetaan viimeinen numero}
  end;
  readkey; {Odotetaan n„pp„imen painamista}
end.