unit UCwMessagePad;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.CategoryButtons,
  Vcl.ExtDlgs, HelperLib;

type
  TCwMessagePad = class(TForm)
    CategoryButtons1: TCategoryButtons;
    PopupMenu1: TPopupMenu;
    menuLoadFromFile: TMenuItem;
    menuSaveToFile: TMenuItem;
    N1: TMenuItem;
    menuEdit: TMenuItem;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    procedure menuSaveToFileClick(Sender: TObject);
    procedure menuLoadFromFileClick(Sender: TObject);
    procedure CategoryButtons1ButtonClicked(Sender: TObject; const Button: TButtonItem);
    procedure menuEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

implementation

uses
  UCwMessageEditor, Main, UzLogCW;

{$R *.dfm}

procedure TCwMessagePad.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TCwMessagePad.FormCreate(Sender: TObject);
var
   filename: string;
   encodings: TStrings;
begin
   encodings := TStringList.Create();
   try
      encodings.AddObject('ASCII', TEncoding.ANSI);
      OpenTextFileDialog1.Encodings.Assign(encodings);
      SaveTextFileDialog1.Encodings.Assign(encodings);

      filename := ExtractFilePath(Application.ExeName) + 'cwmessage.txt';
      if FileExists(filename) = False then begin
         Exit;
      end;

      CategoryButtons1.LoadFromFile(filename, TEncoding.ANSI);
   finally
      encodings.Free();
   end;
end;

procedure TCwMessagePad.FormDestroy(Sender: TObject);
var
   filename: string;
begin
   filename := ExtractFilePath(Application.ExeName) + 'cwmessage.txt';
   CategoryButtons1.SaveToFile(filename, TEncoding.ANSI);
end;

procedure TCwMessagePad.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE: begin
         MainForm.LastFocus.SetFocus;
      end;
   end;
end;

procedure TCwMessagePad.FormShow(Sender: TObject);
begin
   CategoryButtons1.UpdateAllButtons();
end;

procedure TCwMessagePad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TCwMessagePad.menuLoadFromFileClick(Sender: TObject);
var
   filename: string;
   Index: Integer;
   encoding: TEncoding;
begin
   if OpenTextFileDialog1.Execute() = False then begin
      Exit;
   end;

   Index := OpenTextFileDialog1.EncodingIndex;
   encoding := TEncoding(OpenTextFileDialog1.Encodings.Objects[Index]);

   filename := OpenTextFileDialog1.FileName;

   CategoryButtons1.Categories.Clear();
   CategoryButtons1.LoadFromFile(filename, encoding);
end;

procedure TCwMessagePad.menuSaveToFileClick(Sender: TObject);
var
   filename: string;
   Index: Integer;
   encoding: TEncoding;
begin
   if SaveTextFileDialog1.Execute() = False then begin
      Exit;
   end;

   Index := SaveTextFileDialog1.EncodingIndex;
   encoding := TEncoding(SaveTextFileDialog1.Encodings.Objects[Index]);

   filename := SaveTextFileDialog1.FileName;

   CategoryButtons1.SaveToFile(filename, encoding);
end;

procedure TCwMessagePad.menuEditClick(Sender: TObject);
var
   editor: TCwMessageEditor;
   L: TStringList;
begin
   L := TStringList.Create();
   editor := TCwMessageEditor.Create(Self);
   try
      CategoryButtons1.SaveToText(L);
      editor.Text := L.Text;
      if editor.ShowModal() <> mrOK then begin
         Exit;
      end;
      L.Text := editor.Text;
      CategoryButtons1.LoadFromText(L);
   finally
      editor.Release();
      L.Free();
   end;
end;

procedure TCwMessagePad.CategoryButtons1ButtonClicked(Sender: TObject; const Button: TButtonItem);
var
   S: string;
   i: Integer;
begin
   // Fire!
   {$IFDEF DEBUG}
   OutputDebugString(PChar(Button.Caption));
   {$ENDIF}

   S := Button.Caption;
   S := SetStr(S, CurrentQSO);
   zLogSendStr(S);

   while Pos(':***********', S) > 0 do begin
      i := Pos(':***********', S);
      Delete(S, i, 12);
      Insert(CurrentQSO.Callsign, S, i);
   end;

   MainForm.LastFocus.SetFocus;
end;

end.
