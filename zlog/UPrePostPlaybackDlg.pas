unit UPrePostPlaybackDlg;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TformPrePostPlaybackDlg = class(TForm)
    groupAudioInput: TGroupBox;
    radioInputDontCare: TRadioButton;
    radioInputMic: TRadioButton;
    radioInputUsb: TRadioButton;
    radioInputAcc: TRadioButton;
    radioInputMicUsb: TRadioButton;
    radioInputMicAcc: TRadioButton;
    groupCommand: TGroupBox;
    radioCommandNone: TRadioButton;
    radioCommand163: TRadioButton;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

implementation

{$R *.dfm}

end.
