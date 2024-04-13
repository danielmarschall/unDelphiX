unit DXMainform;
// Particles FX adapted by J.DELAUNEY for DelphiX
// E-mail : jdelauney@infonie.fr
// Web : http://www.multimania.com/jdelauney
// Original source code by : Joakim Back
//  ==> http://www.algonet.se/~aseback/acoustic/

// Press Key in 0 to 9 for changing Particles's Values
// Esc for exit

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DXClass, DXDraws, DIB, DXInput, pixelsdx;

const
  PARTICLE_AMOUNT = 1500;     /// Number of particles
  DARK_PARTICLES = 50;

type
  TParticle = record
    X, Y, SpeedX, SpeedY, Angle, MaxAngle, GravityX, GravityY, VelocityX, VelocityY: real;
  end;

  TForm1 = class(TDXForm)
    DXDraw1: TDXDraw;
    DXTimer1: TDXTimer;
    fond: TDXDIB;
    DXInput1: TDXInput;
    procedure FormCreate(Sender: TObject);
    procedure DXTimer1Timer(Sender: TObject; LagCount: Integer);
    procedure DXDraw1Initialize(Sender: TObject);
    procedure DXDraw1Finalize(Sender: TObject);
    procedure DXPutString(x, y: integer; text: string);
  private
    { Déclarations privées }
    sinus, cosinus: array[0..1023] of integer; // Tableaux précalculés de cosinus et sinus
    ctable: array[0..255] of integer;
    procedure DXWriteFrameRate;
    procedure ConvertTable;
    procedure Init_CoSine;
    procedure DxDibFillColors(i1, i2: Byte; c1, c2: Trgbquad);
  public
    { Déclarations publiques }
    Particle: array[0..PARTICLE_AMOUNT] of TParticle;
    vscreen: array[0..639, 0..479] of Byte;
    Direction: Integer;
    BLUR_DECAY, BLUR_SPREAD: Integer;
    PARTICLE_EFFECT: Integer;
    SCREEN_WIDTH, SCREEN_HEIGHT: Integer;
    RX, RY, X1, Y1: Integer;
    currentcolor: Integer;
    angle, Row1, Row2A, Row2B, Row2C, k: Integer;
  end;


var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure Tform1.DxDibFillColors(i1, i2: Byte; c1, c2: Trgbquad);
var
  ir, ig, ib, r, g, b: Integer;
  i, x: Byte;
begin
  x := i2 - i1;
  r := c1.rgbred shl 16;
  ir := ((c2.rgbred - c1.rgbred) shl 16) div x;
  g := c1.rgbgreen shl 16;
  ig := ((c2.rgbgreen - c1.rgbgreen) shl 16) div x;
  b := c1.rgbblue shl 16;
  ib := ((c2.rgbblue - c1.rgbblue) shl 16) div x;
  for i := 0 to x do
  begin
    dxdraw1.ColorTable[i1 + i].rgbRed := r shr 16;
    Inc(r, ir);
    dxdraw1.ColorTable[i1 + i].rgbgreen := g shr 16;
    Inc(g, ig);
    dxdraw1.ColorTable[i1 + i].rgbblue := b shr 16;
    Inc(b, ib);
    dxdraw1.ColorTable[i1 + i].rgbReserved := 0;
  end;
end;

procedure Tform1.ConvertTable;
var
  i: integer;
begin
  for i := 0 to 255 do
  begin
    CTable[i] := convertcolor816(i, dxdraw1);
  end;
end;

procedure TForm1.init_CoSine;
var
  i: integer;
begin
  for i := 0 to 1023 do
  begin
    cosinus[i] := round(cos(i * pi * 2 / 1024) * 1024);
    sinus[i] := round(sin(i * pi * 2 / 1024) * 1024);
  end;
end;

procedure tform1.DXPutString(x, y: integer; text: string);
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

procedure tform1.DXWriteFrameRate;
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

procedure TForm1.FormCreate(Sender: TObject);
var
//  yi: word;
  val1, val2: TRGBQuad;
begin

  RANDOMIZE;
  SCREEN_WIDTH := dxdraw1.Width - 1;
  SCREEN_Height := dxdraw1.Height - 1;
  X1 := SCREEN_WIDTH div 2;
  Y1 := SCREEN_Height div 2;
  BLUR_DECAY := 4;             /// Fadeout speed
  BLUR_SPREAD := 2;            /// Blur value, the larger the less spread
  PARTICLE_EFFECT := 0;        /// Begin with first effect
  Angle := 2;

  init_cosine;

  DXDraw1.Initialize;
