program DIB_effect;

uses
  Forms,
  DIB_effect1 in 'DIB_effect1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
