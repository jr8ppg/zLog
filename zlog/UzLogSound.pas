unit UzLogSound;

interface

{
  references:

  Programming reference for the Win32 API
  https://docs.microsoft.com/en-us/windows/win32/api/

  Windows Multimedia
  https://docs.microsoft.com/en-us/windows/win32/api/_multimedia/

  Eternal Windows
  http://eternalwindows.jp/
}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MMReg, MMSystem, ToneGen, MSACM,
  Generics.Collections, Generics.Defaults;

type
  FRAMEHEADER = packed record
    version: BYTE;         // MPEGバージョン番号
    dwBitRate: DWORD;      // ビットレート
    dwSampleRate: DWORD;   // 周波数
    padding: BYTE;         // パディングバイトの有無
    channel: BYTE;         // チャンネル数
    wFrameSize: WORD;      // フレームサイズ
  end;
  LPFRAMEHEADER = ^FRAMEHEADER;

  ID3v2Header = packed record
     id: array[0..2] of AnsiChar;
     major_version: byte;
     minor_version: byte;
     flags: byte;
     size: array[0..3] of BYTE;
  end;
  LPID3V2HEADER = ^ID3v2Header;

type
  TWaveOutCallbackProc = procedure(hwo: HWAVEOUT; uMsg: UINT; dwInstance: DWORD_PTR; dwParam1: DWORD_PTR; dwParam2: DWORD_PTR);

  TWaveSound = class(TObject)
  private
    m_lpWaveData: LPBYTE;
    m_dwWaveSize: DWORD;
    m_hwo: HWAVEOUT;
    m_wh: TWaveHdr;
    FOnOpen: TNotifyEvent;
    FOnDone: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FLoaded: Boolean;
    FPlaying: Boolean;
    FFileName: string;
    procedure ReadWaveFile(strFileName: string; lpwf: PWAVEFORMATEX; var lpData: LPBYTE; var dwDataSize: DWORD);
    function GetDecodeSize(lpMP3Data: LPBYTE; dwMP3Size: DWORD; lpwf: PWAVEFORMATEX): DWORD;
    procedure DecodeToWave(lpwfSrc: PWAVEFORMATEX; lpSrcData: LPBYTE; dwSrcSize:DWORD; lpwfDest: PWAVEFORMATEX; var lpDestData: LPBYTE; var dwDestSize: DWORD);
    procedure GetMp3Format(lpfh: LPFRAMEHEADER; lpmf: PMPEGLayer3WaveFormat);
    function GetFrameHeader(lpData: LPBYTE; lpfh: LPFRAMEHEADER): Boolean;
    function IsId3v2(lpData: LPBYTE; dwDataSize: DWORD; var dwTagSize: DWORD): Boolean;
    procedure ReadMP3File(lpszFileName: LPTSTR; lpmf: PMPEGLayer3WaveFormat; var lpData: LPBYTE; var dwSize: DWORD);
    procedure FreeWaveData();
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Open(strFileName: string; uDevceID: UINT = WAVE_MAPPER); virtual;
    procedure Play(); virtual;
    procedure Stop(); virtual;
    procedure Close(); virtual;
    class function DeviceList(): TStringList;
    class function NumDevices(): Integer;
    property IsLoaded: Boolean read FLoaded;
    property Playing: Boolean read FPlaying write FPlaying;
    property HWO: HWAVEOUT read m_hwo;
    property FileName: string read FFileName;
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnDone: TNotifyEvent read FOnDone write FOnDone;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

  TSideTone = class(TWaveSound)
    FFrequency: Integer;
    procedure SetFrequency(freq: Integer);
  public
    constructor Create(freq: Integer);
    destructor Destroy(); override;
    procedure Open(uDevceID: UINT = WAVE_MAPPER); reintroduce;
    procedure Play(); override;
    procedure Stop(); override;
    procedure Close(); override;
    property Frequency: Integer read FFrequency write SetFrequency;
  end;

  TWaveSoundList = class(TObjectList<TWaveSound>)
  public
    constructor Create(OwnsObjects: Boolean = False);
    destructor Destroy(); override;
  end;

