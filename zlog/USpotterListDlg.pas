unit USpotterListDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TformSpotterListDlg = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    Panel2: TPanel;
    listAllow: TListBox;
    listDeny: TListBox;
    buttonAddToAllowList: TButton;
    buttonRemoveFromAllowList: TButton;
    comboSpoter: TComboBox;
    buttonAddToDenyList: TButton;
    buttonRemoveFromDenyList: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;


implementation

{$R *.dfm}

end.
