unit UCWKeyBoard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ClipBrd,
  UzLogConst, UzLogGlobal, UzLogQSO, UzLogCW, UzLogKeyer;

type
  TCWKeyBoard = class(TForm)
    Console: TMemo;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure ConsoleKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ConsoleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CWKeyBoard: TCWKeyBoard;

implementation

uses Main, UOptions;

{$R *.DFM}
procedure TCWKeyBoard.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;


procedure TCWKeyBoard.ConsoleKeyPress(Sender: TObject; var Key: Char);
var K : Char;
begin
  if Key = Chr($1B) then
    exit;

  if Key = Chr($08) then
    dmZLogKeyer.CancelLastChar
  else
    begin
      if HiWord(GetKeyState(VK_SHIFT))<>0 then
        K := LowCase(Key)
      else
        K := UpCase(Key);
      dmZLogKeyer.SetCWSendBufCharPTT(K);
      Key := K;
    end;
end;

procedure TCWKeyBoard.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE :
      begin
        dmZLogKeyer.ControlPTT(False);
        MainForm.LastFocus.SetFocus;
      end;
  end;
end;


procedure TCWKeyBoard.OKClick(Sender: TObject);
begin
  Close;
  MainForm.LastFocus.SetFocus;
end;

procedure TCWKeyBoard.FormShow(Sender: TObject);
begin
  Console.SetFocus;
end;

procedure TCWKeyBoard.ConsoleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i : integer;
    S : string;
begin
  case Key of
    VK_ESCAPE :
      begin
        if dmZLogKeyer.IsPlaying then
          begin
            dmZLogKeyer.ClrBuffer;
            dmZLogKeyer.ControlPTT(False);
          end
        else
          begin
            dmZLogKeyer.ControlPTT(False);
            MainForm.SetFocus;
            //Caption := 'CODE 2';
         end;
      end;
    VK_F1..VK_F8 :
      begin
        i := Key - VK_F1 + 1;
        S := dmZlogGlobal.CWMessage(dmZlogGlobal.Settings.CW.CurrentBank,i);
        S := SetStr(S, Main.CurrentQSO);
        zLogSendStr(S);

        while Pos(':***********',S) > 0 do
          begin
            i := Pos(':***********',S);
            Delete(S, i, 12);
            Insert(CurrentQSO.Callsign, S, i);
          end;
        ClipBoard.AsText := S;
        Console.PasteFromClipBoard;
      end;
  end;
end;

procedure TCWKeyBoard.Button2Click(Sender: TObject);
begin
  Console.Clear;
end;

end.
