unit UCWMonitor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TformCWMonitor = class(TForm)
    Label1: TLabel;
    PaintBox1: TPaintBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private éŒ¾ }
    FSendText: string;
    FSendIndex: Integer;
  public
    { Public éŒ¾ }
    procedure SetSendingText(rigno: Integer; s: string);
    procedure ClearSendingText();
    procedure OneCharSentProc();
  end;

implementation

{$R *.dfm}

procedure TformCWMonitor.FormCreate(Sender: TObject);
begin
   FSendText := '';
   FSendIndex := 0;
end;

procedure TformCWMonitor.SetSendingText(rigno: Integer; s: string);
begin
//   editSendingNow.Text := '[' + IntToStr(rigno) + ']' + s;
   FSendText := s;
   FSendIndex := 1;
   PaintBox1.Refresh();
end;

procedure TformCWMonitor.ClearSendingText();
begin
   FSendText := '';
   FSendIndex := 1;
   PaintBox1.Refresh();
end;

procedure TformCWMonitor.OneCharSentProc();
begin
   Inc(FSendIndex);
   PaintBox1.Refresh();
end;

procedure TformCWMonitor.PaintBox1Paint(Sender: TObject);
var
   S: string;
   Rect: TRect;
begin
   with TPaintBox(Sender).Canvas do begin
      Rect.Top := 0;
      Rect.Bottom := TPaintBox(Sender).Height - 2;
      Rect.Left := 0;
      Rect.Right := TPaintBox(Sender).Width - 1;

      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      Pen.Color := clGray;
      Pen.Style := psSolid;
      FillRect(Rect);
      Rectangle(Rect);

      if FSendText = '' then begin
         Exit;
      end;

      Rect.Left := 2;
      Rect.Right := Rect.Right - 2;
      Font.Color := clBlack;
      TextRect(Rect, FSendText, [tfLeft, tfVerticalCenter, tfSingleLine]);

      if FSendIndex > 0 then begin
         S := Copy(FSendText, 1, FSendIndex);
         Brush.Color := clBlue;
         Brush.Style := bsSolid;
         Pen.Style := psClear;
         Font.Color := clWhite;
//         Font.style := Font.Style + [fsUnderline];
         TextRect(Rect, S, [tfLeft, tfVerticalCenter, tfSingleLine]);
      end;
   end;
end;

end.
