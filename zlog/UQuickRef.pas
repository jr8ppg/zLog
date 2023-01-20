unit UQuickRef;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UzLogGlobal, Vcl.ComCtrls, Vcl.ToolWin, System.ImageList,
  Vcl.ImgList;

type
  TQuickRef = class(TForm)
    Memo: TMemo;
    ToolBar1: TToolBar;
    toolbuttonPlus: TToolButton;
    toolbuttonMinus: TToolButton;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure toolbuttonPlusClick(Sender: TObject);
    procedure toolbuttonMinusClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private �錾 }
  public
    { Public �錾 }
  end;

implementation

uses Main;

{$R *.dfm}

procedure TQuickRef.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   MainForm.DelTaskbar(Handle);
end;

procedure TQuickRef.FormCreate(Sender: TObject);
begin
   dmZlogGlobal.ReadWindowState(Self);

   if FileExists('ZLOGHELP.TXT') then begin
      Memo.Lines.LoadFromFile('ZLOGHELP.TXT');
   end
   else
      Memo.Lines.Clear;

   Memo.Font.Size := dmZLogGlobal.Settings.FQuickRefFontSize;
   Memo.Font.Name := dmZLogGlobal.Settings.FQuickRefFontFace;
end;

procedure TQuickRef.FormDestroy(Sender: TObject);
begin
   dmZlogGlobal.WriteWindowState(Self);
end;

procedure TQuickRef.FormShow(Sender: TObject);
begin
   MainForm.AddTaskbar(Handle);
end;

procedure TQuickRef.MemoKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = Chr($1B) then
      MainForm.SetLastFocus();
end;

procedure TQuickRef.toolbuttonPlusClick(Sender: TObject);
var
   n: Integer;
begin
   n := Memo.Font.Size;
   if n < 20 then begin
      Inc(n);
   end;
   Memo.Font.Size := n;

   dmZLogGlobal.Settings.FQuickRefFontSize := n;
   //dmZLogGlobal.Settings.FQuickRefFontFace := Memo.Font.Name;
end;

procedure TQuickRef.toolbuttonMinusClick(Sender: TObject);
var
   n: Integer;
begin
   n := Memo.Font.Size;
   if n > 8 then begin
      Dec(n);
   end;
   Memo.Font.Size := n;

   dmZLogGlobal.Settings.FQuickRefFontSize := n;
   //dmZLogGlobal.Settings.FQuickRefFontFace := Memo.Font.Name;
end;

end.
