unit yti;
interface
         uses printer, dos, graph, crt;


         var  tieto ;
              WindMin, WindMax : word;

         procedure kuviin;
         procedure tekstiin;
         procedure suuntaan(kulma, matka : integer);
         procedure fill(variin : integer);          {FloodFill, graph}
         procedure maaliksi(vari : word);                {SetFillStyle, graph}
         procedure kuvio(kuvio : word);               {SetFillStyle, graph}
         procedure text(merkkijono : string);     {OutText, graph}
         procedure fontti(kirjasin, suunta, koko : integer); {SetTextStyle, graph}
         procedure kehys(x1, y1, x2, y2, piirto, tausta : integer);
         procedure suorakulmio(pituus, leveys, vari : integer);
         procedure kiekko(sade, vari : integer);
         procedure sektori(alkukulma, loppukulma, sade, vari : integer);
         procedure clock(x, y : integer);       {GetTime, dos}
         procedure date(x, y : integer);   {GetDate, dos}

implementation

procedure kuviin;
var go, gt, virhekoodi:integer;

begin
     go := ega;
     gt := egahi;
     initgraph(go, gt, '');
     virhekoodi := graphresult;
     if virhekoodi <> grok then
        begin
             writeln('grafiikkavirhe: ', grapherrormsg(virhekoodi));
             writeln('(Onko koneessa grafiikkakortti?)');
             writeln('Ohjelma keskeytetty.');
             halt(1);
        end;
end;

procedure tekstiin;
begin
     TextMode(3);
end;

procedure suuntaan(kulma, matka : integer);
          var koorx, koory : longint;
              rad : real;
          begin
               rad := kulma*pi/180;
               koorx := trunc(cos(rad)*matka);
               koory := trunc(sin(rad)*matka);
               LineTo(GetX+koorx,GetY-koory);
          end;

procedure fill(variin : integer);
         begin
              Floodfill(GetX, GetY, variin);
         end;

procedure maaliksi(vari : word);
         begin
              GetFillSettings(tieto);
              SetFillStyle(tieto.Pattern, vari);
         end;

procedure kuvio(kuvio : word);
    begin
         GetFillSettings(tieto);
         SetFillStyle(kuvio, tieto.Color);
    end;

procedure text(merkkijono : string);
          begin
               OutText(merkkijono);
          end;

procedure fontti(kirjasin, suunta, koko : integer);
          begin
               SetTextStyle(kirjasin, suunta, koko);
          end;

procedure kehys(x1, y1, x2, y2, piirto, tausta : integer);
var x : integer;
begin
     window(x1, y1, x2, y2+1);
     TextColor(piirto);
     TextBackground(tausta);
     for x := 2 to y2-y1 do
         begin
              gotoxy(x2-x1+1, x);
              write('º');
              gotoxy(1, x);
              write('º');
         end;
     for x := 2 to x2-x1 do
         begin
              gotoxy(x, 1);
              write('Í');
              gotoxy(x, y2-y1+1);
              write('Í');
         end;
     gotoxy(x2-x1+1, y2-y1+1); write('¼' );
     gotoxy(1, y2-y1+1); write('È');
     gotoxy(x2-x1+1, 1); write('»');
     gotoxy(1, 1); write('É');
end;

procedure suorakulmio(pituus, leveys, vari : integer);
var v : integer;
begin
     v := GetColor;
     rectangle(GetX, GetY, GetX + pituus, GetY + leveys);
     SetFillStyle(1, vari); FloodFill(GetX + 2, GetY + 2, v);
     SetColor(v);
end;

procedure kiekko(sade, vari : integer);
var tieto : FillSettingsType;
     begin
          maaliksi(vari);
          GetFillSettings(tieto);
          circle(GetX, GetY, sade); SetFillStyle(tieto.pattern, tieto.color);
          FloodFill(GetX, GetY, GetColor);
     end;

procedure sektori(alkukulma, loppukulma, sade, vari : integer);
     begin
          maaliksi(vari);
          PieSlice(GetX, GetY, alkukulma, loppukulma, sade);
     end;

procedure clock(x, y : integer);
var tunti, minuutti, sekunti, sadasosa : word;
    minuuttinolla : string;
begin
     gotoxy(x, y); GetTime(tunti, minuutti, sekunti, sadasosa);
     if minuutti < 10 then minuuttinolla := '0' else minuuttinolla := '';
     writeln('Kello on ', tunti, '.', minuuttinolla, minuutti);
end;

procedure date(x, y : integer);
var vuosi, kuukausi, paiva, paivannro : word;
    viikonpaiva : string;
begin
     GetDate(vuosi, kuukausi, paiva, paivannro);
     case paivannro of
          0 : viikonpaiva := 'Sunnuntai';
          1 : viikonpaiva := 'Maanantai';
          2 : viikonpaiva := 'Tiistai';
          3 : viikonpaiva := 'Keskiviikko';
          4 : viikonpaiva := 'Torstai';
          5 : viikonpaiva := 'Perjantai';
          6 : viikonpaiva := 'Lauantai';
     end;
     gotoxy(x, y);
     writeln(viikonpaiva, ', ',paiva, '.', kuukausi, '.', vuosi);
end;

end.