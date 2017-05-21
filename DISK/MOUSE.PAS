UNIT MOUSE;
{
  THIS PROGRAM WAS CODED BY BJARKE VIKS0E.
  YOU ARE FREE TO DO WHATEVER YOU WANT WITH THIS PIECE OF CODE.
  E-MAIL ME AT: dat92230@rix02.lyngbyes.dk IN 1994 FOR CHAT AND CODE.
}

INTERFACE

function InitMouse : boolean;
{Initialize mouse to its default values for current screenmode.
 Mouse is turned off.}
function MouseDriverPresent : boolean;
{Returns TRUE if there were a mouse driver out there...}
procedure MouseOn;
{Turns mouse image on}
procedure MouseOff;
{Turns mouse image off}
procedure MouseInfo(VAR x,y : integer; VAR lb,rb : boolean);
{Get information about current x- and y-positions.
 Also return info about current status of mouse buttons}
procedure SetMousePos(x,y : integer);
{Set mouse position...}


IMPLEMENTATION

function InitMouse : boolean; assembler;
asm
	xor	ax,ax
	int	$33
	not	ax
	xor	ax,1
	and	ax,1
end;

function MouseDriverPresent : boolean; assembler;
asm
	mov	ax,$0021
	int	$33
	mov	cx,FALSE
	cmp	ax,-1
	jne	@not
	mov	cx,TRUE
@not:
	mov	ax,cx
end;

procedure MouseOn; assembler;
asm
	mov	ax,$0001
	int	$33
end;

procedure MouseOff; assembler;
asm
	mov	ax,$0002
	int	$33
end;

procedure MouseInfo(VAR x,y : integer; VAR lb,rb : boolean); assembler;
asm
	mov	ax,$0003
	int	$33
	les	si,x
	mov	[es:si],cx
	les	si,y
	mov	[es:si],dx

	mov	ax,bx
	and	al,1
	les	si,lb
	mov	[es:si],al
	shr	bl,1
	and	bl,1
	les	si,rb
	mov	[es:si],bl
end;

procedure SetMousePos(x,y : integer); assembler;
asm
	mov	ax,$0004
	mov	cx,x
	mov	dx,y
	int	$33
end;

end.
