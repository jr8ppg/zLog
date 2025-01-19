unit UParallelPort;

interface

uses
  Vcl.Forms, Winapi.Windows, System.SysUtils, System.Classes, FTD2XX;

type
  TParallelPort = class
  private
    FHandle: FT_HANDLE;
    FDeviceList: TStringList;
    FDeviceIndex: Integer;
    FLastError: FT_STATUS;
    FPortData: Byte;
    function GetLastErrorText(): string;
  public
    constructor Create();
    destructor Destroy(); override;
    function Initialize(): Boolean;
    function Open(): Boolean;
    procedure Close();
    function GetBit(no: Integer): Boolean;
    procedure SetBit(no: Integer);
    procedure ResetBit(no: Integer);
    procedure Flush();
    procedure Write();
    procedure Read();
    class function IsParallelPortPresent(): Boolean;
    property DeviceList: TStringList read FDeviceList;
    property DeviceIndex: Integer read FDeviceIndex;
    property LastError: FT_STATUS read FLastError;
    property LastErrorText: string read GetLastErrorText;
  end;

var
   ParallelPortInitialized: Boolean;

const
   bitpattern: array[0..7] of Byte = ( $01, $02, $04, $08, $10, $20, $40, $80 );

implementation

class function TParallelPort.IsParallelPortPresent(): Boolean;
begin
   Result := IsFTD2XXLoaded() and ParallelPortInitialized;
end;

constructor TParallelPort.Create();
begin
   FHandle := 0;
   FDeviceList := TStringList.Create();
   FDeviceIndex := -1;
end;

destructor TParallelPort.Destroy();
begin
   FDeviceList.Free();
end;

function TParallelPort.Initialize(): Boolean;
var
   nResult: FT_STATUS;
   numDeviceCount: DWORD;
   i: Integer;
   szBuffer: array[0..63] of AnsiChar;
   S: string;
   c: Integer;
begin
   ParallelPortInitialized := False;

   if IsFTD2XXLoaded() = False then begin
      Exit;
   end;

   FDeviceList.Clear();

   // デバイス数を数える
   nResult := FT_GetNumDevices(@numDeviceCount, Nil, FT_LIST_NUMBER_ONLY);
   if nResult <> FT_OK then begin
      FLastError := nResult;
      Result := False;
      Exit;
   end;

   if numDeviceCount = 0 then begin
      FLastError := -1;
      Result := False;
      Exit;
   end;

   // デバイス名を取得する
   for i := 0 to numDeviceCount - 1 do begin
      c := 0;
      repeat
         ZeroMemory(@szBuffer, SizeOf(szBuffer));
         nResult := FT_ListDevices(i, @szBuffer, (FT_OPEN_BY_DESCRIPTION or FT_LIST_BY_INDEX));
         if nResult = FT_OK then begin
            S := AnsiString(szBuffer);
            FDeviceList.Add(S);
            {$IFDEF DEBUG}
            // USB抜き差し後最初の検出に37回リトライ
            OutputDebugString(PChar('device found [' + S + '] retry=' + IntToStr(c)));
            {$ENDIF}
            Break;
         end;
         Inc(c);
         Application.ProcessMessages();
         Sleep(100);
      until (nResult = FT_OK) or (c > 50);
   end;

   {$IFDEF DEBUG}
   OutputDebugString(PChar('--- FT245RL DeviceList --- (' + IntToStr(FDeviceList.Count) + ') ---'));
   for i := 0 to FDeviceList.Count - 1 do begin
      OutputDebugString(PChar('[' + FDeviceList[i] + ']'));
   end;
   {$ENDIF}

   // デバイス名が取得できていなかったら終わり
   if FDeviceList.Count = 0 then begin
      Result := False;
      Exit;
   end;

   // FT245RLがあるか？
   FDeviceIndex := FDeviceList.IndexOf(FT_DEVICE_NAME);
   if FDeviceIndex = -1 then begin
      FLastError := -2;
      Result := False;
      Exit;
   end;

   FLastError := 0;
   ParallelPortInitialized := True;
   Result := True;
end;

function TParallelPort.Open(): Boolean;
var
   nResult: FT_STATUS;
begin
   if FDeviceIndex = -1 then begin
      //EnumDevice();
   end;

   // ポートオープン
   FHandle := 0;
   nResult := FT_Open(FDeviceIndex, @FHandle);
   if nResult <> FT_OK then begin
      FLastError := nResult;
      Result := False;
      Exit;
   end;

   // 全ビットを出力モードにする
   nResult := FT_SetBitMode(FHandle, $FF, 1);
   if nResult <> FT_OK then begin
      FLastError := nResult;
      Result := False;
      Exit;
   end;

   // いったん全部OFF
   FPortData := $00;
   Write();

   // 初期リード
   Read();

   Result := True;
end;

procedure TParallelPort.Close();
begin
   if FHandle <> 0 then begin
      FT_Close(FHandle);
      FHandle := 0;
   end;
end;

procedure TParallelPort.Write();
var
   nResult: FT_STATUS;
   dwBytesWritten: DWORD;
begin
   nResult := FT_Write(FHandle, @FPortData, 1, @dwBytesWritten);
   if nResult <> FT_OK then begin
      FLastError := nResult;
      Exit;
   end;
   FLastError := 0;
end;

procedure TParallelPort.Read();
var
   nResult: FT_STATUS;
   buf: array[0..3] of Byte;
   dwBytesReturned: DWORD;
begin
   ZeroMemory(@buf, SizeOf(buf));

   nResult := FT_Read(FHandle, @buf, 1, @dwBytesReturned);
   if nResult <> FT_OK then begin
      FLastError := nResult;
      Exit;
   end;

   FPortData := buf[0];
   FLastError := 0;
end;

function TParallelPort.GetBit(no: Integer): Boolean;
begin
   Result := (FPortData and bitpattern[no]) = bitpattern[no];
end;

procedure TParallelPort.SetBit(no: Integer);
begin
   FPortData := FPortData or bitpattern[no];
end;

procedure TParallelPort.ResetBit(no: Integer);
begin
   FPortData := FPortData and (not bitpattern[no]);
end;

procedure TParallelPort.Flush();
begin
   Write();
end;

function TParallelPort.GetLastErrorText(): string;
begin
   Result := FT_ErrorString(FLastError);
end;

initialization
  ParallelPortInitialized := False;

end.
