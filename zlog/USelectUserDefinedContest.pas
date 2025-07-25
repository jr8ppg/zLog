unit USelectUserDefinedContest;

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.FileCtrl, UserDefinedContest;

const
  WM_ZLOG_SHOWCFGEDIT = (WM_USER + 301);

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
    checkImportCwMessage1: TCheckBox;
    checkImportCwMessage2: TCheckBox;
    checkImportCwMessage3: TCheckBox;
    checkImportCwMessage4: TCheckBox;
    buttonCFGEdit: TButton;
    checkImportCQMessage2: TCheckBox;
    checkImportCQMessage3: TCheckBox;
    editFilterText: TEdit;
    checkAllowTempChanges: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure buttonCfgFolderRefClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ListView1DblClick(Sender: TObject);
    procedure buttonOKClick(Sender: TObject);
    procedure buttonCFGEditClick(Sender: TObject);
    procedure ListView1MouseEnter(Sender: TObject);
    procedure OnZLogShowCfgEdit( var Message: TMessage ); message WM_ZLOG_SHOWCFGEDIT;
    procedure editFilterTextChange(Sender: TObject);
  private
    { Private 宣言 }
    FCfgList: TUserDefinedContestList;
    FSelectedContest: TUserDefinedContest;
    FInitialContestName: string;
    function ScanCfgFiles(strFolder: string): TUserDefinedContestList;
    procedure ShowCfgFiles(L: TUserDefinedContestList; strFilter: string);
    function GetCfgFolder(): string;
    procedure SetCfgFolder(v: string);
    function GetImportProvCity(): Boolean;
    function GetImportCwMessage(Index: Integer): Boolean;
    function GetImportCQMessage(Index: Integer): Boolean;
  public
    { Public 宣言 }
    property CfgFolder: string read GetCfgFolder write SetCfgFolder;
    property SelectedContest: TUserDefinedContest read FSelectedContest;
    property ImportProvCity: Boolean read GetImportProvCity;
    property ImportCwMessage[Index: Integer]: Boolean read GetImportCwMessage;
    property ImportCQMessage[Index: Integer]: Boolean read GetImportCQMessage;
    property InitialContestName: string read FInitialContestName write FInitialContestName;
  end;

resourcestring
  Setup_prov_first = 'Setup Prov/State code first';
  Setup_city_first = 'Setup City code first';

implementation

uses
  UCFGEdit, UzLogGlobal;

{$R *.dfm}

procedure TSelectUserDefinedContest.FormCreate(Sender: TObject);
begin
   FCfgList := nil;
   checkImportProvCity.Checked := dmZLogGlobal.Settings.FImpProvCity;
   checkImportCwMessage1.Checked := dmZLogGlobal.Settings.FImpCwMessage[1];
   checkImportCwMessage2.Checked := dmZLogGlobal.Settings.FImpCwMessage[2];
   checkImportCwMessage3.Checked := dmZLogGlobal.Settings.FImpCwMessage[3];
   checkImportCwMessage4.Checked := dmZLogGlobal.Settings.FImpCwMessage[4];
   checkImportCQMessage2.Checked := dmZLogGlobal.Settings.FImpCQMessage[2];
   checkImportCQMessage3.Checked := dmZLogGlobal.Settings.FImpCQMessage[3];
   checkAllowTempChanges.Checked := Not dmZLogGlobal.Settings.ReadOnlyParamImported;
   editFilterText.Text := '';
end;

procedure TSelectUserDefinedContest.FormDestroy(Sender: TObject);
begin
   FCfgList.Free();
   dmZLogGlobal.Settings.FImpProvCity := checkImportProvCity.Checked;
   dmZLogGlobal.Settings.FImpCwMessage[1] := checkImportCwMessage1.Checked;
   dmZLogGlobal.Settings.FImpCwMessage[2] := checkImportCwMessage2.Checked;
   dmZLogGlobal.Settings.FImpCwMessage[3] := checkImportCwMessage3.Checked;
   dmZLogGlobal.Settings.FImpCwMessage[4] := checkImportCwMessage4.Checked;
   dmZLogGlobal.Settings.FImpCQMessage[2] := checkImportCQMessage2.Checked;
   dmZLogGlobal.Settings.FImpCQMessage[3] := checkImportCQMessage3.Checked;
   dmZLogGlobal.Settings.ReadOnlyParamImported := Not checkAllowTempChanges.Checked;
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
   ShowCfgFiles(FCfgList, editFilterText.Text);
end;

