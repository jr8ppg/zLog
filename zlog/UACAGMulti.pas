unit UACAGMulti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, Grids, UzLogConst, UzLogGlobal, UzLogQSO,
  JLLabel, UBasicMulti, UMultipliers;

const
  WM_ZLOG_UPDATELABEL = (WM_USER + 100);

type
  TACAGMulti = class(TBasicMulti)
    Panel1: TPanel;
    buttonGo: TButton;
    Panel: TPanel;
    Label1R9: TRotateLabel;
    Label3R5: TRotateLabel;
    Label7: TRotateLabel;
    Label14: TRotateLabel;
    Label21: TRotateLabel;
    Label28: TRotateLabel;
    Label50: TRotateLabel;
    Label144: TRotateLabel;
    Label430: TRotateLabel;
    Label1200: TRotateLabel;
    Label2400: TRotateLabel;
    Label5600: TRotateLabel;
    Edit1: TEdit;
    Label10g: TRotateLabel;
    StayOnTop: TCheckBox;
    checkJumpLatestMulti: TCheckBox;
    Grid: TStringGrid;
    checkIncremental: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure GoButtonClick2(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StayOnTopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  protected
    CityList : TCityList;
    LatestMultiAddition : integer; // Grid.TopRow
    procedure SetFontSize(v: Integer); override;
    procedure OnZLogUpdateLabel( var Message: TMessage ); message WM_ZLOG_UPDATELABEL;
    procedure UpdateLabelPos(); virtual;
    function GetIsIncrementalSearchPresent(): Boolean; override;
    procedure GoForwardMatch(strCode: string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateData; override;
    procedure AddNoUpdate(var aQSO : TQSO); override;
    procedure Add(var aQSO : TQSO); override; {NewMulti}
    function ValidMulti(aQSO : TQSO) : boolean; override;
    procedure Reset; override;
    procedure CheckMulti(aQSO : TQSO); override;
    function ExtractMulti(aQSO : TQSO) : string; override;
    procedure SetNumberEditFocus; override;
  end;

implementation

uses
  Main;

{$R *.DFM}

procedure TACAGMulti.Add(var aQSO: TQSO);
begin
   inherited;
end;

procedure TACAGMulti.UpdateData;
var
   i: Integer;
   C: TCity;
   B: TBand;
begin
   B := Main.CurrentQSO.Band;
   if B = bUnknown then begin
      Exit;
   end;

   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      if C.Worked[B] then begin
         Grid.Cells[0, i] := '~' + C.Summary;
      end
      else begin
         Grid.Cells[0, i] := C.Summary;
      end;
   end;

   if checkJumpLatestMulti.Checked = True then begin
      Grid.TopRow := LatestMultiAddition;
   end;

   Grid.Refresh();
end;

procedure TACAGMulti.CheckMulti(aQSO: TQSO);
var
   str: string;
   i: Integer;
   C: TCity;
begin
   Edit1.Text := aQSO.NrRcvd;

   if aQSO.NrRcvd = '' then begin
      MainForm.WriteStatusLine('', False);
      Exit;
   end;

   str := Edit1.Text;

   if CharInSet(str[length(str)], ['H', 'P', 'L', 'M']) = True then begin
      System.Delete(str, length(str), 1);
   end;

   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then begin
         Grid.TopRow := i;

         if C.Worked[aQSO.Band] then begin
            str := Format('[%s: %s] Worked on this band. %s', [C.CityNumber, C.CityName, C.WorkedOn]);
         end
         else begin
            str := Format('[%s: %s] Needed on this band. %s', [C.CityNumber, C.CityName, C.WorkedOn]);
         end;

         MainForm.WriteStatusLine(str, False);
         Exit;
      end;
   end;

   MainForm.WriteStatusLine(TMainForm_Invalid_number, False);
end;

function TACAGMulti.ExtractMulti(aQSO: TQSO): string;
var
   str: string;
begin
   Result := '';
   str := aQSO.NrRcvd;
   if str = '' then begin
      Exit;
   end;

   if CharInSet(str[length(str)], ['0' .. '9']) = False then begin
      Delete(str, length(str), 1);
   end;

   Result := str;
end;

procedure TACAGMulti.AddNoUpdate(var aQSO: TQSO);
var
   str: string;
   C: TCity;
begin
   aQSO.NewMulti1 := False;
   str := aQSO.NrRcvd;
   Delete(str, length(str), 1);
   aQSO.Multi1 := str;

   if aQSO.Dupe then begin
      Exit;
   end;

   C := CityList.GetCity(str);
   if C <> nil then begin
      if C.Worked[aQSO.Band] = False then begin
         C.Worked[aQSO.Band] := True;
         aQSO.NewMulti1 := True;
      end;
      LatestMultiAddition := C.Index;
   end;
end;

procedure TACAGMulti.Reset;
var
   i, j: Integer;
   B: TBand;
   str: string;
begin
   if CityList.List.Count = 0 then begin
      Exit;
   end;

   j := Grid.TopRow;
   Grid.RowCount := 0;
   Grid.RowCount := CityList.List.Count;

   for i := 0 to CityList.List.Count - 1 do begin
      for B := b19 to HiBand do begin
         TCity(CityList.List[i]).Worked[B] := False;
      end;

      str := TCity(CityList.List[i]).Summary;
      str[30] := ' ';
      Grid.Cells[0, i] := str;
   end;

   Grid.TopRow := j;
   LatestMultiAddition := 0;
end;

function TACAGMulti.ValidMulti(aQSO: TQSO): Boolean;
var
   str: string;
   C: TCity;
   i: Integer;
   boo: Boolean;
begin
   Result := False;
   str := aQSO.NrRcvd;
   if not(length(str) in [5 .. 7]) then begin
      Exit;
   end;

   if CharInSet(str[length(str)], ['P', 'L', 'M', 'H']) = False then begin
      Exit;
   end;

   Delete(str, length(str), 1);

   boo := False;
   for i := 0 to CityList.List.Count - 1 do begin
      C := TCity(CityList.List[i]);
      if str = C.CityNumber then begin
         boo := True;
         Break;
      end;
   end;

   Result := boo;
end;

procedure TACAGMulti.FormCreate(Sender: TObject);
begin
   LatestMultiAddition := 0;
   CityList := TCityList.Create;
   CityList.LoadFromFile('ACAG.DAT');

   if CityList.List.Count = 0 then begin
      Exit;
   end;

   Reset;
end;

procedure TACAGMulti.FormDestroy(Sender: TObject);
begin
   inherited;
   CityList.Free();
end;

procedure TACAGMulti.FormResize(Sender: TObject);
begin
   inherited;
   AdjustGridSize(Grid);
end;

procedure TACAGMulti.GoButtonClick2(Sender: TObject);
begin
   GoForwardMatch(Edit1.Text);
end;

procedure TACAGMulti.GoForwardMatch(strCode: string);
var
   i: Integer;
   l: Integer;
begin
   l := Length(strCode);
   if l = 0 then begin
      Grid.TopRow := LatestMultiAddition;
      Exit;
   end;

   for i := 0 to CityList.List.Count - 1 do begin
      if (strCode = Copy(TCity(CityList.List[i]).CityNumber, 1, l)) then begin
         Grid.TopRow := i;
         LatestMultiAddition := i;
         Break;
      end;
   end;
end;

procedure TACAGMulti.Edit1Change(Sender: TObject);
begin
   if (checkIncremental.Checked = True) then begin
      GoForwardMatch(Edit1.Text);
   end;
end;

procedure TACAGMulti.Edit1Enter(Sender: TObject);
begin
   buttonGo.Default := True;
end;

procedure TACAGMulti.Edit1Exit(Sender: TObject);
begin
   buttonGo.Default := False;
end;

procedure TACAGMulti.FormShow(Sender: TObject);
begin
   inherited;
   AdjustGridSize(Grid);
   LatestMultiAddition := 0;
   UpdateData();
   PostMessage(Handle, WM_ZLOG_UPDATELABEL, 0, 0);
end;

procedure TACAGMulti.StayOnTopClick(Sender: TObject);
begin
   if StayOnTop.Checked then begin
      FormStyle := fsStayOnTop;
   end
   else begin
      FormStyle := fsNormal;
   end;
end;

procedure TACAGMulti.SetNumberEditFocus;
begin
   SetNumberEditFocusJARL;
end;

procedure TACAGMulti.SetFontSize(v: Integer);
begin
   Inherited;
   SetGridFontSize(Grid, v);
   UpdateLabelPos();
   UpdateData();
end;

procedure TACAGMulti.GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
   inherited;
   Draw_GridCell(Grid, ACol, ARow, Rect);
end;

procedure TACAGMulti.UpdateLabelPos();
var
   w, l: Integer;
begin
   w := Grid.Canvas.TextWidth('X');
   l := (w * 29) - 2;
   Label1R9.Left  := l;
   Label3R5.Left  := Label1R9.Left + (w * 2);
   Label7.Left    := Label3R5.Left + (w * 2);
   Label14.Left   := Label7.Left + (w * 2);
   Label21.Left   := Label14.Left + (w * 2);
   Label28.Left   := Label21.Left + (w * 2);
   Label50.Left   := Label28.Left + (w * 2);
   Label144.Left  := Label50.Left + (w * 2);
   Label430.Left  := Label144.Left + (w * 2);
   Label1200.Left := Label430.Left + (w * 2);
   Label2400.Left := Label1200.Left + (w * 2);
   Label5600.Left := Label2400.Left + (w * 2);
   Label10g.Left  := Label5600.Left + (w * 2);
end;

procedure TACAGMulti.OnZLogUpdateLabel( var Message: TMessage );
begin
   Application.ProcessMessages();
   UpdateLabelPos();
end;

function TACAGMulti.GetIsIncrementalSearchPresent(): Boolean;
begin
   Result := checkIncremental.Checked;
end;

end.
