unit URC28;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.StdCtrls, JvComponentBase, JvHidControllerClass;

type
  TRc28Key = ( rkF1 = 1, rkF2, rkTransmit );
  TRc28DialDirection = ( ddRight = 0, ddLeft );
  TRc28DialNotifyEvent = procedure(Sender: TObject; direction: TRc28DialDirection; accelerator: Integer) of object;
  TRc28KeyEvent = procedure(Sender: TObject; key: TRc28Key) of object;

type
  TRC28 = class(TObject)
  private
    FHidDev: TJvHidDevice;
    FLedStatus: Byte;
    FKeyDownTime: array[rkF1..rkTransmit] of DWORD;
    FOnDial: TRc28DialNotifyEvent;
    FOnKeyDown: TRc28KeyEvent;
    FOnKeyUp: TRc28KeyEvent;
    FOnKeyShortPress: TRc28KeyEvent;
    FOnKeyLongPress: TRc28KeyEvent;
    FLongPressThreshold: DWORD;
    procedure DebugDump(Data: Pointer; Size: Word);
    procedure LedControl(led: Byte; fOn: Boolean);
    function GetLink(): Boolean;
    procedure SetLink(fOn: Boolean);
    function GetF1(): Boolean;
    procedure SetF1(fOn: Boolean);
    function GetF2(): Boolean;
    procedure SetF2(fOn: Boolean);
    function GetTransmit(): Boolean;
    procedure SetTransmit(fOn: Boolean);
  public
    constructor Create();
    destructor Destroy();
    procedure Open(HidDev: TJvHidDevice);
    procedure Close();
    procedure Abort();
    procedure DeviceData(const Data: Pointer; Size: Word);
    property HidDev: TJvHidDevice read FHidDev write FHidDev;
    property Link: Boolean read GetLink write SetLink;
    property F1: Boolean read GetF1 write SetF1;
    property F2: Boolean read GetF2 write SetF2;
    property Transmit: Boolean read GetTransmit write SetTransmit;
    property OnDial: TRc28DialNotifyEvent read FOnDial write FOnDial;
    property OnKeyDown: TRc28KeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TRc28KeyEvent read FOnKeyUp write FOnKeyUp;
    property OnKeyShortPress: TRc28KeyEvent read FOnKeyShortPress write FOnKeyShortPress;
    property OnKeyLongPress: TRc28KeyEvent read FOnKeyLongPress write FOnKeyLongPress;
    property LongPressThreshold: DWORD read FLongPressThreshold write FLongPressThreshold;
  end;

const
  VENDORID_ICOM = $0C26;
  PRODUCTID_RC28 = $001E;

implementation

const
  RC28_KEY_TRANSMIT = $01;
  RC28_KEY_F1 = $02;
  RC28_KEY_F2 = $04;
  RC28_KEY_TRANSMIT_MASK = (not RC28_KEY_TRANSMIT);
  RC28_KEY_F1_MASK = (not RC28_KEY_F1);
  RC28_KEY_F2_MASK = (not RC28_KEY_F2);

  RC28_LED_TRANSMIT = $01;
  RC28_LED_F1 = $02;
  RC28_LED_F2 = $04;
  RC28_LED_LINK = $08;
  RC28_LED_TRANSMIT_MASK = (not RC28_LED_TRANSMIT);
  RC28_LED_F1_MASK = (not RC28_LED_F1);
  RC28_LED_F2_MASK = (not RC28_LED_F2);
  RC28_LED_LINK_MASK = (not RC28_LED_LINK);

  RC28_LONG_KEYPRESS_TIME = 1000;

constructor TRC28.Create();
begin
   FHidDev := nil;
   FKeyDownTime[rkF1] := 0;
   FKeyDownTime[rkF2] := 0;
   FKeyDownTime[rkTransmit] := 0;
   FLedStatus := 0;
   FOnDial := nil;
   FOnKeyDown := nil;
   FOnKeyUp := nil;
   FOnKeyShortPress := nil;
   FOnKeyLongPress := nil;
   FLongPressThreshold := RC28_LONG_KEYPRESS_TIME;
end;

destructor TRC28.Destroy();
begin
   //
end;

procedure TRC28.Open(HidDev: TJvHidDevice);
begin
   FHidDev := HidDev;
   Link := True;
end;

procedure TRC28.Close();
begin
   Link := False;
   FHidDev := nil;
