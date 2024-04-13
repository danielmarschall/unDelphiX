program Sparks;

uses
  Forms,
  Sparks1 in 'Sparks1.pas' {frmSpark};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSpark, frmSpark);
  Application.Run;
end.
