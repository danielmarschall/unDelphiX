program DxSmallEffects;

uses
  Forms,
  DxSmallEffects1 in 'DxSmallEffects1.pas' {frmDxEffect};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDxEffect, frmDxEffect);
  Application.Run;
end.
