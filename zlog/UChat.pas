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
    CheckBox: TCheckBox;
    Button2: TButton;
    cbStayOnTop: TCheckBox;
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbStayOnTopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    PrevIMEMode : integer;
  public
    PCNameSet : boolean;
    function IDString : string; // MHz > or PCname >
    procedure SendMessage;
    procedure Add(S : string);
    { Public declarations }
  end;

implementation

uses Main, UZLinkForm, UOptions;

{$R *.DFM}

function TChatForm.IDString: string;
begin
   if PCNameSet then
      Result := FillRight(dmZlogGlobal.Settings._pcname + '>', 9)
   else
      Result := FillRight(Main.CurrentQSO.BandStr + 'MHz>', 9);
end;

procedure TChatForm.Add(S: string);
var
   _VisRows: integer;
   _TopRow: integer;
begin
   ListBox.Items.Add(S);
   _VisRows := ListBox.ClientHeight div ListBox.ItemHeight;
   _TopRow := ListBox.Items.Count - _VisRows + 1;

   if _TopRow > 0 then
      ListBox.TopIndex := _TopRow
   else
      ListBox.TopIndex := 0;

   if CheckBox.Checked then
      Show;
   // BringToFront;
end;

procedure TChatForm.SendMessage;
var
   t, str: string;
begin
   t := FormatDateTime('hh:nn ', SysUtils.Now);

   if (Length(Edit.Text) > 0) and (Edit.Text[1] = '\') then begin // raw command input
      str := Edit.Text;
      ListBox.Items.Add(str);
      Delete(str, 1, 1);
      str := ZLinkHeader + ' ' + str;
      MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
      exit;
   end;

   if (Length(Edit.Text) > 0) and (Edit.Text[1] = '!') then begin // Red
      str := Edit.Text;
      // ListBox.Items.Add(str);
      Delete(str, 1, 1);
      str := ZLinkHeader + ' PUTMESSAGE !' + t + FillRight(Main.CurrentQSO.BandStr + 'MHz>', 9) + str;
      Add(Copy(str, Length(ZLinkHeader + ' PUTMESSAGE !') + 1, 255));
      MainForm.ZLinkForm.WriteData(str + LineBreakCode[ord(MainForm.ZLinkForm.Console.LineBreak)]);
      exit;
   end;

   str := ZLinkHeader + ' PUTMESSAGE ' + t + FillRight(Main.CurrentQSO.BandStr + 'MHz>', 9) + Edit.Text;
   // ListBox.Items.Add(Copy(str, length(ZLinkHeader+' PUTMESSAGE ')+1, 255));
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

procedure TChatForm.cbStayOnTopClick(Sender: TObject);
begin
   if cbStayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

procedure TChatForm.FormCreate(Sender: TObject);
begin
   PrevIMEMode := ord(imClose);
   PCNameSet := False;
end;

procedure TChatForm.FormDeactivate(Sender: TObject);
begin
   PrevIMEMode := ord(Edit.ImeMode);
end;

procedure TChatForm.FormActivate(Sender: TObject);
begin
   Edit.ImeMode := TIMEMode(PrevIMEMode);
   // Edit.SetIme;
end;

end.
