unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DIB, StdCtrls, ExtCtrls, ComCtrls, ToolWin, Menus, Buttons, ImgList, CheckLst,
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
    sep3: TToolButton;
    AddMIDI: TToolButton;
    sep1: TToolButton;
    sep7: TToolButton;
    Info: TToolButton;
    CheckAll: TToolButton;
    sep8: TToolButton;
    PropBar: TToolBar;
    PlayWav: TToolButton;
    MidiListBox: TCheckListBox;
    New: TToolButton;
    sep2: TToolButton;
      Name: TEdit;
    ToolButton1: TToolButton;
    UpdateName: TToolButton;
    Panel1: TPanel;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Label2: TLabel;
    DXSound1: TDXSound;
    StopMusic: TToolButton;
    ImageList1: TImageList;
    DXMusic1: TDXMusic;
    ListBox1: TListBox;
    procedure OpenButtonClick(Sender: TObject);
    procedure MidiListBoxClick(Sender: TObject);
    procedure PlayWavClick(Sender: TObject);
    procedure AddMIDIClick(Sender: TObject);
    procedure CheckAllClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure NewClick(Sender: TObject);
    procedure UpdateNameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InfoClick(Sender: TObject);
    procedure StopMusicClick(Sender: TObject);
    procedure ImageDelClick(Sender: TObject);
    procedure ImageDownClick(Sender: TObject);
    procedure ImageUpClick(Sender: TObject);
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
    MidiListBox.Items.Clear;
    DXMusic1.Midis.Clear;
    DXMusic1.Midis.LoadFromFile(OpenDialog.filename);
    for loop := 0 to DXMusic1.Midis.Count - 1 do
      MidiListBox.Items.Add(DXMusic1.Midis.items[loop].Name);
  end;
end;

procedure TMain.MidiListBoxClick(Sender: TObject);
var i: integer;
begin
  if MidiListBox.Itemindex = -1 then exit;
  try
    if CurrentSnd <> '' then StopMusic.Click;
  except
  end;
  CurrentSnd := '';
  i := MidiListBox.itemindex {+ 1};
  Label1.Caption := DXMusic1.Midis.items[i].name;
  Name.Text := DXMusic1.Midis.Items[i].Name;
  StatusBar.Panels[0].Text := 'MIDI Info: ' +
    ' Size: ' + IntToStr(DXMusic1.Midis.Items[i].Size) {+
    ' Duration: ' + IntToStr(DXMusic1.Midis.Items[i].Duration)}; // TODO: Why is duration always 0?
end;

procedure TMain.PlayWavClick(Sender: TObject);
begin
  If Label1.Caption <> '' Then
  Begin
    CurrentSnd := Label1.Caption;
    DXMusic1.Midis.Find(CurrentSnd).Play;
  End;
end;

procedure TMain.AddMIDIClick(Sender: TObject);
var i, loop: integer;
begin
  if OpenDialog1.Execute then
  begin
    i := DXMusic1.Midis.Add.Index;
    DXMusic1.Midis.Items[i].LoadFromFile(OpenDialog1.Filename);
    DXMusic1.Midis.Items[i].Name := ExtractFileName(ChangeFileExt(OpenDialog1.Filename, ''));
    MidiListBox.Items.Clear;
    for loop := 0 to DXMusic1.Midis.Count - 1 do
      MidiListBox.Items.Add(DXMusic1.Midis.items[loop].Name);
    MidiListBox.itemindex := i;
    MidiListBoxClick(MidiListBox);
  end;
end;

procedure TMain.CheckAllClick(Sender: TObject);
var loop: integer;
begin
  for loop := 0 to MidiListBox.Items.Count - 1 do
    MidiListBox.Checked[loop] := True;
end;

procedure TMain.SaveButtonClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    DXMusic1.Midis.SaveToFile(SaveDialog.filename);
  end;
end;

procedure TMain.NewClick(Sender: TObject);
begin
  if CurrentSnd <> '' then StopMusic.Click;
  Label1.Caption := '...';
  MidiListBox.Items.Clear;
  DXMusic1.Midis.Clear;
end;

procedure TMain.UpdateNameClick(Sender: TObject);
var i, loop: integer;
begin
  if MidiListBox.Itemindex = -1 then exit;
  i := MidiListBox.itemindex {+ 1};
  if CurrentSnd = DXMusic1.Midis.Items[i].Name then CurrentSnd := Name.Text;
  DXMusic1.Midis.Items[i].Name := Name.Text;
  Label1.Caption := Name.Text;
  MidiListBox.Items.Clear;
  for loop := 0 to DXMusic1.Midis.Count - 1 do
    MidiListBox.Items.Add(DXMusic1.Midis.items[loop].Name);
  MidiListBox.itemindex := i;
end;

procedure TMain.FormCreate(Sender: TObject);
var loop: Integer;
begin
  If ParamCount > 0 Then
  Begin
    MidiListBox.Items.Clear;
    DXMusic1.Midis.Clear;
    DXMusic1.Midis.LoadFromFile(ParamStr(1));
    for loop := 0 to DXMusic1.Midis.Count - 1 do
      MidiListBox.Items.Add(DXMusic1.Midis.items[loop].Name);
  End;
  CurrentSnd := '';
end;

procedure TMain.ImageDelClick(Sender: TObject);
var i, loop: Integer;
begin
  StopMusic.Click;
  i := MidiListBox.itemindex;
  if i = -1 then exit;
  DXMusic1.Midis.Delete(i);
  MidiListBox.Items.Clear;
  for loop := 0 to DXMusic1.Midis.Count - 1 do
    MidiListBox.Items.Add(DXMusic1.Midis.items[loop].Name);
end;

procedure TMain.ImageDownClick(Sender: TObject);
var
  i: Integer;
begin
  i := MidiListBox.itemindex;
  if i = -1 then exit;
  if dxMusic1.Midis.Items[i].Index = dxMusic1.Midis.Count-1 then exit; // already at the end
  dxMusic1.Midis.Items[i].Index := dxMusic1.Midis.Items[i].Index + 1; // move down
  MidiListBox.Items.Exchange(i, i+1);
end;

procedure TMain.ImageUpClick(Sender: TObject);
var
  i: Integer;
begin
  i := MidiListBox.itemindex;
  if i = -1 then exit;
  if dxMusic1.Midis.Items[i].Index = 0 then exit; // already at the top
  dxMusic1.Midis.Items[i].Index := dxMusic1.Midis.Items[i].Index - 1; // move up
  MidiListBox.Items.Exchange(i, i-1);
end;

procedure TMain.InfoClick(Sender: TObject);
begin
  ShowMessage('Simple DXM editor v 1.0 (derived from DXW).');
end;

procedure TMain.StopMusicClick(Sender: TObject);
begin
  If CurrentSnd <> '' Then
    DXMusic1.Midis.Find(CurrentSnd).Stop;
  CurrentSnd := '';
end;

end.

