unit GerenciadorDownlods;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, blGerenciadorDownloads, dlgHistoricoDownloads;

type
  tpEstado = (eParado = 0, eBaixando = 1);

  TfrmGerenciadorDownloads = class(TForm, IObserver)
    pbProgresso: TProgressBar;
    btnDownload: TButton;
    btnIniciarDownload: TButton;
    edtLinkDownload: TEdit;
    lblLinkDownload: TLabel;
    btnHistoricoDownloads: TButton;
    sdArquivoDownload: TSaveDialog;
    procedure btnDownloadClick(Sender: TObject);
    procedure btnIniciarDownloadClick(Sender: TObject);
    procedure btnHistoricoDownloadsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FDownload: TDownload;
    FEstado: tpEstado;

    procedure ValidarPreenchimentoLink;
    procedure IniciarDownload;
    procedure PararDownload;
    procedure ExibirMensagem;
    procedure HistoricoDownloads;
    procedure SetEstadoAtual(NovoEstado: tpEstado);
    procedure ConfiguraSaveDialog;
    procedure ConfiguraEstadoComponentes;
  public
    { Public declarations }

    procedure Atualizar(Progresso: TProgresso);
  end;

var
  frmGerenciadorDownloads: TfrmGerenciadorDownloads;

implementation

{$R *.dfm}

procedure TfrmGerenciadorDownloads.Atualizar(Progresso: TProgresso);
begin
  pbProgresso.Max := Progresso.Maximo;
  pbProgresso.Position := Progresso.Posicao;

  if (Progresso.Concluido) and not (Progresso.PararDownload) then
  begin
    SetEstadoAtual(eParado);
    Application.MessageBox('Download realizado com sucesso!','Gerenciador de downloads', MB_OK + MB_ICONINFORMATION);
  end
  else
  begin
    if Progresso.Erro <> EmptyStr then
    begin
      SetEstadoAtual(eParado);
      Application.MessageBox(Pchar('Erro ao realizar o download do arquivo: '
        + Progresso.Erro), 'Gerenciador de downloads', MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TfrmGerenciadorDownloads.btnDownloadClick(Sender: TObject);
begin
  case FEstado of
    eParado:
    begin
      ValidarPreenchimentoLink;
      ConfiguraSaveDialog;
      IniciarDownload;
    end;

    eBaixando:
    begin
      PararDownload;
      SetEstadoAtual(eParado);
    end;
  end;
end;

procedure TfrmGerenciadorDownloads.btnHistoricoDownloadsClick(Sender: TObject);
begin
  HistoricoDownloads;
end;

procedure TfrmGerenciadorDownloads.btnIniciarDownloadClick(Sender: TObject);
begin
  ExibirMensagem;
end;

procedure TfrmGerenciadorDownloads.ConfiguraEstadoComponentes;
begin
  case FEstado of
    eParado:
    begin
      btnDownload.Caption := 'Iniciar download';
      edtLinkDownload.Enabled := True;
      pbProgresso.Position := 0;
    end;

    eBaixando:
    begin
      btnDownload.Caption := 'Parar download';
      edtLinkDownload.Enabled := False;
    end;
  end;
end;

procedure TfrmGerenciadorDownloads.ConfiguraSaveDialog;
var
 sExt: String;
begin
  sdArquivoDownload.FileName := ExtractFileName(StringReplace(edtLinkDownload.Text, '/', '\', [rfReplaceAll]));
  sExt := ExtractFileExt(edtLinkDownload.Text);
  sdArquivoDownload.Filter := sExt + ' |*' + sExt;
  sdArquivoDownload.FilterIndex := 1;
end;

procedure TfrmGerenciadorDownloads.ExibirMensagem;
begin
  Application.MessageBox(Pchar(FloatToStrf((pbProgresso.Position / pbProgresso.Max) * 100, ffNumber, 3, 2) + '%'),'Progresso', MB_OK);
end;

procedure TfrmGerenciadorDownloads.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if FEstado = eBaixando then
  begin
    CanClose := Application.MessageBox('Existe um download em andamento, deseja interrompe-lo?','Gerenciador de downloads', MB_YESNO + MB_ICONINFORMATION) = mrYes;

    if CanClose then
      PararDownload;
  end;

  if CanClose and Assigned(FDownload) then
    FDownload.Free;
end;

procedure TfrmGerenciadorDownloads.FormShow(Sender: TObject);
begin
  FDownload := TDownload.Create;
  SetEstadoAtual(eParado);
end;

procedure TfrmGerenciadorDownloads.HistoricoDownloads;
var
  oDlgHistoricoDownloads: TfrmHistoricoDownloads;
begin
  oDlgHistoricoDownloads := TfrmHistoricoDownloads.Create(self);

  try
    FDownload.AdicionarObserver(oDlgHistoricoDownloads);
    oDlgHistoricoDownloads.ShowModal;
  finally
    FDownload.RemoverObserver(oDlgHistoricoDownloads);
    FreeAndNil(oDlgHistoricoDownloads);
  end;
end;

procedure TfrmGerenciadorDownloads.IniciarDownload;
begin
  if sdArquivoDownload.Execute then
  begin
    SetEstadoAtual(eBaixando);

    if Assigned(FDownload) then
      FDownload.Free;

    FDownload := TDownload.Create;
    FDownload.AdicionarObserver(Self);
    FDownload.UrlDownload := edtLinkDownload.Text;
    FDownload.NomeArquivo := sdArquivoDownload.FileName;
    FDownload.Start;
  end;
end;

procedure TfrmGerenciadorDownloads.PararDownload;
begin
  FDownload.PararDownload;
  FDownload.WaitFor;
end;

procedure TfrmGerenciadorDownloads.SetEstadoAtual(NovoEstado: tpEstado);
begin
  FEstado := NovoEstado;
  ConfiguraEstadoComponentes;
end;

procedure TfrmGerenciadorDownloads.ValidarPreenchimentoLink;
begin
  if Trim(edtLinkDownload.Text) = EmptyStr then
    raise Exception.Create('Link para download não preenchido!');
end;

end.
