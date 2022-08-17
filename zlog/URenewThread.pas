unit URenewThread;

interface

uses
  Classes, UzLogGlobal, UzLogQSO;

type
  TRenewThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure SyncProc;
    procedure Execute; override;
  end;

procedure RequestRenewThread;

var Renewing : boolean = False;

implementation

uses Main;
{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TRenewThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TRenewThread }

procedure TRenewThread.SyncProc;
var
   boo: boolean;
begin
   boo := MainForm.Grid.Focused;

   Main.MyContest.RenewScoreAndMulti();

   Main.MyContest.MultiForm.UpdateData;
   Main.MyContest.ScoreForm.UpdateData;

   // 画面リフレッシュ
   MainForm.GridRefreshScreen(True);

   // バンドスコープリフレッシュ
   MainForm.BSRefresh();

   MainForm.ReevaluateCountDownTimer;
   MainForm.ReevaluateQSYCount;

   if boo then
      MainForm.Grid.SetFocus;
end;

procedure TRenewThread.Execute;
begin
   { Place thread code here }
   FreeOnTerminate := True;

   Repeat
   until Renewing = False;

   Renewing := True;

   Synchronize(SyncProc);

   Renewing := False;
end;

procedure RequestRenewThread;
var
   RTh: TRenewThread;
begin
   RTh := TRenewThread.Create(False);
end;

end.
