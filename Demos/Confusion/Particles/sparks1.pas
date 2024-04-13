unit sparks1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXClass, DXDraws;

const
  SP_AMOUNT = 1000;

type
  TSpark = record
    X, Y, SX, SY, Age, Aging: Double;
  end;

  TForm1 = class(TDXForm)
    DXDraw1: TDXDraw;
    DXImageList1: TDXImageList;
    DXTimer1: TDXTimer;
    procedure FormCreate(Sender: TObject);
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
    procedure DXDraw1Traces0GetImage(Sender: TObject);
    procedure DXDraw1Traces0Render(Sender: TBlit);
  private
    { Private declarations }
    FSparks: array[0..SP_AMOUNT] of TSpark;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to SP_AMOUNT do
    with FSparks[i] do
    begin
      X := random(Width - DXImageList1.Items.Find('Sparks').Height);
      Y := random(DXImageList1.Items.Find('Title').Height) + (ClientHeight div 2 - DXImageList1.Items.Find('Title').Height);
      SX := (random(21) - 10) / 5;
      SY := (random(21) - 10) / 5;
      Age := random(100) / 100;
      Aging := (random(10) + 3) / 100;
    end;
end;

procedure TForm1.DXDraw1Traces0GetImage(Sender: TObject);
begin
  TBlit(Sender).Image := DXImageList1.Items.Find('dx');
end;

procedure TForm1.DXDraw1Traces0Render(Sender: TBlit);
begin
  //
  Sender.Angle := Sender.Angle + 1;
  if Sender.Angle = 256 then Sender.Angle := 0;
  //
end;

procedure TForm1.DXTimer1Timer(Sender: TObject; LagCount: Integer);
var
  i, x, y: Integer;
  R: TRect;
begin
  if not DXDraw1.CanDraw then
    Exit;
  DXDraw1.BeginScene;
  try
    DXImageList1.Items.Find('Background').Draw(DXDraw1.Surface, 0, 0, 0);

    x := 0;
    y := ClientHeight div 2 - DXImageList1.Items.Find('Light').Height div 2;
    R := Rect(x, y, x + DXImageList1.Items.Find('Light').Width, y + DXImageList1.Items.Find('Light').Height);
    DXImageList1.Items.Find('Light').DrawAdd(DXDraw1.Surface, R, 0);

    x := (ClientWidth - DXImageList1.Items.Find('Title').Width) div 2;
    y := (ClientHeight - DXImageList1.Items.Find('Title').Height) div 2;
    R := Rect(x, y, x + DXImageList1.Items.Find('Title').Width, y + DXImageList1.Items.Find('Title').Height);
    DXImageList1.Items.Find('Title').DrawAdd(DXDraw1.Surface, R, 0);

    for i := 0 to SP_AMOUNT do
      with FSparks[i] do
      begin
        Age := Age + Aging;
        x := x + SX;
        SY := SY + (1 / 10);
        y := y + SY;

        if (Age > 1) or (x < 0) or (x + DXImageList1.Items.Find('Sparks').Height > Width) or (y < 0) or (y + DXImageList1.Items.Find('Sparks').Height > Height) then
        begin
          x := random(Width - DXImageList1.Items.Find('Sparks').Height);
          y := ClientHeight div 2 - DXImageList1.Items.Find('Title').Height + random(DXImageList1.Items.Find('Title').Height);
          SX := (random(21) - 10) / 5;
          SY := (random(21) - 10) / 5;
          Age := 0;
          Aging := (random(10) + 1) / 50;
        end;

        R := Rect(round(x), round(y), round(x) + DXImageList1.Items.Find('Sparks').Height, round(y) + DXImageList1.Items.Find('Sparks').Height);
        DXImageList1.Items.Find('Sparks').DrawAdd(DXDraw1.Surface, R, ROUND(Age * 4));

      end;
    DXDraw1.Render(LagCount);  
  finally
    DXDraw1.EndScene;
  end;

  with DXDraw1.Surface.Canvas do
  try
    Brush.Style := bsClear;
    Font.Color := clWhite;
    Font.Size := 12;
    Textout(0, 0, 'FPS: ' + inttostr(DXTimer1.FrameRate));
    if doHardware in DXDraw1.NowOptions then
      Textout(0, 14, 'Device: Hardware')
    else
      Textout(0, 14, 'Device: Software');
  finally
    Release; {  Indispensability  }
  end;

  DXDraw1.Flip;
end;

end.