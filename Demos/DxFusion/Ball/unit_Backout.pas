unit unit_Backout;
{$I DelphiXcfg.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DIB,
  ExtCtrls, DXClass, DXDraws;

const
  EXP_LIFE = 25;
  SPARK_AMOUNT = 200;
  SPARK_LIFE = 100;

type
  TBall = record
    X, Y, SX, SY: Double;
  end;

  TExplosion = record
    X, Y, Age: Integer;
  end;

  TSpark = record
    X, Y, SX, SY: Double;
    Age: Integer;
  end;

  TGameForm = class(TDXForm)
    DXImageList1: TDXImageList;
    DXDraw1: TDXDraw;
    DXTimer1: TDXTimer;
    DBackDIB: TDXDIB;
    TempDIB: TDXDIB;
    procedure FormCreate(Sender: TObject);
    procedure CalcBall; inline;
    procedure CheckCollision; inline;
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
    procedure DXTimer2Timer(Sender: TObject; LagCount: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DXDraw1Initialize(Sender: TObject);
    procedure DXDraw1Finalize(Sender: TObject);
  private
    { Private declarations }
    BrickMap: array[0..10, 0..10] of Integer;
    Spark: array[0..SPARK_AMOUNT] of TSpark;
    Explosion: TExplosion;
    Ball: TBall;
  public
    { Public declarations }     HardwareSwitch: Boolean;
  end;

var
  GameForm: TGameForm;

implementation

{$R *.DFM}

procedure TGameForm.CalcBall;
begin
  Ball.X := Ball.X + Ball.SX;
  Ball.Y := Ball.Y + Ball.SY;
  if (Ball.X < 0) then
  begin
    Ball.SX := -Ball.SX;
    Ball.X := 0;
  end;
  if (Ball.X + 10 > 300) then
  begin
    Ball.SX := -Ball.SX;
    Ball.X := 290;
  end;
  if (Ball.Y < 0) then
  begin
    Ball.SY := -Ball.SY;
    Ball.Y := 0;
  end;
  if (Ball.Y + 10 > 200) then
  begin
    Ball.SY := -Ball.SY;
    Ball.Y := 190;
  end;

  // Spark Trail
  with Spark[random(SPARK_AMOUNT)] do
  begin
    X := Ball.X + 5;
    Y := Ball.Y + 5;
    SX := (random(20) - 10) / 20;
    SY := (random(20) - 10) / 20;
    Age := random(SPARK_LIFE);
  end;
end;

procedure TGameForm.CheckCollision;
var
  BallX, BallY, i: integer;
begin
  BallX := Round(Ball.X - 5);
  BallY := Round(Ball.Y - 5);
  if ((BallY + 10) < 100) then
    if BrickMap[Round(BallX / 30), Round(BallY / 10)] > 0 then
    begin
      Ball.SY := -Ball.SY;
      BrickMap[Round(BallX / 30), Round(BallY / 10)] := BrickMap[Round(BallX / 30), Round(BallY / 10)] - 1;

      Explosion.Age := EXP_LIFE;
      Explosion.X := BallX;
      Explosion.Y := BallY;
      if (Explosion.X < 0) or (Explosion.X + 30 > 300) or (Explosion.Y < 0) or (Explosion.Y + 30 > 200) then
        Explosion.Age := 0;

      if BrickMap[Round(BallX / 30), Round(BallY / 10)] = 0 then
        for i := 0 to SPARK_AMOUNT do
          if Spark[i].Age < 1 then
            with Spark[i] do
            begin
              Age := random(SPARK_LIFE);
              X := (Round(BallX / 30) * 30) + Random(30);
              Y := (Round(BallY / 10) * 10) + Random(10);
              SX := (random(20) - 10) / 20;
              SY := (random(20) - 10) / 20;
            end;
    end;
end;

procedure TGameForm.FormCreate(Sender: TObject);
var
  i, j: integer;
begin
  HardwareSwitch := doHardware in DXDraw1.NowOptions;
  DBackDIB.DIB.SetSize(300, 200, 24);
  //Init Ball
  Ball.X := 200;
  Ball.Y := 100;
  Ball.SX := (random(200) - 100) / 50;
  Ball.SY := (random(200) - 100) / 50;

  //Init Level
  for i := 0 to 9 do
    for j := 0 to 9 do
      BrickMap[i, j] := random(3) + 1;
end;

procedure TGameForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  { Application end }
  if Key=VK_ESCAPE {ESC} then
    Close;
  { Switch hardware-software mode }
  if Key=VK_SPACE {mezernik} then Begin
    DXDraw1.Finalize;
    HardwareSwitch := NOT HardwareSwitch;
    If HardwareSwitch Then
    {hardware}
    Begin
      {$IFDEF D3D_deprecated}
      If NOT (doDirectX7Mode in DXDraw1.Options) Then
        DXDraw1.Options := DXDraw1.Options + [doDirectX7Mode];
      if NOT (do3D in DXDraw1.Options) then
        DXDraw1.Options := DXDraw1.Options + [do3D];
      {$ENDIF}
      if NOT (doHardware in DXDraw1.Options) then
        DXDraw1.Options := DXDraw1.Options + [doHardware];
      if doSystemMemory in DXDraw1.Options then
        DXDraw1.Options := DXDraw1.Options - [doSystemMemory];
    End
    Else
    {software}
    Begin
      {$IFDEF D3D_deprecated}
      If doDirectX7Mode in DXDraw1.Options Then
        DXDraw1.Options := DXDraw1.Options - [doDirectX7Mode];
      if do3D in DXDraw1.Options then
        DXDraw1.Options := DXDraw1.Options - [do3D];
      {$ENDIF}
      if doHardware in DXDraw1.Options then
        DXDraw1.Options := DXDraw1.Options - [doHardware];
      if NOT (doSystemMemory in DXDraw1.Options) then
        DXDraw1.Options := DXDraw1.Options + [doSystemMemory];
    End;

    DXDraw1.Initialize;

    Exit;
  End;

  {  Screen mode change  }
  if (ssAlt in Shift) and (Key=VK_RETURN) {ALT+ENTER} then
  begin
    DXDraw1.Finalize;

    if doFullScreen in DXDraw1.Options then
    begin
      RestoreWindow;

      DXDraw1.Cursor := crDefault;
      BorderStyle := bsSingle;
      DXDraw1.Options := DXDraw1.Options - [doFullScreen];
      DXDraw1.Options := DXDraw1.Options + [doFlip];
    end else
    begin
      StoreWindow;

      DXDraw1.Cursor := crNone;
      BorderStyle := bsNone;
      DXDraw1.Options := DXDraw1.Options + [doFullScreen];
      DXDraw1.Options := DXDraw1.Options - [doFlip];
    end;

    DXDraw1.Initialize;
  end;
end;

procedure TGameForm.DXDraw1Finalize(Sender: TObject);
begin
  DXTimer1.Enabled := False;
end;

procedure TGameForm.DXDraw1Initialize(Sender: TObject);
begin
  DXTimer1.Enabled := True;
end;

procedure TGameForm.DXTimer1Timer(Sender: TObject; LagCount: Integer);
{With DXFusion}
var
  i, j: integer;
begin
  CalcBall;
  CheckCollision;

  if not DXDraw1.CanDraw then
    Exit;
  DXDraw1.BeginScene;
  //Draw Map
  DBackDIB.DIB.Canvas.Brush.Color := clBlack;
  DBackDIB.DIB.Canvas.FillRect(Bounds(0, 0, 300, 200));

  TempDIB.DIB.Assign(DXImageList1.Items.Find('Brick').Picture);
  for i := 0 to 9 do
    for j := 0 to 9 do
      if BrickMap[i, j] > 0 then
        DBackDIB.DIB.DrawTo(TempDIB.DIB, i * 30, j * 10, 30, 10, 0, 30 - (BrickMap[i, j] * 10));

  TempDIB.DIB.Assign(DXImageList1.Items.Find('Spark').Picture);
  for i := 0 to SPARK_AMOUNT do
    if Spark[i].Age > 0 then
      with Spark[i] do
      begin
        X := X + SX;
        Y := Y + SY;
        SY := SY + 0.01;
        Age := Age - 1;
        if (X < 0) or (X + 3 > 300) or (Y < 0) or (Y + 3 > 200) then
          Age := 0
        else
          DBackDIB.DIB.DrawAlpha(TempDIB.DIB, ROUND(Spark[i].X), ROUND(Spark[i].Y), 3, 3, 0, 0, Spark[i].Age * 255 div SPARK_LIFE, clBlack);
      end;

  TempDIB.DIB.Assign(DXImageList1.Items.Find('Ball').Picture);
  DBackDIB.DIB.DrawTransparent(TempDIB.DIB, round(Ball.X), round(Ball.Y), 10, 10, 0, 0, clBlack);

  TempDIB.DIB.Assign(DXImageList1.Items.Find('BlueExplosion').Picture);
  if Explosion.Age > 0 then
  begin
    DBackDIB.DIB.DrawAdditive(TempDIB.DIB, Explosion.X, Explosion.Y, 30, 30, Explosion.Age * 255 div EXP_LIFE, 0);
    Explosion.Age := Explosion.Age - 1;
  end;
  {Draw canvas}
  DBackDIB.DIB.DrawOn(DXDraw1.ClientRect, DXDraw1.Surface.Canvas, 0, 0);
  DXDraw1.EndScene;
  { Draw FrameRate }
  with DXDraw1.Surface.Canvas do
  try
    Brush.Style := bsClear;
    Font.Color := clWhite;
    Font.Size := 10;
    Textout(3, 3, 'FPS: ' + IntToStr(DXTimer1.FrameRate));
    if doHardware in DXDraw1.Options then
    begin
      Textout(3, 14, 'Device: Hardware');
      Textout(3, DXDraw1.Height-16-14, 'Change device mode to software press SPACE.')
    end
    else
    begin
      Textout(3, 14, 'Device: Software');
      Textout(3, DXDraw1.Height-16-14, 'Change device mode to hardware press SPACE.')
    end;
    if doFullScreen in DXDraw1.Options then
      TextOut(3,DXDraw1.Height-16,'For windowed mode press ALT+Enter.')
    else
      TextOut(3,DXDraw1.Height-16,'For fullscreen press ALT+Enter.');
  finally
    Release; {  Indispensability  }
  end;
  DXDraw1.Flip;
end;

procedure TGameForm.DXTimer2Timer(Sender: TObject; LagCount: Integer);
{Pure DelphiX}
var
  i, j: integer;
  R: TRect;
begin
  CalcBall;
  CheckCollision;

  if not DXDraw1.CanDraw then
    Exit;
  DXDraw1.BeginScene;
  DXDraw1.Surface.Fill(0);

  for i := 0 to 9 do
    for j := 0 to 9 do
      if BrickMap[i, j] > 0 then
        DXImageList1.Items.Find('Brick').Draw(DXDraw1.Surface, i * 30, j * 10, BrickMap[i, j] - 1);

  for i := 0 to SPARK_AMOUNT do
    if Spark[i].Age > 0 then
      with Spark[i] do
      begin
        X := X + SX;
        Y := Y + SY;
        SY := SY + 0.01;
        Age := Age - 1;
        if (X < 0) or (X + 3 > 300) or (Y < 0) or (Y + 3 > 200) then
          Age := 0
        else
        begin
          R := Rect(ROUND(Spark[i].X), ROUND(Spark[i].Y), ROUND(Spark[i].X) + DXImageList1.Items.Find('Spark').Width, ROUND(Spark[i].Y) + DXImageList1.Items.Find('Spark').Height);
          DXImageList1.Items.Find('Spark').DrawAlpha(DXDraw1.Surface, R, 0, Spark[i].Age * 255 div SPARK_LIFE);
        end;
      end;

  if Explosion.Age > 0 then
  begin
    R := Rect(Explosion.X, Explosion.Y, Explosion.X + DXImageList1.Items.Find('BlueExplosion').Width, Explosion.Y + DXImageList1.Items.Find('BlueExplosion').Height);
    DXImageList1.Items.Find('BlueExplosion').DrawAdd(DXDraw1.Surface, R, 0, Trunc(255 / EXP_LIFE * Explosion.Age));
    Dec(Explosion.Age);
  end;
  DXImageList1.Items.Find('Ball').Draw(DXDraw1.Surface, round(Ball.X), round(Ball.Y), 0);

  DXDraw1.EndScene;
  { Draw FrameRate }
  with DXDraw1.Surface.Canvas do
  try
    Brush.Style := bsClear;
    Font.Color := clWhite;
    Font.Size := 10;
    Textout(3, 3, 'FPS: '+inttostr(DXTimer1.FrameRate));
    if doHardware in DXDraw1.Options then
    begin
      Textout(3, 14, 'Device: Hardware');
      Textout(3, DXDraw1.Height-16-14, 'Change device mode to software press SPACE.')
    end
    else
    begin
      Textout(3, 14, 'Device: Software');
      Textout(3, DXDraw1.Height-16-14, 'Change device mode to hardware press SPACE.')
    end;
    if doFullScreen in DXDraw1.Options then
      TextOut(3,DXDraw1.Height-16,'For windowed mode press ALT+Enter.')
    else
      TextOut(3,DXDraw1.Height-16,'For fullscreen press ALT+Enter.');
  finally
    Release; {  Indispensability  }
  end;
  DXDraw1.Flip;
end;

end.

