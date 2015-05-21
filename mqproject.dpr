program mqproject;

uses
  Vcl.Forms,
  mqunit in 'mqunit.pas' {fMQ};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMQ, fMQ);
  Application.Run;
end.
