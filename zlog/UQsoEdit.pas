unit UQsoEdit;

interface

uses
  WinApi.Windows, WinApi.Messages, System.SysUtils, System.Classes, Vcl.Forms,
  UzLogGlobal, UzLogQSO, UzLogConst, UGeneralMulti2;

type
  TBasicEdit = class
  public
    colSerial : Integer;         // 0
    colTime : Integer;           // 1
    colCall : Integer;           // 2
    colrcvdRST : Integer;        // 3
    colrcvdNumber : Integer;     // 4
    colMode : Integer;           // 5
    colNewPower : Integer;       // 6
    colBand : Integer;           // 7
    colPoint : Integer;          // 8
    colOp : Integer;             // 9
    colMemo : Integer;           // 10
    colNewMulti1 : Integer;      // 11
    colNewMulti2 : Integer;      // 12

    GridColCount: Integer;
  public
    SerialWid : Integer;         // 0
    TimeWid : Integer;           // 1
    CallSignWid : Integer;       // 2
    rcvdRSTWid : Integer;        // 3
    NumberWid : Integer;         // 4
    BandWid : Integer;           // 5
    ModeWid : Integer;           // 6
    NewPowerWid : Integer;       // 7
    PointWid : Integer;          // 8
    OpWid : Integer;             // 9
    MemoWid : Integer;           // 10
    NewMulti1Wid : Integer;      // 11
    NewMulti2Wid : Integer;      // 12

    constructor Create(AOwner: TComponent); virtual;
    function GetNewMulti1(aQSO : TQSO) : string; virtual;
    function GetNewMulti2(aQSO: TQSO): string; virtual;
  end;

  TGeneralEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent; UseMulti2: Boolean);
    function GetNewMulti1(aQSO : TQSO) : string; override;
    function GetNewMulti2(aQSO : TQSO) : string; override;
  end;

  TALLJAEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TIARUEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TARRLDXEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TACAGEdit = class(TALLJAEdit)
  private
  public
    // constructor Create; override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TWWEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TKCJEdit = class(TWWEdit)
  private
  public
    //constructor Create; override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TDXCCEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TWPXEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TJA0Edit = class(TWPXEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSerialGeneralEdit = class(TWPXEdit)
  private
  public
    formMulti: TGeneralMulti2;
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;

  TIOTAEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent); override;
    function GetNewMulti1(aQSO : TQSO) : string; override;
  end;


implementation

constructor TBasicEdit.Create(AOwner: TComponent);
begin
   Inherited Create();

   colSerial := -1;
   colTime := 1;
   colCall := -1;
   colrcvdRST := -1;
   colrcvdNumber := -1;
   colMode := -1;
   colNewPower := -1;
   colBand := -1;
   colPoint := -1;
   colMemo := -1;
   colSerial := -1;
   colOp := -1;
   colNewMulti1 := -1;
   colNewMulti2 := -1;

   SerialWid := 4;
   TimeWid := 6;
   CallSignWid := 12;
   rcvdRSTWid := 4;
   NumberWid := 10;
   BandWid := 4;
   ModeWid := 4;
   NewPowerWid := 2;
   PointWid := 3;
   OpWid := 8;
   MemoWid := 10;
   NewMulti1Wid := 3;
   NewMulti2Wid := 0;
end;

function TBasicEdit.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.NewMulti1 then
      Result := '*'
   else
      Result := '';
end;

function TBasicEdit.GetNewMulti2(aQSO: TQSO): string;
begin
   if aQSO.NewMulti2 then
      Result := '*'
   else
      Result := '';
end;

constructor TGeneralEdit.Create(AOwner: TComponent; UseMulti2: Boolean);
var
 colno: Integer;
begin
   inherited Create(AOwner);

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;
   NewMulti1Wid := 5;

   colno := 8;
   if UseMulti2 = True then begin
      colNewMulti2 := colno;
      NewMulti2Wid := 5;
      Inc(colno);
   end
   else begin
      colNewMulti2 := -1;
      NewMulti2Wid := 0;
   end;

   if Pos('$P', dmZlogGlobal.Settings._sentstr) > 0 then begin
      colNewPower := colno;
      Inc(colno);
      colOp := colno;
      Inc(colno);
      colMemo := colno;
      Inc(colno);
      GridColCount := 12;
   end
   else begin
      colNewPower := -1;
      colOp := colno;
      Inc(colno);
      colMemo := colno;
      Inc(colno);
      GridColCount := 11;
   end;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 13;
   end
   else begin
      OpWid := 6;
      MemoWid := 7;
   end
end;

constructor TARRLDXEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;
   colNewPower := 8;
   colOp := 9;
   colMemo := 10;

   GridColCount := 11;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 13;
   end
   else begin
      OpWid := 6;
      MemoWid := 7;
   end;

   NumberWid := 3;
end;

constructor TWWEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := -1;
   { colPower := 6; }
   colPoint := 5;
   colNewMulti1 := 6;
   // colNewMulti2 := 7;
   colOp := 7;
   colMemo := 8;
   GridColCount := 9;
   NumberWid := 3;
   NewMulti1Wid := 6;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 16;
   end
   else begin
      OpWid := 6;
      MemoWid := 10;
   end;
end;

function TWWEdit.GetNewMulti1(aQSO: TQSO): string;
var
   str: string;
begin
   if aQSO.NewMulti1 then
      str := FillRight(aQSO.Multi1, 3)
   else
      str := '   ';
   if aQSO.NewMulti2 then
      str := str + aQSO.Multi2;
   Result := str;
