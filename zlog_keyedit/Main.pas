unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, System.IniFiles;

type
  TformMain = class(TForm)
    PageControl1: TPageControl;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    vleLogging: TValueListEditor;
    vleCWKeying: TValueListEditor;
    vleRigControl: TValueListEditor;
    vleInformation: TValueListEditor;
    vleEdit: TValueListEditor;
    vlePostContest: TValueListEditor;
    vleOther: TValueListEditor;
    procedure vleDblClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private 宣言 }
    function IsShortcutUsed(strKey: string; var strFuncName: string): Boolean;
    procedure ClearKeymap(strFuncName: string);
    procedure ReadKeymap(ini: TIniFile; vle: TValueListEditor);
    procedure WriteKeymap(ini: TIniFile; vle: TValueListEditor);
  public
    { Public 宣言 }
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

uses
  KeyEditDlg;

procedure TformMain.FormCreate(Sender: TObject);
var
   ini: TIniFile;
   filename: string;
begin
   PageControl1.ActivePageIndex := 0;

   filename := ExtractFilePath(Application.ExeName) + 'zlog_key.ini';
   if FileExists(filename) = False then begin
      Exit;
   end;

   ini := TIniFile.Create(filename);
   try
      ReadKeymap(ini, vleLogging);
      ReadKeymap(ini, vleInformation);
      ReadKeymap(ini, vleCwKeying);
      ReadKeymap(ini, vleRigControl);
      ReadKeymap(ini, vleEdit);
      ReadKeymap(ini, vlePostContest);
      ReadKeymap(ini, vleOther);
   finally
      ini.Free();
   end;
end;

procedure TformMain.vleDblClick(Sender: TObject);
var
   dlg: TformKeyEditDlg;
   R: Integer;
   strKey: string;
   strKeyBackup: string;
   strFuncName: string;
   slText: TStringList;
begin
   slText := TStringList.Create();
   dlg := TformKeyEditDlg.Create(Self);
   try
      R := TValueListEditor(Sender).Row;

      strKeyBackup := TValueListEditor(Sender).Cells[1, R];
      slText.CommaText := strKeyBackup + ',';

      TValueListEditor(Sender).Cells[1, R] := '';
      dlg.PrimaryKey := slText.Strings[0];
      dlg.SecondaryKey := slText.Strings[1];

      if dlg.ShowModal() <> mrOK then begin
         TValueListEditor(Sender).Cells[1, R] := strKeyBackup;
         Exit;
      end;

      strKey := dlg.PrimaryKey;

      if (strKey <> '') and (IsShortcutUsed(strKey, strFuncName) = True) then begin
         if MessageBox(Handle, PChar(strKey + ' キーは既に ' + strFuncName + ' で使用されています。横取りしますか？'), PChar(Application.Title), MB_YESNO or MB_DEFBUTTON2 or MB_ICONEXCLAMATION) = IDNO then begin
            TValueListEditor(Sender).Cells[1, R] := strKeyBackup;
            Exit;
         end;

         ClearKeymap(strFuncName);
      end;

      TValueListEditor(Sender).Cells[1, R] := strKey + ',' + dlg.SecondaryKey;
   finally
      dlg.Release();
      slText.Free();
   end;
end;

procedure TformMain.buttonOKClick(Sender: TObject);
var
   ini: TIniFile;
begin
   ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'zlog_key.ini');
   try
      WriteKeymap(ini, vleLogging);
      WriteKeymap(ini, vleInformation);
      WriteKeymap(ini, vleCwKeying);
      WriteKeymap(ini, vleRigControl);
      WriteKeymap(ini, vleEdit);
      WriteKeymap(ini, vlePostContest);
      WriteKeymap(ini, vleOther);

      Close();
   finally
      ini.Free();
   end;
end;

procedure TformMain.buttonCancelClick(Sender: TObject);
begin
   Close();
end;

function TformMain.IsShortcutUsed(strKey: string; var strFuncName: string): Boolean;
var
   i: Integer;