procedure TSelectUserDefinedContest.buttonOKClick(Sender: TObject);
begin
   FSelectedContest := TUserDefinedContest(ListView1.Selected.Data);

   if (Pos('$V', FSelectedContest.Sent) > 0) and (FSelectedContest.Prov = '') then begin
      MessageBox(Handle, PChar(Setup_prov_first), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      PostMessage(Handle, WM_ZLOG_SHOWCFGEDIT, 0, 0);
      Exit;
   end;

   if (Pos('$Q', FSelectedContest.Sent) > 0) and (FSelectedContest.City = '') then begin
      MessageBox(Handle, PChar(Setup_city_first), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
      PostMessage(Handle, WM_ZLOG_SHOWCFGEDIT, 0, 0);
      Exit;
   end;

   ModalResult := mrOK;
end;

procedure TSelectUserDefinedContest.editFilterTextChange(Sender: TObject);
begin
   ShowCfgFiles(FCfgList, editFilterText.Text);
end;

procedure TSelectUserDefinedContest.buttonCFGEditClick(Sender: TObject);
var
   f: TCFGEdit;
   D: TUserDefinedContest;
begin
   f := TCFGEdit.Create(Self);
   try
      D := TUserDefinedContest(ListView1.Selected.Data);

      f.Sent := D.Sent;
      f.Prov := D.Prov;
      f.City := D.City;
      f.Power := D.Power;
      f.CwMessageA[1] := D.CwMessageA[1];
      f.CwMessageA[2] := D.CwMessageA[2];
      f.CwMessageA[3] := D.CwMessageA[3];
      f.CwMessageA[4] := D.CwMessageA[4];
      f.CwMessageCQ[2] := D.CwMessageCQ[2];
      f.CwMessageCQ[3] := D.CwMessageCQ[3];
      f.UseContestPeriod := D.UseContestPeriod;
      f.UseUTC := D.UseUTC;
      f.StartTime := D.StartTime;
      f.Period := D.Period;

      if f.ShowModal() <> mrOK then begin
         Exit;
      end;

      D.Sent := F.Sent;
      D.Prov := F.Prov;
      D.City := F.City;
      D.Power := F.Power;
      D.CwMessageA[1] := f.CwMessageA[1];
      D.CwMessageA[2] := f.CwMessageA[2];
      D.CwMessageA[3] := f.CwMessageA[3];
      D.CwMessageA[4] := f.CwMessageA[4];
      D.CwMessageCQ[2] := f.CwMessageCQ[2];
      D.CwMessageCQ[3] := f.CwMessageCQ[3];
      D.UseUTC := f.UseUTC;
      D.UseContestPeriod := f.UseContestPeriod;
      D.StartTime := f.StartTime;
      D.Period := f.Period;
      D.Save();

      ListView1.Selected.SubItems[1] := D.Prov;
      ListView1.Selected.SubItems[2] := D.City;
      ListView1.Selected.SubItems[3] := D.CwMessageA[1];
      ListView1.Selected.SubItems[4] := D.CwMessageA[2];
      ListView1.Selected.SubItems[5] := D.CwMessageA[3];
      ListView1.Selected.SubItems[6] := D.CwMessageA[4];
      ListView1.Selected.SubItems[7] := D.CwMessageCQ[2];
      ListView1.Selected.SubItems[8] := D.CwMessageCQ[3];
   finally
      f.Release();
   end;
end;

procedure TSelectUserDefinedContest.buttonCfgFolderRefClick(Sender: TObject);
var
   RootFolder: string;
   SelectFolder: string;
begin
   RootFolder := '';
   SelectFolder := dmZLogGlobal.CfgDatPath;

   if SelectDirectory('フォルダの指定', RootFolder, SelectFolder, [sdNewUI, sdNewFolder, sdShowEdit], Self)= False then begin
      Exit;
   end;

   editCfgFolder.Text := SelectFolder;

   FCfgList.Free();
   FCfgList := ScanCfgFiles(editCfgFolder.Text);
   ShowCfgFiles(FCfgList, '');
end;

procedure TSelectUserDefinedContest.ListView1DblClick(Sender: TObject);
begin
   if buttonOK.Enabled = False then begin
      Exit;
   end;
   buttonOK.Click();
end;

procedure TSelectUserDefinedContest.ListView1MouseEnter(Sender: TObject);
begin
   ActiveControl := ListView1;
end;

procedure TSelectUserDefinedContest.ListView1SelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
   buttonOK.Enabled := Selected;
   buttonCFGEdit.Enabled := Selected;
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
//            D.FileName := F.Name;
//            D.Fullpath := S + F.Name;

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

procedure TSelectUserDefinedContest.ShowCfgFiles(L: TUserDefinedContestList; strFilter: string);
var
   i: Integer;
   listitem: TListItem;
   D: TUserDefinedContest;
begin
   ListView1.Items.BeginUpdate();

   ListView1.Items.Clear();
   for i := 0 to L.Count - 1 do begin
      D := L[i];

      if strFilter <> '' then begin
         if (Pos(UpperCase(strFilter), UpperCase(D.FileName)) = 0) and (Pos(strFilter, D.ContestName) = 0) then begin
            Continue;
         end;
      end;

      listitem := ListView1.Items.Add();
      listitem.Caption := D.FileName;
      listitem.SubItems.Add(D.ContestName);
      listitem.SubItems.Add(D.Prov);
      listitem.SubItems.Add(D.City);
      listitem.SubItems.Add(D.FCwMessageA[1]);
      listitem.SubItems.Add(D.FCwMessageA[2]);
      listitem.SubItems.Add(D.FCwMessageA[3]);
      listitem.SubItems.Add(D.FCwMessageA[4]);
      listitem.SubItems.Add(D.FCwMessageCQ[2]);
      listitem.SubItems.Add(D.FCwMessageCQ[3]);
      listitem.Data := D;

      if D.ContestName = FInitialContestName then begin
         listItem.Selected := True;
         listItem.MakeVisible(False);
      end;
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

function TSelectUserDefinedContest.GetImportCwMessage(Index: Integer): Boolean;
begin
   case Index of
      1: Result := checkImportCwMessage1.Checked;
      2: Result := checkImportCwMessage2.Checked;
      3: Result := checkImportCwMessage3.Checked;
      4: Result := checkImportCwMessage4.Checked;
      else Result := False;
   end;
end;

function TSelectUserDefinedContest.GetImportCQMessage(Index: Integer): Boolean;
begin
   case Index of
      2: Result := checkImportCQMessage2.Checked;
      3: Result := checkImportCQMessage3.Checked;
      else Result := False;
   end;
end;

procedure TSelectUserDefinedContest.OnZLogShowCfgEdit( var Message: TMessage );
begin
   buttonCFGEditClick(buttonCFGEdit);
end;

end.