//     DXDraw1.ColorTable := fond.DIB.ColorTable;  // Assigne la palette
//     DXDraw1.DefColorTable := fond.DIB.ColorTable;
//     DXDraw1.UpdatePalette;

  FillChar(dxdraw1.ColorTable, 255, 0);
  val1.rgbBlue := 0;
  val1.rgbGreen := 24;
  val1.rgbRed := 0;
  val1.rgbReserved := 0;
  val2.rgbBlue := 0;
  val2.rgbGreen := 128;
  val2.rgbRed := 0;
  val2.rgbReserved := 0;
  dxdibFillColors(1, 64, val1, val2);

  val1.rgbBlue := 0;
  val1.rgbGreen := 128;
  val1.rgbRed := 0;
  val1.rgbReserved := 0;
  val2.rgbBlue := 0;
  val2.rgbGreen := 160;
  val2.rgbRed := 0;
  val2.rgbReserved := 0;
  dxdibFillColors(64, 127, val1, val2);

  val1.rgbBlue := 0;
  val1.rgbGreen := 160;
  val1.rgbRed := 0;
  val1.rgbReserved := 0;
  val2.rgbBlue := 0;
  val2.rgbGreen := 192;
  val2.rgbRed := 0;
  val2.rgbReserved := 0;
  dxdibFillColors(128, 192, val1, val2);

  val1.rgbBlue := 0;
  val1.rgbGreen := 192;
  val1.rgbRed := 0;
  val1.rgbReserved := 0;
  val2.rgbBlue := 0;
  val2.rgbGreen := 255;
  val2.rgbRed := 0;
  val2.rgbReserved := 0;
  dxdibFillColors(192, 232, val1, val2);

  val1.rgbBlue := 0;
  val1.rgbGreen := 255;
  val1.rgbRed := 0;
  val1.rgbReserved := 0;
  val2.rgbBlue := 255;
  val2.rgbGreen := 255;
  val2.rgbRed := 255;
  val2.rgbReserved := 0;
  dxdibFillColors(232, 255, val1, val2);

  dxdraw1.UpdatePalette;

  ConvertTable;

  DXDraw1.Cursor := crNone;   // On cache le curseur


end;

procedure TForm1.DXTimer1Timer(Sender: TObject; LagCount: Integer);
var
  i, j, k: integer;
begin
  if not (DXDraw1.CanDraw) then
    exit;
  dxinput1.Update; // met à jour les données
  if dxinput1.Keyboard.Keys[27] then
    close; // est-ce que la touche ESC a été appuyée ? si oui on quitte
  if dxinput1.Keyboard.Keys[ord('1')] then
    PARTICLE_EFFECT := 1;
  if dxinput1.Keyboard.Keys[ord('2')] then
    PARTICLE_EFFECT := 2;
  if dxinput1.Keyboard.Keys[ord('3')] then
    PARTICLE_EFFECT := 3;
  if dxinput1.Keyboard.Keys[ord('4')] then
    PARTICLE_EFFECT := 4;
  if dxinput1.Keyboard.Keys[ord('5')] then
    PARTICLE_EFFECT := 5;
  if dxinput1.Keyboard.Keys[ord('6')] then
    PARTICLE_EFFECT := 6;
  if dxinput1.Keyboard.Keys[ord('7')] then
    PARTICLE_EFFECT := 7;
  if dxinput1.Keyboard.Keys[ord('8')] then
    PARTICLE_EFFECT := 8;
  if dxinput1.Keyboard.Keys[ord('9')] then
    PARTICLE_EFFECT := 9;
  if dxinput1.Keyboard.Keys[ord('0')] then
    PARTICLE_EFFECT := 0;
  dxdraw1.BeginScene;
  dxdraw1.surface.Fill(0);
