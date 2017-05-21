program asmiter;
uses unit3d, crt;

var
  xz,yz,xc,yc:real;

function iterate(xc,yc:real):integer;
Label Loop,Loppu;
var
  alkux,alkuy,alkuneliox,alkunelioy,neliox,nelioy,apux,apuy:real;

begin
  alkux:=xc;
  alkuy:=yc;

  asm
    mov cx,50
    mov ax, alkux
    mov bx, alkuy
  Loop:
    mov dx, ax
    mov ax, bx
    mul bx
    mov bx, ax
    mov ax, dx
    mul dx
    mov neliox, ax
    mov nelioy, bx


    mov ax, neliox
    add ax, nelioy

    cmp 4, ax
    jc Loppu
    mov ax, neliox
    add ax, alkux
    dec ax, nelioy
    mov dx, apux
    mov apux, ax
    mov ax, dx
    mul apuy
    shl ax
    add ax, alkuy
    mov apuy, ax
    loop Loop;
  Loppu:
    mov iterate, cx
  end;


end;