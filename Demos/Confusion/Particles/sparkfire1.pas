unit sparkfire1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXClass, DXDraws, StdCtrls, Buttons;

const
  SP_AMOUNT = 100;

type
  TSpark = record
    X, Y, SX, SY, Age, Aging: real;
  end;

type
  TForm1 = class(TDXForm)
    DXDraw1: TDXDraw;
    DXImageList1: TDXImageList;
    DXTimer1: TDXTimer;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure DXDraw1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    FSparks: array[0..SP_AMOUNT] of TSpark;
    FX, FY: integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  //ShowCursor(False);
  DXDraw1.Cursor := crNone;

  for i := 0 to SP_AMOUNT do
    with FSparks[i] do
    begin
      X := Width / 2;
      Y := Width / 2;
      SX := (random(11) - 5) / 5;
      SY := (random(11) - 5) / 5;
      Age := 0;
      Aging := (random(15) + 2) / 150;
    end;
end;

procedure TForm1.DXDraw1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  FX := X;
  FY := Y;
end;

procedure TForm1.DXTimer1Timer(Sender: TObject; LagCount: Integer);
var
  i: integer;
  R: TRect;
begin
  if not DXDraw1.CanDraw then
    Exit;

  DXDraw1.Surface.Fill(0);

  for i := 0 to SP_AMOUNT do
    with FSparks[i] do
    begin
      Age := Age + Aging;
      X := X + SX;
      Y := Y + SY;

      if (Age > 1) or (X < 0) or (X + DXImageList1.Items.Find('Sparks').Height > Width) or (Y < 0) or (Y + DXImageList1.Items.Find('Sparks').Height > Height) then
      begin
        X := FX;
        Y := FY;
        SX := (random(21) - 10) / 5;
        SY := (random(21) - 10) / 5;
        Age := 0;
        Aging := (random(10) + 3) / 100;
      end;
      //jako Rect() ale zadava se sirka,vyska
      R := Bounds(round(X), round(Y), DXImageList1.Items.Find('Sparks').Height, DXImageList1.Items.Find('Sparks').Height);
      DXImageList1.Items.Find('Sparks').DrawAdd(DXDraw1.Surface, R, ROUND(Age * 4))
    end;

  DXDraw1.Flip;
end;

end.
