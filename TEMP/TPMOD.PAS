PROGRAM tpmod;
USES crt;

{$M $4000,0,0} 			{16k stack, no heap - adjust as needed }
{$L MOD-obj.OBJ} 	        { Link in Object file }
{$F+} 				{ force calls to be 'far'}
procedure modvolume(v1,v2,v3,v4:integer); external ; {Can do while playing}
procedure moddevice(var device:integer); external ;
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); external ;
procedure modstop; external ;
procedure modinit; external;
{$F-}

var
 dev,mix,stat,pro,loop : integer;
 md : string;
 ch: char;

begin
        modinit;
	moddevice ( dev ); { Returns device number in DEV or 255 if 'no sound' }
        if (dev =255) then halt(1);         { Exit - no sound }
        if (dev = 0 ) then
           begin
           writeln;
           writeln('* The PC Speaker is not very good at playing modules');
           writeln('* Why not build a simple resistor D/A converter as');
           writeln('* detailed in HARDWARE.DOC - its really great quality');
           writeln('* and only costs a couple of pounds/dollars');
           writeln;
           end;
       	write('Enter module filename             : ');
       	readln(md);
        mix := 10000;   {use 10000 normally }
        pro := 0; {Leave at 0}
        loop :=4; {4 means mod will play forever}
        modvolume (255,255,255,255);    { Full volume }
	modsetup ( stat, dev, mix, pro, loop, md );
       	case stat of
           1: writeln('Not a mod');
           2: writeln('Already playing');
           4: writeln('Out of memory');
       	else
           begin
              writeln('Your program does something here! Press a key');
              ch := readkey;
              modstop;
           end;
        end;
end.
