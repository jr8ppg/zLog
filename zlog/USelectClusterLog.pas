unit USelectClusterLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TformSelectClusterLog = class(TForm)
    listLogFiles: TCheckListBox;
    Panel1: TPanel;
    buttonOK: TButton;
    buttonCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure listLogFilesClickCheck(Sender: TObject);
  private
    { Private êÈåæ }
    function GetFileList(): TStrings;
  public
    { Public êÈåæ }
    property FileList: TStrings read GetFileList;
  end;

implementation

{$R *.dfm}

procedure TformSelectClusterLog.FormCreate(Sender: TObject);
begin
   listLogFiles.Items.Clear();
end;

procedure TformSelectClusterLog.FormShow(Sender: TObject);
var
   ret: Integer;
   F: TSearchRec;
   S: string;
   slFiles: TStringList;
begin
   slFiles := TStringList.Create();
   try
      S := ExtractFilePath(Application.ExeName);
      ret := FindFirst(S + 'zlog_telnet_log_*.txt', faAnyFile, F);
      while ret = 0 do begin
         if ((F.Attr and faDirectory) = 0) and
            ((F.Attr and faVolumeID) = 0) and
            ((F.Attr and faSysFile) = 0) then begin
            slFiles.Add(F.Name);
         end;

         // éüÇÃÉtÉ@ÉCÉã
         ret := FindNext(F);
      end;

      FindClose(F);

      listLogFiles.Items.Assign(slFiles);
      listLogFiles.CheckAll(cbUnchecked);
      buttonOK.Enabled := False;
   finally
      slFiles.Free();
   end;
end;

procedure TformSelectClusterLog.listLogFilesClickCheck(Sender: TObject);
var
   i: Integer;
   nCheckOn: Integer;
begin
   nCheckOn := 0;
   for i := 0 to listLogFiles.Items.Count - 1 do begin
      if listLogFiles.Checked[i] = True then begin
         Inc(nCheckOn);
      end;
   end;

   if nCheckOn = 0 then begin
      buttonOK.Enabled := False;
   end
   else begin
      buttonOK.Enabled := True;
   end;
end;

function TformSelectClusterLog.GetFileList(): TStrings;
begin
   Result := listLogFiles.Items;
end;

end.