var
  ZWaveSoundList: TWaveSoundList;

implementation

procedure ZWaveOutCallBackProc(hwo: HWAVEOUT; uMsg: UINT; dwInstance: DWORD_PTR; dwParam1: DWORD_PTR; dwParam2: DWORD_PTR); stdcall;
var
   i: Integer;
begin
   for i := 0 to ZWaveSoundList.Count - 1 do begin
      if ZWaveSoundList[i].HWO = hwo then begin
         // fire event
         if uMsg = WOM_OPEN then if Assigned(ZWaveSoundList[i].OnOpen) then ZWaveSoundList[i].OnOpen(ZWaveSoundList[i]);
         if uMsg = WOM_DONE then begin
            ZWaveSoundList[i].Playing := False;
            if Assigned(ZWaveSoundList[i].OnDone) then begin
               ZWaveSoundList[i].OnDone(ZWaveSoundList[i]);
            end;
         end;
         if uMsg = WOM_CLOSE then if Assigned(ZWaveSoundList[i].OnClose) then ZWaveSoundList[i].OnClose(ZWaveSoundList[i]);
         Break;
      end;
   end;
end;

constructor TWaveSound.Create();
begin
   Inherited;
   FPlaying := False;
   FLoaded := False;
   FFileName := '';
   FOnOpen := nil;
   FOnDone := nil;
   FOnClose := nil;
   m_lpWaveData := nil;
   m_hwo := 0;
   ZeroMemory(@m_wh, SizeOf(m_wh));

   ZWaveSoundList.Add(Self);
end;

destructor TWaveSound.Destroy();
begin
   Close();
   FreeWaveData();
   ZWaveSoundList.Remove(Self);
end;

procedure TWaveSound.ReadWaveFile(strFileName: string; lpwf: PWAVEFORMATEX; var lpData: LPBYTE; var dwDataSize: DWORD);
var
	hmm: HMMIO;
	mmckRiff: MMCKINFO;
   mmckFmt: MMCKINFO;
	mmckData: MMCKINFO;
begin
   hmm := 0;
   try
      hmm := mmioOpen(PChar(strFileName), nil, MMIO_READ);
      if hmm = 0 then begin
         raise Exception.Create('ファイルのオープンに失敗しました。');
      end;

      mmckRiff.fccType := mmioStringToFOURCC('WAVE', 0);
      if (mmioDescend(hmm, @mmckRiff, nil, MMIO_FINDRIFF) <> MMSYSERR_NOERROR) then begin
         raise Exception.Create('WAVEファイルではありません。');
      end;

      mmckFmt.ckid := mmioStringToFOURCC('fmt ', 0);
      if (mmioDescend(hmm, @mmckFmt, nil, MMIO_FINDCHUNK) <> MMSYSERR_NOERROR) then begin
         raise Exception.Create('Error in mmioDescend()');
      end;

      mmioRead(hmm, PAnsiChar(lpwf), SizeOf(TWAVEFORMATEX) {mmckFmt.cksize});
      mmioAscend(hmm, @mmckFmt, 0);
      if (lpwf^.wFormatTag <> WAVE_FORMAT_PCM) then begin
         raise Exception.Create('PCMデータではありません。');
      end;

      mmckData.ckid := mmioStringToFOURCC('data', 0);
      if (mmioDescend(hmm, @mmckData, nil, MMIO_FINDCHUNK) <> MMSYSERR_NOERROR) then begin
         raise Exception.Create('Error in mmioDescend()');
      end;

      lpData := AllocMem(mmckData.cksize * 3);  // win64-releaseでアプリケーションエラーとなるため*3してみた
      mmioRead(hmm, PAnsiChar(lpData), mmckData.cksize);
      mmioAscend(hmm, @mmckData, 0);

      mmioAscend(hmm, @mmckRiff, 0);

      dwDataSize := mmckData.cksize;
   finally
      if hmm <> 0 then begin
         mmioClose(hmm, 0);
      end;
   end;
end;

class function TWaveSound.DeviceList(): TStringList;
var
   i, n: UINT;
   info: WaveOutCaps;
   L: TStringList;
