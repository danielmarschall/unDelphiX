program DXWire;

uses
  Forms,
  DXWire1 in 'DXWire1.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Confusion Demo';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
