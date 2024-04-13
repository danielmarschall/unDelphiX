program DXParticle_Spark;

uses
  Forms,
  DXSparkForm in 'DXSparkForm.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'DX RotoZoom';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