end;

procedure TRC28.Abort();
begin
   FHidDev := nil;
end;

procedure TRC28.DeviceData(const Data: Pointer; Size: Word);
var
   S: string;
   PortData: array[0..7] of Byte;
   accelerator: Byte;
begin
   CopyMemory(@PortData, Data, 8);

   // ダイヤル操作
   if PortData[3] > 0 then begin
      // 加速度
      accelerator := PortData[1];

      // 方向
      if PortData[3] = 1 then begin
         // RIGHT
         if Assigned(FOnDial) then begin
            FOnDial(Self, ddRight, accelerator);
         end;
         {$IFDEF DEBUG}
         OutputDebugString(PChar('右回転 加速度=' + IntToStr(accelerator)));
         {$ENDIF}
      end
      else if PortData[3] = 2 then begin
         // LEFT
         if Assigned(FOnDial) then begin
            FOnDial(Self, ddLeft, accelerator);
         end;
         {$IFDEF DEBUG}
         OutputDebugString(PChar('左回転 加速度=' + IntToStr(accelerator)));
         {$ENDIF}
      end;
   end;

   // F1 up->downに変化
   if ((PortData[5] and RC28_KEY_F1) = 0) then begin
      FKeyDownTime[rkF1] := GetTickCount();
      {$IFDEF DEBUG}
      OutputDebugString(PChar('F1 KEY DOWN'));
      {$ENDIF}
      if Assigned(FOnKeyDown) then begin
         FOnKeyDown(Self, rkF1);
      end;
   end;

   // F1 down->upに変化
   if ((PortData[5] and RC28_KEY_F1) = RC28_KEY_F1) then begin
      if FKeyDownTime[rkF1] > 0 then begin
         if Assigned(FOnKeyUp) then begin
            FOnKeyUp(Self, rkF1);
         end;
         {$IFDEF DEBUG}
         OutputDebugString(PChar('F1 KEY UP'));
         {$ENDIF}

         if (GetTickCount() - FKeyDownTime[rkF1]) < FLongPressThreshold then begin
            if Assigned(FOnKeyShortPress) then begin
               FOnKeyShortPress(Self, rkF1);
            end;
            {$IFDEF DEBUG}
            OutputDebugString(PChar('F1 SHORT KEY PRESS'));
            {$ENDIF}
         end
         else begin
            if Assigned(FOnKeyLongPress) then begin
               FOnKeyLongPress(Self, rkF1);
            end;
            {$IFDEF DEBUG}
            OutputDebugString(PChar('F1 LONG KEY PRESS'));
            {$ENDIF}
         end;
         FKeyDownTime[rkF1] := 0;
      end;
   end;

   // F2 up->downに変化
   if ((PortData[5] and RC28_KEY_F2) = 0) then begin
      FKeyDownTime[rkF2] := GetTickCount();
      {$IFDEF DEBUG}
      OutputDebugString(PChar('F2 KEY DOWN'));
      {$ENDIF}
      if Assigned(FOnKeyDown) then begin
         FOnKeyDown(Self, rkF2);
      end;
   end;

   // F2 down->upに変化
   if ((PortData[5] and RC28_KEY_F2) = RC28_KEY_F2) then begin
      if FKeyDownTime[rkF2] > 0 then begin
         if Assigned(FOnKeyUp) then begin
            FOnKeyUp(Self, rkF2);
         end;
         {$IFDEF DEBUG}
         OutputDebugString(PChar('F2 KEY UP'));
         {$ENDIF}

         if (GetTickCount() - FKeyDownTime[rkF2]) < FLongPressThreshold then begin
            if Assigned(FOnKeyShortPress) then begin
               FOnKeyShortPress(Self, rkF2);
            end;
            {$IFDEF DEBUG}
            OutputDebugString(PChar('F2 SHORT KEY PRESS'));
            {$ENDIF}
         end
         else begin
            if Assigned(FOnKeyLongPress) then begin
               FOnKeyLongPress(Self, rkF2);
            end;
            {$IFDEF DEBUG}
            OutputDebugString(PChar('F2 LONG KEY PRESS'));
            {$ENDIF}
         end;

         FKeyDownTime[rkF2] := 0;
      end;
   end;

   // TRANSMIT up->downに変化
   if ((PortData[5] and RC28_KEY_TRANSMIT) = 0) then begin
      FKeyDownTime[rkTransmit] := GetTickCount();
      {$IFDEF DEBUG}
      OutputDebugString(PChar('TRANSMIT KEY DOWN'));
      {$ENDIF}
      if Assigned(FOnKeyDown) then begin
         FOnKeyDown(Self, rkTransmit);
      end;
   end;

   // TRANSMIT down->upに変化
   if ((PortData[5] and RC28_KEY_TRANSMIT) = RC28_KEY_TRANSMIT) then begin
      if FKeyDownTime[rkTransmit] > 0 then begin
         if Assigned(FOnKeyUp) then begin
            FOnKeyUp(Self, rkTransmit);
         end;
         {$IFDEF DEBUG}
         OutputDebugString(PChar('TRANSMIT KEY UP'));
         {$ENDIF}

         if (GetTickCount() - FKeyDownTime[rkTransmit]) < FLongPressThreshold then begin
            if Assigned(FOnKeyShortPress) then begin
               FOnKeyShortPress(Self, rkTransmit);
            end;
            {$IFDEF DEBUG}
            OutputDebugString(PChar('TRANSMIT SHORT KEY PRESS'));
            {$ENDIF}
         end
         else begin
            if Assigned(FOnKeyLongPress) then begin
               FOnKeyLongPress(Self, rkTransmit);
            end;
            {$IFDEF DEBUG}
            OutputDebugString(PChar('TRANSMIT LONG KEY PRESS'));
            {$ENDIF}
         end;

         FKeyDownTime[rkTransmit] := 0;
      end;
   end;
