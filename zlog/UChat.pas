unit UChat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal, HelperLib;

type
  TChatForm = class(TForm)
    Panel1: TPanel;
    ListBox: TListBox;
    editMessage: TEdit;
    buttonSend: TButton;
    Panel2: TPanel;
    checkPopup: TCheckBox;
    Button2: TButton;
    checkStayOnTop: TCheckBox;
    checkRecord: TCheckBox;
    comboPromptType: TComboBox;
    procedure editMessageKeyPress(Sender: TObject; var Key: Char);
    procedure buttonSendClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure checkStayOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormShow(Sender: TObject);
    procedure editMessageEnter(Sender: TObject);
    procedure editMessageExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FChatFileName: string;
    procedure SendMessage(S: string);
    procedure Chat(S: string);
    procedure RecordChat(S: string);
    function GetPrompt(): string;
  public
    { Public declarations }
    procedure Add(S : string);
    procedure SetConnectStatus(fConnected: Boolean);
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TChatForm.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TChatForm.FormActivate(Sender: TObject);
begin
   if editMessage.Enabled = True then begin
      editMessage.SetFocus();
   end;
end;

procedure TChatForm.FormCreate(Sender: TObject);
begin
   editMessage.Clear();
   ListBox.Clear();
   SetConnectStatus(False);

   FChatFileName := StringReplace(Application.ExeName, '.exe', '_chat_' + FormatDateTime('yyyymmdd', Now) + '.txt', [rfReplaceAll]);
end;

procedure TChatForm.Add(S: string);
begin
   Chat(S);

   ListBox.ShowLast();

   if checkPopup.Checked then begin
      Show;
   end;
end;

procedure TChatForm.SendMessage(S: string);
var
   t, str: string;
   strMessage: string;
begin
   if (Length(S) = 0) then begin
      Exit;
   end;

   t := FormatDateTime('hh:nn ', SysUtils.Now);

   if (S[1] = '\') then begin // raw command input
      str := S;
      Chat(str);

      Delete(str, 1, 1);
      str := ZLinkHeader + ' ' + str;
      MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
      Exit;
   end;

   if (S[1] = '!') then begin // Red
      str := S;
      Delete(str, 1, 1);

      strMessage := t + GetPrompt() + str;
      str := ZLinkHeader + ' PUTMESSAGE !' + strMessage;
      Add(strMessage);

      MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
      Exit;
   end;

   strMessage := t + GetPrompt() + S;
   str := ZLinkHeader + ' PUTMESSAGE ' + strMessage;
   Add(strMessage);

   MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
end;

procedure TChatForm.editMessageEnter(Sender: TObject);
begin
   buttonSend.Default := True;
end;

procedure TChatForm.editMessageExit(Sender: TObject);
begin
   buttonSend.Default := False;
end;

procedure TChatForm.editMessageKeyPress(Sender: TObject; var Key: Char);
begin
//
end;

procedure TChatForm.buttonSendClick(Sender: TObject);
begin
   SendMessage(editMessage.Text);
   editMessage.Clear();
   editMessage.SetFocus();
end;

procedure TChatForm.Button2Click(Sender: TObject);
begin
   ListBox.Clear;
end;

procedure TChatForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

procedure TChatForm.FormShow(Sender: TObject);
begin
   if FileExists(FChatFileName) = True then begin
      ListBox.Items.LoadFromFile(FChatFileName);
      ListBox.ShowLast();
   end;
end;

procedure TChatForm.checkStayOnTopClick(Sender: TObject);
begin
   if checkStayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TChatForm.Chat(S: string);
begin
   ListBox.Items.Add(S);

   if checkRecord.Checked = True then begin
      RecordChat(S);
   end;
end;

procedure TChatForm.RecordChat(S: string);
var
   F: TextFile;
begin
   AssignFile(F, FChatFileName);

   if FileExists(FChatFileName) = True then begin
      Append(F);
   end
   else begin
      Rewrite(F);
   end;

   WriteLn(F, S);

   CloseFile(F);
end;

procedure TChatForm.SetConnectStatus(fConnected: Boolean);
begin
   editMessage.Enabled := fConnected;
   if fConnected = True then begin
      editMessage.Color := clWindow;
      buttonSend.Enabled := True;
   end
   else begin
      editMessage.Color := clBtnFace;
      buttonSend.Enabled := False;
   end;
end;

function TChatForm.GetPrompt(): string;
var
   strPrompt: string;
begin
   case comboPromptType.ItemIndex of
      // Band
      0: begin
         strPrompt := Main.CurrentQSO.BandStr;  // + 'MHz';
      end;

      // PCNAME
      1: begin
         strPrompt := dmZLogGlobal.Settings._pcname;
      end;

      // OPNAME
      2: begin
         if Main.CurrentQSO.Operator = '' then begin
            strPrompt := dmZLogGlobal.Settings._mycall;
         end
         else begin
            strPrompt := Main.CurrentQSO.Operator;
         end;
      end;

      // CALL
      3: begin
         strPrompt := dmZLogGlobal.Settings._mycall;
      end;

      else begin
         strPrompt := Main.CurrentQSO.BandStr;  // + 'MHz';
      end;
   end;

   Result := FillLeft(strPrompt + '> ', 10);
end;

end.