end;

function TKCJEdit.GetNewMulti1(aQSO: TQSO): string;
var
   str: string;
begin
   if aQSO.NewMulti1 then
      str := aQSO.Multi1
   else
      str := '';
   Result := str;
end;

constructor TDXCCEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := -1;
   { colPower := 6; }
   colPoint := 5;
   colNewMulti1 := 6;
   colOp := 7;
   colMemo := 8;
   GridColCount := 9;

   NumberWid := 4;
   NewMulti1Wid := 5;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 16;
   end
   else begin
      OpWid := 6;
      MemoWid := 10;
   end;
end;

function TDXCCEdit.GetNewMulti1(aQSO: TQSO): string;
begin
   if aQSO.NewMulti1 then
      Result := aQSO.Multi1
   else
      Result := '';
end;

constructor TWPXEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   colMode := -1;
   { colPower := 6; }
   colPoint := 6;
   colNewMulti1 := 7;
   colOp := 8;
   colMemo := 9;

   SerialWid := 5;
   TimeWid := 6;
   CallSignWid := 12;
   rcvdRSTWid := 4;
   NumberWid := 6;
   BandWid := 4;
   PointWid := 3;
   OpWid := 8;
   MemoWid := 10;
   NewMulti1Wid := 5;

   GridColCount := 10;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 16;
   end
   else begin
      OpWid := 6;
      MemoWid := 10;
   end;
end;

constructor TJA0Edit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   GridColCount := 11;

   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   colMode := 6;
   colPoint := 7;
   colNewMulti1 := 8;
   colOp := 9;
   colMemo := 10;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 16;
   end
   else begin
      OpWid := 6;
      MemoWid := 10;
   end;
end;

function TWPXEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   temp := '  ' + aQSO.Multi1;
   if aQSO.NewMulti1 then
      temp[1] := '*';
   Result := temp;
end;

constructor TSerialGeneralEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   colMode := 6;
   { colPower := 6; }
   colPoint := 7;
   colNewMulti1 := 8;
   colNewMulti2 := 9;
   colOp := 10;
   colMemo := 11;

   SerialWid := 4;
   TimeWid := 4;
   CallSignWid := 8;
   rcvdRSTWid := 3;
   NumberWid := 4;
   BandWid := 3;
   ModeWid := 3;
   PointWid := 2;
   OpWid := 6;
   MemoWid := 7;
   NewMulti1Wid := 5;
   NewMulti2Wid := 5;

   GridColCount := 12;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 13;
   end
   else begin
      OpWid := 6;
      MemoWid := 7;
   end;
end;

function TSerialGeneralEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   Result := '';
   if formMulti.Config.PXMulti = 0 then begin
      if aQSO.NewMulti1 then
         Result := aQSO.Multi1;
   end
   else begin
      temp := '  ' + aQSO.Multi1;
      if aQSO.NewMulti1 then
         temp[1] := '*';
      Result := temp;
   end;
end;

constructor TIOTAEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   colSerial := 0;
   colTime := 1;
   colCall := 2;
   colrcvdRST := 3;
   colrcvdNumber := 4;
   colBand := 5;
   colMode := 6;
   { colPower := 6; }
   colPoint := 7;
   colNewMulti1 := 8;
   colOp := 9;
   colMemo := 10;

   SerialWid := 4;
   TimeWid := 6;
   CallSignWid := 8;
   rcvdRSTWid := 4;
   NumberWid := 6;
   BandWid := 4;
   ModeWid := 4;
   PointWid := 4;
   OpWid := 6;
   MemoWid := 7;
   NewMulti1Wid := 6;

   GridColCount := 11;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 11;
   end
   else begin
      OpWid := 6;
      MemoWid := 5;
   end;
end;

function TIOTAEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   // temp := '  '+aQSO.Multi1;
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1;
   Result := temp;
end;

function TGeneralEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1
   else
      temp := '';
   Result := temp;
end;

function TGeneralEdit.GetNewMulti2(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti2 then
      temp := aQSO.Multi2
   else
      temp := '';
   Result := temp;
end;

constructor TALLJAEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOWner);

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;
   colNewPower := 8;
   colOp := 9;
   colMemo := 10;

   GridColCount := 11;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 13;
   end
   else begin
      OpWid := 6;
      MemoWid := 7;
   end;
end;

function TALLJAEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1
   else
      temp := '';
   Result := temp;
end;

constructor TIARUEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   colTime := 0;
   colCall := 1;
   colrcvdRST := 2;
   colrcvdNumber := 3;
   colBand := 4;
   colMode := 5;
   colPoint := 6;
   colNewMulti1 := 7;
   // colNewPower := 8;
   colOp := 8;
   colMemo := 9;

   NumberWid := 4;
   BandWid := 3;
   NewMulti1Wid := 4;

   GridColCount := 10;
   // MainForm.NewPowerEdit.Visible := True;

   if dmZlogGlobal.ContestCategory = ccSingleOp then begin
      OpWid := 0;
      MemoWid := 17;
   end
   else begin
      OpWid := 6;
      MemoWid := 11;
   end;
end;

function TIARUEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1
   else
      temp := '';
   Result := temp;
end;

function TARRLDXEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := aQSO.Multi1
   else
      temp := '';
   Result := temp;
end;

function TACAGEdit.GetNewMulti1(aQSO: TQSO): string;
var
   temp: string;
begin
   if aQSO.NewMulti1 then
      temp := '*'
   else
      temp := '';
   Result := temp;
end;

end.