begin
   L := TStringList.Create();
   try
      n := waveOutGetNumDevs();
      for i := 1 to n do begin
         waveOutGetDevCaps(i - 1, @info, SizeOf(info));
         L.Add(string(info.szPname));
      end;
   finally
      Result := L;
   end;
end;

class function TWaveSound.NumDevices(): Integer;
begin
   Result := waveOutGetNumDevs();
end;

function TWaveSound.GetDecodeSize(lpMP3Data: LPBYTE; dwMP3Size: DWORD; lpwf: PWAVEFORMATEX): DWORD;
var
	dwFrameCount: DWORD;
	dwDecodeSize: DWORD;
	lp: LPBYTE;
	dwOffset: DWORD;
	dwFlags: DWORD;
	fh: FRAMEHEADER;
	dSecond: Double;
begin
	GetFrameHeader(lpMP3Data, @fh);

	if (fh.channel = 1) then begin
		dwOffset := 17;
   end
	else begin
		dwOffset := 31;
   end;

	lp := lpMP3Data + dwOffset + 4;
	if ((PAnsiChar(lp) + 0)^ = 'X') or ((PAnsiChar(lp) + 1)^ = 'i') or ((PAnsiChar(lp) + 2)^ = 'n') or ((PAnsiChar(lp) + 3)^ = 'g') then begin
		lp := lp + 4;
		dwFlags := (lp + 3)^ or ((lp + 2)^ shl 8) or ((lp + 1)^ shl 16) or ((lp + 0)^ shl 24);
		if (dwFlags and $0001) = $0001 then begin
			lp := lp + 4;
			dwFrameCount := (lp + 3)^ or ((lp + 2)^ shl 8) or ((lp + 1)^ shl 16) or ((lp + 0)^ shl 24);
		end
		else begin
			dwFrameCount := 0;
		end;
	end
	else begin
		dwFrameCount := 0;
		dwOffset := 0;
		while (dwMP3Size > dwOffset) do begin
			if (GetFrameHeader(lpMP3Data + dwOffset, @fh)) then begin
				Inc(dwFrameCount);
				dwOffset := dwOffset + fh.wFrameSize;
			end
			else begin
				Inc(dwOffset);
			end;
		end;
	end;

	dSecond := (dwFrameCount * Double(1152 / Double(lpwf^.nSamplesPerSec)));
	dwDecodeSize := Trunc(lpwf^.nAvgBytesPerSec * dSecond);

	Result := dwDecodeSize;
end;

procedure TWaveSound.DecodeToWave(lpwfSrc: PWAVEFORMATEX; lpSrcData: LPBYTE; dwSrcSize:DWORD; lpwfDest: PWAVEFORMATEX; var lpDestData: LPBYTE; var dwDestSize: DWORD);
var
	has: HACMSTREAM;
	ash: TACMSTREAMHEADER;
	bResult: Boolean;
begin
	lpwfDest^.wFormatTag := WAVE_FORMAT_PCM;
	acmFormatSuggest(0, lpwfSrc, lpwfDest, sizeof(TWAVEFORMATEX), ACM_FORMATSUGGESTF_WFORMATTAG);

	if (acmStreamOpen(@has, 0, lpwfSrc, lpwfDest, nil, 0, 0, ACM_STREAMOPENF_NONREALTIME) <> 0) then begin
		raise Exception.Create('変換ストリームのオープンに失敗しました。');
	end;

   dwDestSize := GetDecodeSize(lpSrcData, dwSrcSize, lpwfDest);
	lpDestData := AllocMem(dwDestSize);

	ZeroMemory(@ash, sizeof(TACMSTREAMHEADER));
	ash.cbStruct    := sizeof(TACMSTREAMHEADER);
	ash.pbSrc       := lpSrcData;
	ash.cbSrcLength := dwSrcSize;
	ash.pbDst       := lpDestData;
	ash.cbDstLength := dwDestSize;

	acmStreamPrepareHeader(has, ash, 0);
	bResult := acmStreamConvert(has, ash, 0) = 0;
	acmStreamUnprepareHeader(has, ash, 0);

	acmStreamClose(has, 0);

	if (bResult) then begin
