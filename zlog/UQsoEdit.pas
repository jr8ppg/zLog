unit UQsoEdit;

interface

uses
  WinApi.Windows, WinApi.Messages, System.SysUtils, System.Classes, Vcl.Forms,
  UzLogGlobal, UzLogQSO, UzLogConst, UGeneralMulti2;

type
  TBasicEdit = class
  public
    ColWidths: array[0..16] of Integer;
    constructor Create(AOwner: TComponent); virtual;
    function GetNewMulti1(aQSO : TQSO) : string; virtual;
    function GetNewMulti2(aQSO: TQSO): string; virtual;
  end;

  TGeneralEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent; UseMulti2: Boolean; UseSentRST: Boolean);
    function GetNewMulti1(aQSO : TQSO) : string; override;
    function GetNewMulti2(aQSO : TQSO) : string; override;
  end;

  TPediEdit = class(TBasicEdit)
  private
  public
    constructor Create(AOwner: TComponent);
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
    constructor Create(AOwner: TComponent; UseMulti2: Boolean; UseSentRST: Boolean);
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

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 4;      // Sent RST
   ColWidths[5] := 10;     // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 3;     // multi1
   ColWidths[14] := 3;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
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

constructor TGeneralEdit.Create(AOwner: TComponent; UseMulti2: Boolean; UseSentRST: Boolean);
begin
   inherited Create(AOwner);

   // ëóêMÇmÇq
   if UseSentRST = True then begin
      ColWidths[4] := 4;
      ColWidths[4] := 10;
   end
   else begin
      ColWidths[4] := 0;
      ColWidths[4] := 0;
   end;

   // É}ÉãÉ`ÇQ
   if UseMulti2 = True then begin
      ColWidths[14] := 3;
   end
   else begin
      ColWidths[14] := 0;
   end;
end;

constructor TPediEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 4;      // Sent RST
   ColWidths[5] := 10;     // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 0;     // point
   ColWidths[13] := 0;     // multi1
   ColWidths[14] := 0;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
end;

constructor TARRLDXEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 4;      // Sent RST
   ColWidths[5] := 10;     // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 3;     // multi1
   ColWidths[14] := 3;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
end;

constructor TWWEdit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 0;      // Sent RST
   ColWidths[5] := 0;      // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 3;     // multi1
   ColWidths[14] := 3;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
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

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 4;      // Sent RST
   ColWidths[5] := 10;     // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 3;     // multi1
   ColWidths[14] := 3;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
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

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 4;      // Sent RST
   ColWidths[5] := 10;     // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 3;     // multi1
   ColWidths[14] := 3;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
end;

constructor TJA0Edit.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 4;      // Sent RST
   ColWidths[5] := 10;     // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 3;     // multi1
   ColWidths[14] := 0;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
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

constructor TSerialGeneralEdit.Create(AOwner: TComponent; UseMulti2: Boolean; UseSentRST: Boolean);
var
   colno: Integer;
begin
   inherited Create(AOwner);

   // ëóêMÇmÇq
   if UseSentRST = True then begin
      ColWidths[4] := 4;
      ColWidths[4] := 10;
   end
   else begin
      ColWidths[4] := 0;
      ColWidths[4] := 0;
   end;

   // É}ÉãÉ`ÇQ
   if UseMulti2 = True then begin
      ColWidths[14] := 3;
   end
   else begin
      ColWidths[14] := 0;
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

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 4;      // Sent RST
   ColWidths[5] := 10;     // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 6;     // multi1
   ColWidths[14] := 0;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
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

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 0;      // Sent RST
   ColWidths[5] := 0;      // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 3;     // multi1
   ColWidths[14] := 0;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
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

   ColWidths[0] := 3;      // status
   ColWidths[1] := 6;      // date
   ColWidths[2] := 6;      // time
   ColWidths[3] := 12;     // callsign
   ColWidths[4] := 0;      // Sent RST
   ColWidths[5] := 0;      // Sent Number
   ColWidths[6] := 4;      // Rcvd RST
   ColWidths[7] := 10;     // Rcvd Number
   ColWidths[8] := 4;      // band
   ColWidths[9] := 4;      // mode
   ColWidths[10] := 6;     // op
   ColWidths[11] := 7;     // memo
   ColWidths[12] := 4;     // point
   ColWidths[13] := 4;     // multi1
   ColWidths[14] := 0;     // multi2
   ColWidths[15] := 10;    // freq
   ColWidths[16] := 0;     // QSOID
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
