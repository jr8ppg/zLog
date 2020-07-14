unit USelectUserDefinedContest;

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.FileCtrl, UserDefinedContest;

type
  TSelectUserDefinedContest = class(TForm)
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    editCfgFolder: TEdit;
    buttonCfgFolderRef: TButton;
    ListView1: TListView;
    checkImportProvCity: TCheckBox;
    checkImportCwMessage: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonCfgFolderRefClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1DblClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
  private
    { Private 宣言 }
    FCfgList: TUserDefinedContestList;
    FSelectedContest: TUserDefinedContest;
    function ScanCfgFiles(strFolder: string): TUserDefinedContestList;
    procedure ShowCfgFiles(L: TUserDefinedContestList);
    function GetCfgFolder(): string;
    procedure SetCfgFolder(v: string);
    function GetImportProvCity(): Boolean;
    function GetImportCwMessage(): Boolean;
  public
    { Public 宣言 }
    property CfgFolder: string read GetCfgFolder write SetCfgFolder;
    property SelectedContest: TUserDefinedContest read FSelectedContest;
    property ImportProvCity: Boolean read GetImportProvCity;
    property ImportCwMessage: Boolean read GetImportCwMessage;
  end;

implementation

{$R *.dfm}

procedure TSelectUserDefinedContest.FormCreate(Sender: TObject);
begin
   FCfgList := nil;
end;

procedure TSelectUserDefinedContest.FormDestroy(Sender: TObject);
begin
   FCfgList.Free();
end;

procedure TSelectUserDefinedContest.FormShow(Sender: TObject);
begin
   if editCfgFolder.Text = '' then begin
      Exit;
   end;

   if System.SysUtils.DirectoryExists(editCfgFolder.Text) = False then begin
      Exit;
   end;

   FCfgList.Free();
   FCfgList := ScanCfgFiles(editCfgFolder.Text);
   ShowCfgFiles(FCfgList);
end;

procedure TSelectUserDefinedContest.buttonOKClick(Sender: TObject);
begin
   FSelectedContest := TUserDefinedContest(ListView1.Selected.Data);
   ModalResult := mrOK;
end;

procedure TSelectUserDefinedContest.buttonCfgFolderRefClick(Sender: TObject);
var
   RootFolder: string;
   SelectFolder: string;
begin
   RootFolder := '';
   SelectFolder := '';

   if SelectDirectory('フォルダの指定', RootFolder, SelectFolder, [sdNewUI, sdNewFolder, sdShowEdit], Self)= False then begin
      Exit;
   end;

   editCfgFolder.Text := SelectFolder;

   FCfgList.Free();
   FCfgList := ScanCfgFiles(editCfgFolder.Text);
   ShowCfgFiles(FCfgList);
end;

procedure TSelectUserDefinedContest.ListView1DblClick(Sender: TObject);
begin
   buttonOK.Click();
end;

procedure TSelectUserDefinedContest.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
   buttonOK.Enabled := Selected;
end;

function TSelectUserDefinedContest.ScanCfgFiles(strFolder: string): TUserDefinedContestList;
var
   ret: Integer;
   F: TSearchRec;
   S: string;
   L: TUserDefinedContestList;
   D: TUserDefinedContest;
begin
   L := TUserDefinedContestList.Create();
   try
      if strFolder = '' then begin
         Exit;
      end;

      S := IncludeTrailingPathDelimiter(strFolder);

      ret := FindFirst(S + '*.CFG', faAnyFile, F);
      while ret = 0 do begin
         if ((F.Attr and faDirectory) = 0) and
            ((F.Attr and faVolumeID) = 0) and
            ((F.Attr and faSysFile) = 0) then begin

            D := TUserDefinedContest.Parse(S + F.Name);
            D.FileName := F.Name;
            D.Fullpath := S + F.Name;

            L.Add(D);
         end;

         // 次のファイル
         ret := FindNext(F);
      end;

      FindClose(F);
   finally
      Result := L;
   end;
end;

procedure TSelectUserDefinedContest.ShowCfgFiles(L: TUserDefinedContestList);
var
   i: Integer;
   listitem: TListItem;
   D: TUserDefinedContest;
begin
   ListView1.Items.BeginUpdate();

   ListView1.Items.Clear();
   for i := 0 to L.Count - 1 do begin
      D := L[i];
      listitem := ListView1.Items.Add();
      listitem.Caption := D.FileName;
      listitem.SubItems.Add(D.ContestName);
      listitem.SubItems.Add(D.Prov);
      listitem.SubItems.Add(D.City);
      listitem.SubItems.Add(D.FCwMessageA[1]);
      listitem.SubItems.Add(D.FCwMessageA[2]);
      listitem.SubItems.Add(D.FCwMessageA[3]);
      listitem.SubItems.Add(D.FCwMessageA[4]);
      listitem.Data := D;
   end;

   ListView1.Items.EndUpdate();
end;

function TSelectUserDefinedContest.GetCfgFolder(): string;
begin
   Result := editCfgFolder.Text;
end;

procedure TSelectUserDefinedContest.SetCfgFolder(v: string);
begin
   editCfgFolder.Text := v;
end;

function TSelectUserDefinedContest.GetImportProvCity(): Boolean;
begin
   Result := checkImportProvCity.Checked;
end;

function TSelectUserDefinedContest.GetImportCwMessage(): Boolean;
begin
   Result := checkImportCwMessage.Checked;
end;

end.