//		lpDestData := lpBuffer;
		dwDestSize := ash.cbDstLengthUsed;
	end
	else begin
		FreeMem(lpDestData);
		lpDestData := nil;
		dwDestSize := 0;
		raise Exception.Create('変換に失敗しました。');
	end;
end;

function TWaveSound.IsId3v2(lpData: LPBYTE; dwDataSize: DWORD; var dwTagSize: DWORD): Boolean;
var
   bResult: Boolean;
   lp: PAnsiChar;
   lpHeader: LPID3V2HEADER;
begin
	lpHeader := LPID3V2HEADER(lpData);

	if (lpHeader^.id[0] = 'I') and (lpHeader^.id[1] = 'D') and (lpHeader^.id[2] = '3') then begin
		dwTagSize := ((lpHeader^.size[0] shl 21) or (lpHeader^.size[1] shl 14) or (lpHeader^.size[2] shl 7) or (lpHeader^.size[3])) + 10;
		bResult := True;
	end
	else begin
		lp := PAnsiChar(lpData + dwDataSize) - 128;
		if ((lp + 0)^ = 'T') and ((lp + 1)^ = 'A') and ((lp + 2)^ = 'G') then begin
			dwTagSize := 128;
      end
		else begin
			dwTagSize := 0;
      end;

		bResult := False;
	end;

	Result := bResult;
end;

function TWaveSound.GetFrameHeader(lpData: LPBYTE; lpfh: LPFRAMEHEADER): Boolean;
var
	index: BYTE;
	version: BYTE;
	channel: BYTE;
	padding: BYTE;
	wFrameSize: WORD;
	dwBitRate: DWORD;
	dwSampleRate: DWORD;
const
	dwBitTableLayer3: array[0..1, 0..15] of DWORD = (
		( 0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 0 ),
		( 0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, 0 )
	);

	dwSampleTable: array[0..1, 0..2] of DWORD = (
		( 44100, 48000, 32000 ),
		( 22050, 24000, 16000 )
	);
begin
	if ((lpData + 0)^ <> $ff) or (((lpData + 1)^ shr 5) <> $07) then begin
      Result := False;
      Exit;
   end;

	case (((lpData + 1)^ shr 3) and $03) of
	   3: version := 1;
      2: version := 2;
	   else begin
         Result := False;
         Exit;
      end;
   end;

	if ((((lpData + 1)^ shr 1) and $03) <> 1) then begin
      Result := False;
      Exit;
   end;

	index     := (lpData + 2)^ shr 4;
	dwBitRate := dwBitTableLayer3[version - 1][index];

	index        := ((lpData + 2)^ shr 2) and $03;
	dwSampleRate := dwSampleTable[version - 1][index];

	padding := ((lpData + 2)^ shr 1) and $01;
	if ((lpData + 3)^ shr 6) = 3 then begin
      channel := 1;
   end
   else begin
      channel := 2;
   end;

	wFrameSize := Trunc(((1152 * dwBitRate * 1000 / dwSampleRate) / 8) + padding);

	lpfh^.version      := version;
	lpfh^.dwBitRate    := dwBitRate;
	lpfh^.dwSampleRate := dwSampleRate;
	lpfh^.padding      := padding;
	lpfh^.channel      := channel;
	lpfh^.wFrameSize   := wFrameSize;

	Result := True;
end;

procedure TWaveSound.GetMp3Format(lpfh: LPFRAMEHEADER; lpmf: PMPEGLayer3WaveFormat);
begin
	lpmf^.wfx.wFormatTag      := WAVE_FORMAT_MPEGLAYER3;
	lpmf^.wfx.nChannels       := lpfh^.channel;
	lpmf^.wfx.nSamplesPerSec  := lpfh^.dwSampleRate;
	lpmf^.wfx.nAvgBytesPerSec := Trunc((lpfh^.dwBitRate * 1000) / 8);
	lpmf^.wfx.nBlockAlign     := 1;
	lpmf^.wfx.wBitsPerSample  := 0;
	lpmf^.wfx.cbSize          := MPEGLAYER3_WFX_EXTRA_BYTES;

	lpmf^.wID                 := MPEGLAYER3_ID_MPEG;
   if (lpfh^.padding <> 0) then begin
   	lpmf^.fdwFlags         := MPEGLAYER3_FLAG_PADDING_ON;
   end
   else begin
   	lpmf^.fdwFlags         := MPEGLAYER3_FLAG_PADDING_OFF;
   end;
	lpmf^.nBlockSize          := lpfh^.wFrameSize;
	lpmf^.nFramesPerBlock     := 1;
	lpmf^.nCodecDelay         := $0571;
