unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DIB, StdCtrls, ExtCtrls, ComCtrls, ToolWin, Menus, Buttons, ImgList,
  Spin, ExtDlgs, DXSounds, System.ImageList;

type
  TMain = class(TForm)
    Splitter1: TSplitter;
    ItemPanel: TPanel;
    Splitter2: TSplitter;
    PicturePanel: TPanel;
    MainControlBar: TControlBar;
    MainToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StatusBar: TStatusBar;
    ImageBar: TToolBar;
    ImageDel: TToolButton;
    ImageDown: TToolButton;
    ImageUp: TToolButton;
    AddWAV: TToolButton;
    sep1: TToolButton;
    sep7: TToolButton;
    Info: TToolButton;
    sep8: TToolButton;
    PropBar: TToolBar;
    PlayWav: TToolButton;
    WaveListBox: TListBox;
    New: TToolButton;
    sep2: TToolButton;
      Name: TEdit;
    ToolButton1: TToolButton;
    UpdateName: TToolButton;
    DXWaveList: TDXWaveList;
    Panel1: TPanel;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    DXSound1: TDXSound;
    StopMusic: TToolButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    SaveDialog1: TSaveDialog;
    procedure OpenButtonClick(Sender: TObject);
    procedure WaveListBoxClick(Sender: TObject);
    procedure PlayWavClick(Sender: TObject);
    procedure AddWAVClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure UpdateNameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure StopMusicClick(Sender: TObject);
    procedure ImageDownClick(Sender: TObject);
    procedure ImageUpClick(Sender: TObject);
    procedure ImageDelClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Private declarations }
    CurrentSnd:String;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.DFM}

procedure TMain.OpenButtonClick(Sender: TObject);
var loop: integer;
begin
  if OpenDialog.Execute then
  begin
    if CurrentSnd <> '' then StopMusic.Click;
    Label1.Caption := '...';
    WaveListBox.Items.Clear;
    DXWaveList.Items.Clear;
    DXWaveList.Items.LoadFromFile(OpenDialog.filename);
    for loop := 0 to DXWaveList.Items.Count - 1 do
      WaveListBox.Items.Add(DXWaveList.items[loop].Name);
  end;
end;

procedure TMain.WaveListBoxClick(Sender: TObject);
var i: integer;
begin
  if WaveListBox.Itemindex = -1 then exit;
  try
    if CurrentSnd <> '' then StopMusic.Click;
  except
  end;
  CurrentSnd := '';
  i := WaveListBox.itemindex {+ 1};
  Label1.Caption := DXWaveList.items[i].name;
  Name.Text := DXWaveList.Items[i].Name;
  StatusBar.Panels[0].Text := 'Wave Info: ' +
    ' Size: ' + IntToStr(DXWaveList.Items[i].Wave.Size) +
    ' Format: ' + IntToStr(DXWaveList.Items[i].Wave.FormatSize);
end;

procedure TMain.PlayWavClick(Sender: TObject);
begin
  If Label1.Caption <> '' Then
  Begin
    CurrentSnd := Label1.Caption;
    DXWaveList.Items.Find(CurrentSnd).Play(False);
  End;
end;

procedure TMain.AddWAVClick(Sender: TObject);
var i, loop: integer;
begin
  if OpenDialog1.Execute then
  begin
    i := DXWaveList.Items.Add.Index;
    DXWaveList.Items[i].Wave.LoadFromFile(OpenDialog1.Filename);
    DXWaveList.Items[i].Name := ExtractFileName(ChangeFileExt(OpenDialog1.Filename, ''));
    DXWaveList.Items[i].Restore;
    WaveListBox.Items.Clear;
    for loop := 0 to DXWaveList.Items.Count - 1 do
      WaveListBox.Items.Add(DXWaveList.items[loop].Name);
    WaveListBox.itemindex := i;
    WaveListBoxClick(WaveListBox);
  end;
end;

procedure TMain.SaveButtonClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    DXWaveList.Items.SaveToFile(SaveDialog.filename);
  end;
end;

procedure TMain.NewClick(Sender: TObject);
begin
  if CurrentSnd <> '' then StopMusic.Click;
  Label1.Caption := '...';
  WaveListBox.Items.Clear;
  DXWaveList.Items.Clear;
end;

procedure TMain.UpdateNameClick(Sender: TObject);
var i, loop: integer;
begin
  if WaveListBox.Itemindex = -1 then exit;
  i := WaveListBox.itemindex {+ 1};
  if CurrentSnd = DXWaveList.Items[i].Name then CurrentSnd := Name.Text;
  DXWaveList.Items[i].Name := Name.Text;
  Label1.Caption := Name.Text;
  DXWaveList.Items[i].Restore;
  WaveListBox.Items.Clear;
  for loop := 0 to DXWaveList.Items.Count - 1 do
    WaveListBox.Items.Add(DXWaveList.items[loop].Name);
  WaveListBox.itemindex := i;
end;

procedure TMain.FormCreate(Sender: TObject);
var loop: Integer;
begin
  If ParamCount > 0 Then
  Begin
    WaveListBox.Items.Clear;
    DXWaveList.Items.Clear;
    DXWaveList.Items.LoadFromFile(ParamStr(1));
    for loop := 0 to DXWaveList.Items.Count - 1 do
      WaveListBox.Items.Add(DXWaveList.items[loop].Name);
  End;
  CurrentSnd := '';
end;

procedure TMain.ImageDelClick(Sender: TObject);
var
  loop, i: Integer;
begin
  StopMusic.Click;
  i := WaveListBox.itemindex;
  if i = -1 then exit;
  DXWaveList.Items.Delete(i);
  WaveListBox.Items.Clear;
  for loop := 0 to DXWaveList.Items.Count - 1 do
    WaveListBox.Items.Add(DXWaveList.Items.items[loop].Name);
end;

procedure TMain.ImageDownClick(Sender: TObject);
var
  i: Integer;
begin
  i := WaveListBox.itemindex;
  if i = -1 then exit;
  if DXWaveList.Items.Items[i].Index = DXWaveList.Items.Count-1 then exit; // already at the end
  DXWaveList.Items.Items[i].Index := DXWaveList.Items.Items[i].Index + 1; // move down
  WaveListBox.Items.Exchange(i, i+1);
end;

procedure TMain.ImageUpClick(Sender: TObject);
var
  i: Integer;
begin
  i := WaveListBox.itemindex;
  if i = -1 then exit;
  if DXWaveList.Items.Items[i].Index = 0 then exit; // already at the top
  DXWaveList.Items.Items[i].Index := DXWaveList.Items.Items[i].Index - 1; // move up
  WaveListBox.Items.Exchange(i, i-1);
end;

procedure TMain.InfoClick(Sender: TObject);
begin
  ShowMessage('Simple DXW editor v 1.0 (derived from DXG).');
end;

procedure TMain.StopMusicClick(Sender: TObject);
begin
  If CurrentSnd <> '' Then
    DXWaveList.Items.Find(CurrentSnd).Stop;
  CurrentSnd := '';
end;

procedure TMain.ToolButton2Click(Sender: TObject);
var
  i: Integer;
begin
  if WaveListBox.Itemindex = -1 then exit;
  if SaveDialog1.Execute then
  begin
    i := WaveListBox.itemindex;
    DXWaveList.Items[i].Wave.SaveToFile(SaveDialog1.Filename);
  end;
end;

end.

