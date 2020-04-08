unit URateDialog;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, wsaGraph, UOptions, UzLogConst, UzLogGlobal, UzLogQSO;

type
  TRateDialog = class(TForm)
    Timer: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Last10: TLabel;
    Last100: TLabel;
    Max10: TLabel;
    Max100: TLabel;
    Panel2: TPanel;
    OKBtn: TButton;
    StayOnTop: TCheckBox;
    Graph: TwsaGraph;
    Panel3: TPanel;
    ShowLastCombo: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure TimerTimer(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StayOnTopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ShowLastComboChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateParams(var Params: TCreateParams); override;
  private
    _max10, _max100 : double;
    function CountQSOs(_start, _end : TDateTime) : integer;
    { Private declarations }
  public
     ShowLast : integer;      { Show last x hours. default = 12}
     TimeIncrement : integer; { time increment in minutes default = 60}
     procedure UpdateGraph;
    { Public declarations }
  end;

var
  RateDialog: TRateDialog;

implementation

uses Main;

{$R *.DFM}

procedure TRateDialog.TimerTimer(Sender: TObject);
var
   Last: TDateTime;
   Diff, Rate: double;
   i: LongInt;
   mytx, k: integer;
   aQSO: TQSO;
begin
   if not(Visible) then
      exit;
   i := Log.TotalQSO;
   if i < 10 then begin
      exit;
   end;

   mytx := dmZlogGlobal.TXNr;

   k := 0;
   repeat
      aQSO := TQSO(Log.List[i]);
      if aQSO.TX = mytx then begin
         inc(k);
      end;

      dec(i)
   until (i = 0) or (k = 10);

   if (k = 10) then begin
      Last := aQSO.time;
      Diff := (CurrentTime - Last) * 24.0;
      Rate := 10 / Diff;
      if Rate > _max10 then
         _max10 := Rate;

      Last10.Caption := Format('%3.2f', [Rate]) + ' QSOs/hr';
      Max10.Caption := 'max ' + Format('%3.2f', [_max10]) + ' QSOs/hr';
   end
   else begin
      exit;
   end;

   i := Log.TotalQSO;
   k := 0;
   repeat
      aQSO := TQSO(Log.List[i]);
      if aQSO.TX = mytx then begin
         inc(k);
      end;
      dec(i);
   until (i = 0) or (k = 100);

   if k = 100 then begin
      Last := aQSO.time;
      Diff := (CurrentTime - Last) * 24.0;
      Rate := 100 / Diff;
      If Rate > _max100 then
         _max100 := Rate;

      Last100.Caption := Format('%3.2f', [Rate]) + ' QSOs/hr';
      Max100.Caption := 'max ' + Format('%3.2f', [_max100]) + ' QSOs/hr';
   end;
end;

procedure TRateDialog.OKBtnClick(Sender: TObject);
begin
   Close;
   MainForm.LastFocus.SetFocus;
end;

procedure TRateDialog.FormCreate(Sender: TObject);
begin
   _max10 := 0;
   _max100 := 0;
   ShowLast := 12;
   TimeIncrement := 60;
   Graph.BackGroundColor := clBtnFace;
   Graph.GraphColor := clNavy;
end;

procedure TRateDialog.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case Key of
      VK_ESCAPE:
         MainForm.LastFocus.SetFocus;
   end;
end;

procedure TRateDialog.StayOnTopClick(Sender: TObject);
begin
   If StayOnTop.Checked then
      FormStyle := fsStayOnTop
   else
      FormStyle := fsNormal;
end;

function TRateDialog.CountQSOs(_start, _end: TDateTime): integer;
var
   i: integer;
   T: TDateTime;
begin
   Result := 0;

   for i := 1 to Log.TotalQSO do begin
      T := TQSO(Log.List[i]).time;
      if (T >= _start) and (T < _end) then
         inc(Result);
   end;
end;

procedure TRateDialog.UpdateGraph;
var
   j, k: integer;
   str: string;
   _Now: TDateTime;
   _start: TDateTime;

var
   H, M, S, ms: Word;

begin
   Graph.ClearGraph;
   _Now := CurrentTime;
   _start := _Now - (ShowLast - 1) / 24;
   DecodeTime(_start, H, M, S, ms);
   _start := Int(_start) + EncodeTime(H, 0, 0, 0);

   if Log.TotalQSO = 0 then
      exit;

   if TQSO(Log.List[Log.TotalQSO]).time < _start then
      exit;

   for k := 0 to ShowLast - 1 do begin
      j := CountQSOs(_start + (1 / 24) * k, _start + (1 / 24) * (k + 1));
      str := IntToStr(GetHour(_start + (1 / 24) * k));

      if ShowLast > 12 then
         if (GetHour(_start + (1 / 24) * k) mod 2) = 1 then
            str := '';

      if ShowLast > 24 then
         if (GetHour(_start + (1 / 24) * k) mod 4) <> 0 then
            str := '';

      Graph.AddData(k + 1, j, str);
   end;
   Graph.PlotGraph;
end;

procedure TRateDialog.FormShow(Sender: TObject);
begin
   UpdateGraph;
   Timer.Enabled := True;
end;

procedure TRateDialog.ShowLastComboChange(Sender: TObject);
begin
   ShowLast := StrToIntDef(ShowLastCombo.Text, 12);
   UpdateGraph;
end;

procedure TRateDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Timer.Enabled := False;
end;

procedure TRateDialog.CreateParams(var Params: TCreateParams);
begin
   inherited CreateParams(Params);
   Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

end.
