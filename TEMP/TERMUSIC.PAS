PROGRAM cool;
USES demoinit,crt;

{$M $4000,0,0} 			{16k stack, no heap - adjust as needed }
{$L MOD-obj.OBJ} 	        { Link in Object file }
{$F+} 				{ force calls to be 'far'}
procedure modvolume(v1,v2,v3,v4:integer); external ;
procedure moddevice(var device:integer); external ;
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); external ;
procedure modstop; external ;
procedure modinit; external;
{$F-}

var
 key:char;
 p1kuollut,p2kuollut:boolean;
 p1x,p1y,p2x,p2y,p1su,p2su:integer;
 oldp1x,oldp1y,oldp2x,oldp2y:integer;
 dev,mix,stat,pro,loop : integer;
 md : string;
 ch: char;

begin
        modinit;
      	dev:=7;
        md:='c:\music\mod\godzilla.mod';
        mix := 10000;
        pro := 0;
        loop :=4;
        modvolume (255,255,255,255);
	modsetup ( stat, dev, mix, pro, loop, md );
       	case stat of
           4: writeln('Out of memory');
       	else
           begin
              openscreen;
              repeat
              key:=readkey;
              if key='5' then p1kuollut:=true;
              until (p1kuollut=true)or(p2kuollut=true);
           end;
        end;
end.