end;

procedure TWaveSound.ReadMP3File(lpszFileName: LPTSTR; lpmf: PMPEGLayer3WaveFormat; var lpData: LPBYTE; var dwSize: DWORD);
var
   lpBuffer: LPBYTE;
   dwBuffer: DWORD;
   dwTagSize: DWORD;
	mmio: HMMIO;
   lpMp3Data: LPBYTE;
   fh: FRAMEHEADER;
begin
	mmio := mmioOpen(lpszFileName, nil, MMIO_READ);
	if mmio = 0 then begin
		raise Exception.Create('ファイルのオープンに失敗しました。');
	end;

   // MP3ファイルロード
   dwBuffer := mmioSeek(mmio, 0, SEEK_END);
	lpBuffer := AllocMem(dwBuffer);
	mmioSeek(mmio, 0, SEEK_SET);
	mmioRead(mmio, PAnsiChar(lpBuffer), dwBuffer);
	mmioClose(mmio, 0);

	if IsId3v2(lpBuffer, dwBuffer, dwTagSize) = True then begin
		dwBuffer := dwBuffer - dwTagSize;
		lpMp3Data := AllocMem(dwBuffer);
		CopyMemory(lpMp3Data, lpBuffer + dwTagSize, dwBuffer);
		FreeMem(lpBuffer);
	end
	else begin
		dwBuffer := dwBuffer - dwTagSize;
		lpMp3Data := lpBuffer;
	end;

	if GetFrameHeader(lpMp3Data, @fh) = False then begin
		FreeMem(lpMp3Data);
		raise Exception.Create('Error in GetFrameHeader()');
	end;

	GetMp3Format(@fh, lpmf);

	lpData := lpMp3Data;
	dwSize := dwBuffer;
end;

procedure TWaveSound.FreeWaveData();
begin
   if (m_lpWaveData <> nil) then begin
      FreeMem(m_lpWaveData);
      m_lpWaveData := nil;
   end;
end;

procedure TWaveSound.Open(strFileName: string; uDevceID: UINT);
var
	wf: TWAVEFORMATEX;
   strExt: string;
   lpMP3Data: LPBYTE;
   dwMP3Size: DWORD;
   mf: MPEGLAYER3WAVEFORMAT;
begin
   try
      FreeWaveData();

      strExt := UpperCase(ExtractFileExt(strFileName));
      if strExt = '.WAV' then begin
         ReadWaveFile(strFileName, @wf, m_lpWaveData, m_dwWaveSize);
      end
      else if strExt = '.MP3' then begin
         // MP3リード
         ReadMP3File(PChar(strFileName), @mf, lpMP3Data, dwMP3Size);

         // WAVEに変換
		   DecodeToWave(@mf, lpMP3Data, dwMP3Size, @wf, m_lpWaveData, m_dwWaveSize);

			FreeMem(lpMP3Data);
      end
      else begin
         raise Exception.Create('対応していないファイルです(' + strExt + ')');
      end;

      if (waveOutOpen(@m_hwo, uDevceID, @wf, DWORD_PTR(@ZWaveOutCallBackProc), 0, CALLBACK_FUNCTION) <> MMSYSERR_NOERROR) then begin
         raise Exception.Create('WAVEデバイスのオープンに失敗しました。');
      end;

      m_wh.lpData         := PAnsiChar(m_lpWaveData);
      m_wh.dwBufferLength := m_dwWaveSize;
      m_wh.dwFlags        := 0;

      waveOutPrepareHeader(m_hwo, @m_wh, sizeof(m_wh));

      FLoaded := True;
   except
      Close();
      raise;
   end;