begin
   for i := 1 to vleLogging.RowCount - 1 do begin
      if vleLogging.Cells[1, i] = strKey then begin
         strFuncName := vleLogging.Cells[0, i];
         Result := True;
         Exit;
      end;
   end;

   for i := 1 to vleInformation.RowCount - 1 do begin
      if vleInformation.Cells[1, i] = strKey then begin
         strFuncName := vleInformation.Cells[0, i];
         Result := True;
         Exit;
      end;
   end;

   for i := 1 to vleCwKeying.RowCount - 1 do begin
      if vleCwKeying.Cells[1, i] = strKey then begin
         strFuncName := vleCwKeying.Cells[0, i];
         Result := True;
         Exit;
      end;
   end;

   for i := 1 to vleRigControl.RowCount - 1 do begin
      if vleRigControl.Cells[1, i] = strKey then begin
         strFuncName := vleRigControl.Cells[0, i];
         Result := True;
         Exit;
      end;
   end;

   for i := 1 to vleEdit.RowCount - 1 do begin
      if vleEdit.Cells[1, i] = strKey then begin
         strFuncName := vleEdit.Cells[0, i];
         Result := True;
         Exit;
      end;
   end;

   for i := 1 to vlePostContest.RowCount - 1 do begin
      if vlePostContest.Cells[1, i] = strKey then begin
         strFuncName := vlePostContest.Cells[0, i];
         Result := True;
         Exit;
      end;
   end;

   for i := 1 to vleOther.RowCount - 1 do begin
      if vleOther.Cells[1, i] = strKey then begin
         strFuncName := vleOther.Cells[0, i];
         Result := True;
         Exit;
      end;
   end;

   strFuncName := '';
   Result := False;
end;

procedure TformMain.ClearKeymap(strFuncName: string);
var
   i: Integer;
begin
   for i := 1 to vleLogging.RowCount - 1 do begin
      if vleLogging.Cells[0, i] = strFuncName then begin
         vleLogging.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleInformation.RowCount - 1 do begin
      if vleInformation.Cells[0, i] = strFuncName then begin
         vleInformation.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleCwKeying.RowCount - 1 do begin
      if vleCwKeying.Cells[0, i] = strFuncName then begin
         vleCwKeying.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleRigControl.RowCount - 1 do begin
      if vleRigControl.Cells[0, i] = strFuncName then begin
         vleRigControl.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleEdit.RowCount - 1 do begin
      if vleEdit.Cells[0, i] = strFuncName then begin
         vleEdit.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vlePostContest.RowCount - 1 do begin
      if vlePostContest.Cells[0, i] = strFuncName then begin
         vlePostContest.Cells[1, i] := '';
         Exit;
      end;
   end;

   for i := 1 to vleOther.RowCount - 1 do begin
      if vleOther.Cells[0, i] = strFuncName then begin
         vleOther.Cells[1, i] := '';
         Exit;
      end;
   end;
end;

procedure TformMain.ReadKeymap(ini: TIniFile; vle: TValueListEditor);
var
   i: Integer;
   N: Integer;
begin
   for i := 1 to vle.RowCount - 1 do begin
      N := StrToIntDef(Copy(vle.Cells[0, i], 2, 2), -1);
      if N = -1 then begin
         Continue;
      end;

      vle.Cells[1, i] := ini.ReadString('shortcut', IntToStr(N), '') + ',' + ini.ReadString('secondary', IntToStr(N), '');
   end;
end;

procedure TformMain.WriteKeymap(ini: TIniFile; vle: TValueListEditor);
var
   i: Integer;
   N: Integer;
   slText: TStringList;
begin
   slText := TStringList.Create();
   try
      for i := 1 to vle.RowCount - 1 do begin
         N := StrToIntDef(Copy(vle.Cells[0, i], 2, 2), -1);
         if N = -1 then begin
            Continue;
         end;

         slText.CommaText := vle.Cells[1, i] + ',';
         ini.WriteString('shortcut', IntToStr(N), slText[0]);
         ini.WriteString('secondary', IntToStr(N), slText[1]);
      end;
   finally
      slText.Free();
   end;
end;

end.
