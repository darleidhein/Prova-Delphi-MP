unit dlgHistoricoDownloads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, dmGerenciadorDownloads, blGerenciadorDownloads;

type
  TfrmHistoricoDownloads = class(TForm, IObserver)
    dbgHistoricoDownloads: TDBGrid;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Atualizar(Progresso: TProgresso);
  end;

var
  frmHistoricoDownloads: TfrmHistoricoDownloads;

implementation

{$R *.dfm}

procedure TfrmHistoricoDownloads.Atualizar(Progresso: TProgresso);
begin
  if Progresso.Concluido then
    dmdGerenciadorDownloads.AbrirHistoricoDownloadsGrid;
end;

procedure TfrmHistoricoDownloads.FormShow(Sender: TObject);
begin
  dmdGerenciadorDownloads.AbrirHistoricoDownloadsGrid;
end;

end.
