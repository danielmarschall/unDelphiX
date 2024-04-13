program ColorLines;

uses
  Forms,
  ScreenColorLines in 'ScreenColorLines.pas' {FormColorLines};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormColorLines, FormColorLines);
  Application.Run;
end.
