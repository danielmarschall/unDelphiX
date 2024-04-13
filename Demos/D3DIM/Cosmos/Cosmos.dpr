program Cosmos;

uses
  Forms,
  Cosmos1 in 'Cosmos1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
