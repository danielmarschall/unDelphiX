program GaussBlur;

uses
  Forms,
  GaussianBlur1 in 'GaussianBlur1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
