unit GaussianBlur1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtDlgs, StdCtrls, ExtCtrls, jpeg;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    Edit1: TEdit;
    Label1: TLabel;
    asnew: TImage;
    asorig: TImage;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure XChange();
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  GaussianBlur;

procedure TForm1.Button1Click(Sender: TObject);
begin
  XChange();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if not openpictureDialog1.Execute then
    exit;
  asorig.Picture.LoadFromFile(OpenPictureDialog1.Filename);
  asnew.Picture.Assign(asorig.Picture);
end;

procedure TForm1.XChange();
var
  b: TBitmap;
  f: Double;
begin
  asnew.Picture.Assign(asorig.Picture);
  if not TryStrToFloat(Edit1.Text, f) then
    Exit;
  if f <= 0.0 then
    Exit;
  Screen.Cursor := crHourGlass;
  b := TBitmap.Create;
  try
    b.PixelFormat := pf24Bit;
    b.SetSize(asorig.Picture.Width, asorig.Picture.Height);
    b.Canvas.Draw(0, 0, asorig.Picture.Graphic);
    GBlur(b, f);
    asnew.Picture.Bitmap.Assign(b);
  finally
    b.Free;
    Screen.Cursor := crDefault;
  end;
end;

end.