end;

function TRC28.GetLink(): Boolean;
begin
   Result := (FLedStatus and RC28_LED_LINK) = RC28_LED_LINK;
end;

procedure TRC28.SetLink(fOn: Boolean);
begin
   LedControl(RC28_LED_LINK, fOn);
end;

function TRC28.GetF1(): Boolean;
begin
   Result := (FLedStatus and RC28_LED_F1) = RC28_LED_F1;
end;

procedure TRC28.SetF1(fOn: Boolean);
begin
   LedControl(RC28_LED_F1, fOn);
end;

function TRC28.GetF2(): Boolean;
begin
   Result := (FLedStatus and RC28_LED_F2) = RC28_LED_F2;
end;

procedure TRC28.SetF2(fOn: Boolean);
begin
   LedControl(RC28_LED_F2, fOn);
end;

function TRC28.GetTransmit(): Boolean;
begin
   Result := (FLedStatus and RC28_LED_TRANSMIT) = RC28_LED_TRANSMIT;
end;

procedure TRC28.SetTransmit(fOn: Boolean);
begin
   LedControl(RC28_LED_TRANSMIT, fOn);
end;

procedure TRC28.LedControl(led: Byte; fOn: Boolean);
var
   BR: DWORD;
   OutReport: array[0..64] of Byte;
   key: Byte;
begin
   if fOn = True then begin
      FLedStatus := FLedStatus or led;
   end
   else begin
      FLedStatus := FLedStatus and (not led);
   end;

   if FHidDev = nil then begin
      Exit;
   end;

   key := (not FLedStatus) and $0F;

   ZeroMemory(@OutReport, SizeOf(OutReport));
   OutReport[0] := 0;
   OutReport[1] := $01;
   OutReport[2] := key;
   FHidDev.WriteFile(OutReport, FHidDev.Caps.OutputReportByteLength, BR);
end;

procedure TRC28.DebugDump(Data: Pointer; Size: Word);
var
   S: string;
   P: PByte;
   i: Integer;
   c: Integer;
begin
   P := Data;

   S := 'Data Size=' + IntToStr(Size);
   OutputDebugString(PChar(S));

   S := '-ADDR- +0 +1 +2 +3 +4 +5 +6 +7 +8 +9 +A +B +C +D +E +F';
   OutputDebugString(PChar(S));

   S := IntToHex(0, 6) + ' ';
   c := 0;
   for i := 0 to Size - 1 do begin
      S := S + IntToHex(P^, 2) + ' ';

      Inc(c);
      if c = 16 then begin
         OutputDebugString(PChar(S));
         c := 0;
         S := IntToHex(i + 1, 6) + ' ';
      end;

      Inc(P);
   end;
   OutputDebugString(PChar(S));
end;

end.

