unit UZServerInquiry;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UzLogGlobal;

type
  TZServerInquiry = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    rbDownload: TRadioButton;
    rbMerge: TRadioButton;
    rbConnectOnly: TRadioButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  Main, UZLinkForm;

{$R *.DFM}

procedure TZServerInquiry.Button2Click(Sender: TObject);
begin
   Close;
end;

procedure TZServerInquiry.Button1Click(Sender: TObject);
begin
   if rbMerge.Checked then begin
      MainForm.ZLinkForm.MergeLogWithZServer;
   end;
   if rbDownload.Checked then begin
      MainForm.ZLinkForm.LoadLogFromZLink;
   end;
   Close;
end;

procedure TZServerInquiry.FormShow(Sender: TObject);
begin
   if Log.TotalQSO = 0 then begin
      rbConnectOnly.Checked := False;
      rbMerge.Checked := False;
      rbDownload.Checked := True;
   end
   else begin
      rbConnectOnly.Checked := False;
      rbMerge.Checked := True;
      rbDownload.Checked := False;
   end;
end;

end.
