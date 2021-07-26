unit UChat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, UzLogConst, UzLogGlobal;

type
  TChatForm = class(TForm)
    Panel1: TPanel;
    ListBox: TListBox;
    Edit: TEdit;
    Button1: TButton;
    Panel2: TPanel;
    checkPopup: TCheckBox;
    Button2: TButton;
    checkStayOnTop: TCheckBox;
    checkRecord: TCheckBox;
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure checkStayOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FChatFileName: string;
    procedure SendMessage;
    procedure Chat(S: string);
    procedure RecordChat(S: string);
  public
    { Public declarations }
    procedure Add(S : string);
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

procedure TChatForm.FormCreate(Sender: TObject);
begin
   Edit.Clear();
   ListBox.Clear();

   FChatFileName := StringReplace(Application.ExeName, '.exe', '_chat_' + FormatDateTime('yyyymmdd', Now) + '.txt', [rfReplaceAll]);
end;

procedure TChatForm.Add(S: string);
var
   _VisRows: integer;
   _TopRow: integer;
begin
   Chat(S);

   _VisRows := ListBox.ClientHeight div ListBox.ItemHeight;
   _TopRow := ListBox.Items.Count - _VisRows + 1;

   if _TopRow > 0 then
      ListBox.TopIndex := _TopRow
   else
      ListBox.TopIndex := 0;

   if checkPopup.Checked then begin
      Show;
   end;
end;

procedure TChatForm.SendMessage;
var
   t, str: string;
begin
   t := FormatDateTime('hh:nn ', SysUtils.Now);

   if (Length(Edit.Text) > 0) and (Edit.Text[1] = '\') then begin // raw command input
      str := Edit.Text;
      Chat(str);

      Delete(str, 1, 1);
      str := ZLinkHeader + ' ' + str;
      MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
      exit;
   end;

   if (Length(Edit.Text) > 0) and (Edit.Text[1] = '!') then begin // Red
      str := Edit.Text;
      Delete(str, 1, 1);

      str := ZLinkHeader + ' PUTMESSAGE !' + t + FillRight(Main.CurrentQSO.BandStr + 'MHz>', 9) + str;
      Add(Copy(str, Length(ZLinkHeader + ' PUTMESSAGE !') + 1, 255));

      MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
      exit;
   end;

   str := ZLinkHeader + ' PUTMESSAGE ' + t + FillRight(Main.CurrentQSO.BandStr + 'MHz>', 9) + Edit.Text;
   Add(Copy(str, Length(ZLinkHeader + ' PUTMESSAGE ') + 1, 255));

   MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
end;

procedure TChatForm.EditKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = Chr($0D) then begin
      SendMessage;
      Edit.Clear;
      Key := #0;
   end;
end;

procedure TChatForm.Button1Click(Sender: TObject);
begin
   Close;
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

end.
