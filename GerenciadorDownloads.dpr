program GerenciadorDownloads;

uses
  Vcl.Forms,
  GerenciadorDownlods in 'GerenciadorDownlods.pas' {frmGerenciadorDownloads},
  dmGerenciadorDownloads in 'dmGerenciadorDownloads.pas' {dmdGerenciadorDownloads: TDataModule},
  blGerenciadorDownloads in 'blGerenciadorDownloads.pas',
  dlgHistoricoDownloads in 'dlgHistoricoDownloads.pas' {frmHistoricoDownloads};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGerenciadorDownloads, frmGerenciadorDownloads);
  Application.CreateForm(TdmdGerenciadorDownloads, dmdGerenciadorDownloads);
  Application.Run;
end.
