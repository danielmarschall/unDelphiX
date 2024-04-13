unit ball1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXDraws, DXClass, DirectX;

const
  EXP_LIFE = 10;
  SPARK_AMOUNT = 200;
  SPARK_LIFE = 100;

type
  TBall = record
    X, Y, SX, SY: Double;
  end;

  TExplosion = record
    X, Y, Age: integer;
  end;

  TSpark = record
    X, Y, SX, SY: Double;
    Age: integer;
  end;

  TForm1 = class(TForm)
    DXDraw1: TDXDraw;
    DXImageList1: TDXImageList;
    DXTimer1: TDXTimer;
    procedure FormCreate(Sender: TObject);
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
  private
    { Private declarations }
    procedure CalcBall;
    procedure CheckCollision;
  public
    { Public declarations }
    BrickMap: array[0..10, 0..10] of Integer;
    Spark: array[0..SPARK_AMOUNT] of TSpark;
    Explosion: TExplosion;
    //DBackDIB, DBrick, DBall, DExplosion, DSpark: TDIBUltra;
    Ball: TBall;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.CalcBall;
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

procedure TForm1.CheckCollision;
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

procedure TForm1.FormCreate(Sender: TObject);
var
  i, j: integer;
begin
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

procedure TForm1.DXTimer1Timer(Sender: TObject; LagCount: Integer);
var
  i, j: integer;
  R: TRect;
begin
  CalcBall;
  CheckCollision;

  if not DXDraw1.CanDraw then
    Exit;

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

  DXDraw1.Flip;
end;

end.