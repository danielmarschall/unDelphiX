unit DXSparkForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXClass, DXDraws, DIB, DXInput{, pixelsdx};

const
  PARTICLE_AMOUNT = 400;     /// Number of particles

type
  TParticle = record
    X, Y, SpeedX, SpeedY, Age, DeltaAge, Max_Age, gravx, gravy: real;
  end;

  TfrmMain = class(TDXForm)
    DXDraw1: TDXDraw;
    DXTimer1: TDXTimer;
    fond: TDXDIB;
    DXInput1: TDXInput;
    DXImageList1: TDXImageList;
    procedure FormCreate(Sender: TObject);
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
    procedure DXDraw1Initialize(Sender: TObject);
    procedure DXDraw1Finalize(Sender: TObject);
    procedure DXPutString(x, y: integer; text: string);
  private
    { Déclarations privées }
    sinus, cosinus: array[0..1023] of integer; // Tableaux précalculés de cosinus et sinus
    procedure DXWriteFrameRate;
    procedure Init_CoSine;
  public
    { Déclarations publiques }
    Particle: array[0..PARTICLE_AMOUNT] of TParticle;
    SCREEN_WIDTH, SCREEN_HEIGHT: integer;
    X1, Y1: Integer;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.init_CoSine;
var
  i: integer;
begin
  for i := 0 to 1023 do
  begin
    cosinus[i] := round(cos(i * pi * 2 / 1024) * 1024);
    sinus[i] := round(sin(i * pi * 2 / 1024) * 1024);
  end;
end;

procedure tfrmMain.DXPutString(x, y: integer; text: string);
begin
  with DXDraw1.Surface.Canvas do
  begin
    Brush.Style := bsSolid;
    Font.Color := 255;
    Font.Size := 12;
    Textout(x, y, text); // Affiche du text

    Release;
  end;
end;

procedure tfrmMain.DXWriteFrameRate;
begin
  with dxdraw1.surface.Canvas do
  begin
    Brush.Style := bsClear;
    Font.Color := clred;
    Font.Size := 12;
    Textout(0, 0, 'FPS : ' + inttostr(dxtimer1.FrameRate)); { Display the FrameRate }

    Release;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin

  RANDOMIZE;
  SCREEN_WIDTH := dxdraw1.Width - 1;
  SCREEN_Height := dxdraw1.Height - 1;
  X1 := SCREEN_WIDTH div 2;
  Y1 := SCREEN_Height div 2;

  init_cosine;

  DXDraw1.Initialize;
  dximagelist1.items.MakeColorTable;
  DXDraw1.ColorTable := dximagelist1.items.ColorTable;  // Assigne la palette
  DXDraw1.DefColorTable := dximagelist1.items.ColorTable;
  DXDraw1.UpdatePalette;

  DXDraw1.Cursor := crNone;   // On cache le curseur
end;

procedure TfrmMain.DXTimer1Timer(Sender: TObject; LagCount: Integer);
var
  xx, yy, i: integer;
  Q: Integer;
begin
  if not (DXDraw1.CanDraw) then
    exit;
  DXInput1.Update; // met à jour les données
  if DXInput1.Keyboard.Keys[27] then
    Close; // est-ce que la touche ESC a été appuyée ? si oui on quitte
  DXDraw1.BeginScene;
  DXDraw1.Surface.Fill(0);
  // dxsurfacelock(DXDraw1.Surface.ISurface4,16);
  xx := Random(SCREEN_WIDTH);
  yy := Random(screen_height);
  for i := 0 to PARTICLE_AMOUNT do
  begin
    with Particle[i] do
    begin
      Age := Age + DeltaAge;
      x := x + SpeedX - gravx;
      y := y + SpeedY + gravy;
      if (Age > Max_Age) or (x < 0) or (x + 16 > screen_width) or (y < 0) or (y + 16 > Screen_Height) then
      begin
        x := xx;
        y := yy;
        SpeedX := (Random(21) - 10) / 5;
        SpeedY := (Random(21) - 10) / 5;
        gravX := (Random(2) + 4) / 10;
        gravY := (Random(5) + 4) / 5;
        Age := 0;
        Max_Age := Random(10) + 2;
        deltaage := (Random(10) + 3) / 100;
      end;
      Q := 255 - ROUND(age * 120);
      //DXImageList1.Items[0].DrawAlpha(DXDraw1.Surface, bounds(round(x), round(y), 16, 16), 0, Q);
      DXImageList1.Items[0].DrawAdd(DXDraw1.Surface, bounds(round(x), round(y), 16, 16), 0, Q);
      //DXImageList1.Items[0].Draw(DXDraw1.Surface,round(x),round(y),0);
//      dxasmpixel16(round(x),round(y),ctable[255]);
    end;
  end;
  DXDraw1.EndScene;
//   dxsurfaceunlock;

  dxwriteframerate;
  DXDraw1.FLip; // on affiche le buffer
end;

procedure TfrmMain.DXDraw1Initialize(Sender: TObject);
var
  i: integer;
begin
  dxtimer1.Enabled := true;
  for i := 0 to PARTICLE_AMOUNT do
  begin
    with Particle[i] do
    begin
      x := X1;
      y := Y1;
      SpeedX := (random(21) - 10) / 5;
      SpeedY := (random(21) - 10) / 5;
      gravX := (random(5) + 4) / 10;
      gravY := (random(5) + 4) / 5;
      Age := 0;
      Max_Age := random(10) + 2;
      deltaage := (random(10) + 3) / 100;
    end;
  end;
end;

procedure TfrmMain.DXDraw1Finalize(Sender: TObject);
begin
  dxtimer1.Enabled := false;
end;

end.

