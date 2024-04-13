program VideoTex;

uses
  Forms,
  VideoTex1 in 'VideoTex1.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
