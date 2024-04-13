program Gummi;

uses
  Forms,
  Gummi1 in 'Gummi1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