end;

procedure TWaveSound.Play();
begin
   if FLoaded = False then begin
      Exit;
   end;

   waveOutWrite(m_hwo, @m_wh, sizeof(m_wh));
   FPlaying := True;
end;

procedure TWaveSound.Stop();
begin
   if m_hwo = 0 then begin
      Exit;
   end;
   if FLoaded = False then begin
      Exit;
   end;

   waveOutReset(m_hwo);
end;

procedure TWaveSound.Close();
begin
   FLoaded := False;
   FFileName := '';
   if m_hwo = 0 then begin
      Exit;
   end;
   waveOutReset(m_hwo);
	waveOutUnprepareHeader(m_hwo, @m_wh, sizeof(m_wh));
	waveOutClose(m_hwo);
   FreeWaveData();
   m_hwo := 0;
end;

constructor TSideTone.Create(freq: Integer);
begin
   Inherited Create();
   FFrequency := freq;
end;

destructor TSideTone.Destroy();
begin
   Inherited;
end;

procedure TSideTone.Open(uDevceID: UINT);
var
   FTone: TToneGen;
   mem: TMemoryStream;
   pwavheader: PTWavHeader;
   pwavdata: LPBYTE;
	wf: TWAVEFORMATEX;
begin
   mem := TMemoryStream.Create();
   FTone := TToneGen.Create(nil);
   try
      FreeWaveData();

      // Toneをメモリー上に作成
      FTone.Waveform := tgSine;
      FTone.Duration := 1000;
      FTone.Loop := True;
      FTone.Frequency := FFrequency;
      FTone.Prepare();
      FTone.SaveToStream(mem);

      // メモリー上に保存したToneのWAVEデータから
      // waveOutの準備を行う
      pwavheader := mem.Memory;
      pwavdata := LPBYTE(mem.Memory) + SizeOf(TWavHeader);

      // WAVE FILE HEADERの次からがWAVEデータ本体
      m_lpWaveData := AllocMem(pwavheader^.wSampleLength);
      m_dwWaveSize := pwavheader^.wSampleLength;
      CopyMemory(m_lpWaveData, pwavdata, m_dwWaveSize);

      // デバイスオープン用WAVEFORMATEXの準備
      wf.wFormatTag        := pwavheader^.wFormatTag;
      wf.nChannels         := pwavheader^.nChannels;
      wf.nSamplesPerSec    := pwavheader^.nSamplesPerSec;
      wf.nAvgBytesPerSec   := pwavheader^.nAvgBytesPerSec;
      wf.nBlockAlign       := pwavheader^.nBlockAlign;
      wf.wBitsPerSample    := pwavheader^.wBitsPerSample;

      if (waveOutOpen(@m_hwo, uDevceID, @wf, 0, 0, CALLBACK_NULL) <> MMSYSERR_NOERROR) then begin
         raise Exception.Create('WAVEデバイスのオープンに失敗しました。');
      end;

      // WAVEHDRへの展開(Prepare)
      ZeroMemory(@m_wh, SizeOf(m_wh));
      m_wh.lpData          := PAnsiChar(m_lpWaveData);
      m_wh.dwBufferLength  := m_dwWaveSize;
      m_wh.dwFlags         := 0;

      waveOutPrepareHeader(m_hwo, @m_wh, sizeof(m_wh));

      FLoaded := True;
   finally
      mem.Free();
      FTone.Free();
   end;
end;

procedure TSideTone.Play();
begin
   Inherited;
end;

procedure TSideTone.Stop();
begin
   Inherited;
end;

procedure TSideTone.Close();
begin
   Inherited;
end;

procedure TSideTone.SetFrequency(freq: Integer);
begin
   FFrequency := freq;
   Close();
   Open();
end;

{ TWaveSoundList }

constructor TWaveSoundList.Create(OwnsObjects: Boolean);
begin
   Inherited Create(OwnsObjects);
end;

destructor TWaveSoundList.Destroy();
begin
   Inherited;
end;

initialization
   ZWaveSoundList := TWaveSoundList.Create();

finalization
   ZWaveSoundList.Free();

end.