// fillchar(vscreen,sizeof(vscreen),0);
// dxsurfacelock(dxdraw1.surface.ISurface4,16);
  for j := 0 to PARTICLE_AMOUNT do
  begin
    with Particle[j] do
    begin
      if particle_effect = 9 then
      begin
        x1 := SCREEN_WIDTH div 2;
        y1 := SCREEN_HEIGHT - 1;
      end
      else
      begin
        x1 := SCREEN_WIDTH div 2;
        y1 := SCREEN_HEIGHT div 2;
      end;

      x := x + SpeedX;
      y := y + SpeedY;
      case PARTICLE_EFFECT of
        0:
          begin  /// Weird "twirl" effect
            SpeedX := SpeedX + (SpeedY / 50);
            SpeedY := SpeedY - (SpeedX / 160);
          end;
        1:
          begin  /// Water bubbles
            if random(100) < 20 then
            begin
              SpeedX := (x - X1) / 10;
              SpeedY := (y - Y1) / 10;
            end;
            if random(100) < 10 then
            begin
              x := random(SCREEN_WIDTH);
              y := random(SCREEN_HEIGHT);
              SpeedX := (x - X1) / 10;
              SpeedY := (y - Y1) / 10;
            end;
          end;
        2:
          begin  /// Followers
            if x > X1 then
              SpeedX := SpeedX - (1 / 10) * ABS(x - X1) / (ABS(x - X1) + ABS(y - Y1));
            if x < X1 then
              SpeedX := SpeedX + (1 / 10) * ABS(x - X1) / (ABS(x - X1) + ABS(y - Y1));
            if y > Y1 then
              SpeedY := SpeedY - (1 / 10) * ABS(y - Y1) / (ABS(x - X1) + ABS(y - Y1));
            if y < Y1 then
              SpeedY := SpeedY + (1 / 10) * ABS(y - Y1) / (ABS(x - X1) + ABS(y - Y1));
          end;
        3:
          begin  /// Distorted Flight
            x := x + sin((45 * y) / (180 / PI));
            y := y + cos((45 * x) / (180 / PI));
            SpeedX := ((x - (SCREEN_WIDTH / 2)) / 40) + ((random(401) - 200) / 50);
            SpeedY := ((y - (SCREEN_HEIGHT / 2)) / 40) + ((random(401) - 200) / 50);
          end;
        4:
          begin  /// Rotating
            x := x + sin((5 * y) / (180 / PI));
            y := y + cos((5 * x) / (180 / PI));
          end;
        5:
          begin  /// Christmas powder
            if random(100) < 1 then
              SpeedX := (SpeedX / 8);
            if random(100) < 1 then
              SpeedY := (SpeedY / 8);
          end;
        6:
          begin  /// Random walk
            if random(100) < 1 then
              SpeedX := -SpeedX;
            if random(100) < 1 then
              SpeedY := -SpeedY;
          end;
        7:
          begin  /// Nova blast
            SpeedX := SpeedX + (SpeedX / 150);
            SpeedY := SpeedY + (1 / 150);
          end;
        8:
          begin  /// Scotish Square
            x := x + cos((45 * x) / (180 / PI));
            y := y + sin((45 * y) / (180 / PI));
            SpeedX := ((x - (SCREEN_WIDTH / 2)) / 40) + ((random(401) - 200) / 50);
            SpeedY := ((y - (SCREEN_HEIGHT / 2)) / 40) + ((random(401) - 200) / 50);
          end;
        9:
          begin  /// Smoke
            x := x + sin((5 * y) / (180 / PI)) + random(4);
            y := y + cos((5 * x) / (180 / PI)) - random(6);
          end;

      end;
      if (x < 1) or (x > SCREEN_WIDTH - 2) or (y < 1) or (y > SCREEN_HEIGHT - 2) or (RANDOM(200) < 1) then
      begin   /// Outside screen? ReInit particle!
        x := X1;
        y := Y1;
        SpeedX := (random(100) / 100) + 0.01;
        if random(101) < 50 then
          SpeedX := -SpeedX;
        SpeedY := (random(100) / 100) + 0.01;
        if random(101) < 50 then
          SpeedY := -SpeedY;
      end;
      vscreen[round(x), round(y)] := 255;
//    dxasmpixel16(round(x),round(y),ctable[255]);
    end;
  end;

  for j := 0 to DARK_PARTICLES do
  begin
    Rx := random(SCREEN_WIDTH);
    Ry := random(SCREEN_HEIGHT);
    CurrentColor := vscreen[Rx, Ry];
    CurrentColor := CurrentColor - random(10);
    if CurrentColor < 0 then
      CurrentColor := 0;
    vscreen[Rx, Ry] := CurrentColor;
  end;
// dxsurfacelock(dxdraw1.surface.ISurface4,16);
  for j := 1 to SCREEN_HEIGHT - 2 do
  begin
    Row1 := j + Direction;
    Row2A := j - 1;
    Row2B := j;
    Row2C := j + 1;
    for k := 1 to (SCREEN_WIDTH - 2) do
    begin  /// 3x3 Matrix Blur, BLUR_SPREAD is a multiplier of original pixel
//    vscreen[k-1,Row2A]+vscreen[k,Row2A]+vscreen[k+1,Row2A]
      CurrentColor := ROUND((vscreen[k - 1, Row2A] + vscreen[k, Row2A] + vscreen[k + 1, Row2A] + vscreen[k - 1, Row2B] + (BLUR_SPREAD * vscreen[k, Row2B]) + vscreen[k + 1, Row2B] + vscreen[k - 1, Row2C] + vscreen[k, Row2C] + vscreen[k + 1, Row2C]) / (8 + BLUR_SPREAD));
      if CurrentColor > BLUR_DECAY then
        Dec(CurrentColor, BLUR_DECAY)
      else
        CurrentColor := 0; /// Fade out pixel
      vscreen[k, Row1] := CurrentColor; /// ----- Assign result to pixel -----
//      dxasmpixel16(k,row1,ctable[Currentcolor]);
    end;
  end;
  if DIrection > 1 then
    Direction := -1;
  //dxsurfacelock(dxdraw1.surface.ISurface4, 16);
  DXDraw1.Surface.Lock;
  try
    for i := 1 to 640 do
      for j := 1 to 480 do
        DXDraw1.Surface.Pixel[i, j] := ctable[vscreen[i, j]];
        //dxasmpixel16(i, j, ctable[vscreen[i, j]]);

  finally
    DXDraw1.Surface.UnLock;
    DXDraw1.EndScene;
    //dxsurfaceunlock;
  end;

  dxwriteframerate;
  DXDraw1.FLip; // on affiche le buffer
end;

procedure TForm1.DXDraw1Initialize(Sender: TObject);
begin
  dxtimer1.Enabled := true;
end;

procedure TForm1.DXDraw1Finalize(Sender: TObject);
begin
  dxtimer1.Enabled := false;
end;

end.

