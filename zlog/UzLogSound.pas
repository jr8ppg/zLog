unit UzLogSound;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, MMSystem, ToneGen, MSACM;

type
  MPEGLAYER3WAVEFORMAT = record
    wfx: TWAVEFORMATEX;
    wID: WORD;
    fdwFlags: DWORD;
    nBlockSize: WORD;
    nFramesPerBlock: WORD;
    nCodecDelay: WORD;
  end;
  PMPEGLAYER3WAVEFORMAT = ^MPEGLAYER3WAVEFORMAT;
  LPMPEGLAYER3WAVEFORMAT = ^MPEGLAYER3WAVEFORMAT;

  LPLPBYTE = ^LPBYTE;

const
  WAVE_FORMAT_MPEGLAYER3 = $0055;

type
  TWaveSound = class(TObject)
  private
    m_lpWaveData: LPBYTE;
    m_hwo: HWAVEOUT;
    m_wh: TWaveHdr;
    procedure ReadWaveFile(strFileName: string; lpwf: PWAVEFORMATEX; var lpData: LPBYTE; var dwDataSize: DWORD);
//    procedure ReadWaveFile(strFileName: string; lpwf: PWAVEFORMATEX; lplpData: LPLPBYTE; lpdwDataSize: LPDWORD);
    procedure DecodeToWave(lpwfSrc: PWAVEFORMATEX; lpSrcData: LPBYTE; dwSrcSize:DWORD; lpwfDest: PWAVEFORMATEX; lplpDestData: LPLPBYTE; lpdwDestSize: LPDWORD);
    procedure ReadMP3File(lpszFileName: LPTSTR; lpmf: LPMPEGLAYER3WAVEFORMAT; lplpData: LPLPBYTE; lpdwSize: LPDWORD);
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Open(strFileName: string); virtual;
    procedure Play(); virtual;
    procedure Stop(); virtual;
    procedure Close(); virtual;
    function DeviceList(): TStringList;
  end;

  TWaveOutCallbackProc = procedure(hwo: HWAVEOUT; uMsg: UINT; dwInstance: DWORD_PTR; dwParam1: DWORD_PTR; dwParam2: DWORD_PTR);

  TSideTone = class(TWaveSound)
    FToneFile: string;
    FFrequency: Integer;
    procedure SetFrequency(freq: Integer);
  public
    constructor Create(freq: Integer);
    destructor Destroy(); override;
    procedure Open(); reintroduce;
    procedure Play(); override;
    procedure Stop(); override;
    procedure Close(); override;
    property Frequency: Integer read FFrequency write SetFrequency;
  end;

implementation

constructor TWaveSound.Create();
begin
   Inherited;
   m_lpWaveData := nil;
   m_hwo := 0;
   ZeroMemory(@m_wh, SizeOf(m_wh));
end;

destructor TWaveSound.Destroy();
begin
   Close();
	if (m_lpWaveData <> nil) then begin
         FreeMem(m_lpWaveData);
//         HeapFree(GetProcessHeap(), 0, m_lpWaveData);
         m_lpWaveData := nil;
   end;
end;

procedure TWaveSound.ReadWaveFile(strFileName: string; lpwf: PWAVEFORMATEX; var lpData: LPBYTE; var dwDataSize: DWORD);
var
	hmm: HMMIO;
	mmckRiff: MMCKINFO;
   mmckFmt: MMCKINFO;
	mmckData: MMCKINFO;
//	lpData: LPBYTE;
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
//      lpData := HeapAlloc(GetProcessHeap(), 0, mmckData.cksize);
      mmioRead(hmm, PAnsiChar(lpData), mmckData.cksize);
      mmioAscend(hmm, @mmckData, 0);

      mmioAscend(hmm, @mmckRiff, 0);

//      lplpData^ := lpData;
//      lpdwDataSize^ := mmckData.cksize;
      dwDataSize := mmckData.cksize;
   finally
      if hmm <> 0 then begin
         mmioClose(hmm, 0);
      end;
   end;
end;

function TWaveSound.DeviceList(): TStringList;
var
   i, n: UINT;
   info: WaveOutCaps;
   L: TStringList;
begin
   L := TStringList.Create();
   try
      n := waveOutGetNumDevs();
      for i := 0 to n - 1 do begin
         waveOutGetDevCaps(i, @info, SizeOf(info));
         L.Add(string(info.szPname));
      end;
   finally
      Result := L;
   end;
end;

procedure TWaveSound.DecodeToWave(lpwfSrc: PWAVEFORMATEX; lpSrcData: LPBYTE; dwSrcSize:DWORD; lpwfDest: PWAVEFORMATEX; lplpDestData: LPLPBYTE; lpdwDestSize: LPDWORD);
var
	has: HACMSTREAM;
	ash: TACMSTREAMHEADER;
	lpDestData: LPBYTE;
	dwDestSize: DWORD;
	bResult: Boolean;
begin
	lpwfDest^.wFormatTag := WAVE_FORMAT_PCM;
	acmFormatSuggest(0, lpwfSrc, lpwfDest, sizeof(TWAVEFORMATEX), ACM_FORMATSUGGESTF_WFORMATTAG);

	if (acmStreamOpen(@has, 0, lpwfSrc, lpwfDest, nil, 0, 0, ACM_STREAMOPENF_NONREALTIME) <> 0) then begin
		raise Exception.Create('変換ストリームのオープンに失敗しました。');
	end;

	acmStreamSize(has, dwSrcSize, dwDestSize, ACM_STREAMSIZEF_SOURCE);
	lpDestData := HeapAlloc(GetProcessHeap(), 0, dwDestSize);

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
		lplpDestData^ := lpDestData;
		lpdwDestSize^ := ash.cbDstLengthUsed;
	end
	else begin
		lplpDestData^ := nil;
		lpdwDestSize^ := 0;
		HeapFree(GetProcessHeap(), 0, lpDestData);
		raise Exception.Create('変換に失敗しました。');
	end;
end;

procedure TWaveSound.ReadMP3File(lpszFileName: LPTSTR; lpmf: LPMPEGLAYER3WAVEFORMAT; lplpData: LPLPBYTE; lpdwSize: LPDWORD);
var
	mmio: HMMIO;
	mmr: MMRESULT;
	mmckRiff: MMCKINFO;
	mmckFmt: MMCKINFO;
   mmckData: MMCKINFO;
begin
	mmio := mmioOpen(lpszFileName, nil, MMIO_READ);
	if mmio = 0 then begin
		raise Exception.Create('ファイルのオープンに失敗しました。');
	end;

	mmckRiff.fccType := mmioStringToFOURCC('WAVE', 0);
	mmr := mmioDescend(mmio, @mmckRiff, nil, MMIO_FINDRIFF);
	if (mmr <> MMSYSERR_NOERROR) then begin
		mmioClose(mmio, 0);
		raise Exception.Create('Error in mmioDescend()');
	end;

	mmckFmt.ckid := mmioStringToFOURCC('fmt ', 0);
	mmioDescend(mmio, @mmckFmt, @mmckRiff, MMIO_FINDCHUNK);
	mmioRead(mmio, PAnsiChar(lpmf), mmckFmt.cksize);
	mmioAscend(mmio, @mmckFmt, 0);
	if (lpmf^.wfx.wFormatTag <> WAVE_FORMAT_MPEGLAYER3) then begin
		mmioClose(mmio, 0);
		raise Exception.Create('RIFF/WAVE形式のMP3ファイルではありません。');
	end;

	mmckData.ckid := mmioStringToFOURCC('data', 0);
	mmioDescend(mmio, @mmckData, @mmckRiff, MMIO_FINDCHUNK);
	lplpData^ := HeapAlloc(GetProcessHeap(), 0, mmckData.cksize);
	mmioRead(mmio, PAnsiChar(lplpData^), mmckData.cksize);
	mmioAscend(mmio, @mmckData, 0);

	mmioAscend(mmio, @mmckRiff, 0);
	mmioClose(mmio, 0);

	lpdwSize^ := mmckData.cksize;
end;

procedure TWaveSound.Open(strFileName: string);
var
   dwDataSize: DWORD;
	wf: TWAVEFORMATEX;
   strExt: string;
begin
   try
      if (m_lpWaveData <> nil) then begin
         FreeMem(m_lpWaveData);
//         HeapFree(GetProcessHeap(), 0, m_lpWaveData);
         m_lpWaveData := nil;
      end;

      strExt := UpperCase(ExtractFileExt(strFileName));
      if strExt = '.WAV' then begin
         ReadWaveFile(strFileName, @wf, m_lpWaveData, dwDataSize);
      end
      else if strExt = '.MP3' then begin
         // MP3リード

         // WAVEに変換

         // WAVEリード
         ReadWaveFile(strFileName, @wf, m_lpWaveData, dwDataSize);
      end
      else begin
         raise Exception.Create('対応していないファイルです(' + strExt + ')');
      end;

      if (waveOutOpen(@m_hwo, WAVE_MAPPER, @wf, 0, 0, CALLBACK_NULL) <> MMSYSERR_NOERROR) then begin
         raise Exception.Create('WAVEデバイスのオープンに失敗しました。');
      end;

      m_wh.lpData         := PAnsiChar(m_lpWaveData);
      m_wh.dwBufferLength := dwDataSize;
      m_wh.dwFlags        := 0;

      waveOutPrepareHeader(m_hwo, @m_wh, sizeof(m_wh));
   except
      on E: Exception do begin
         Close();
         raise E;
      end;
   end;
end;

procedure TWaveSound.Play();
begin
   waveOutWrite(m_hwo, @m_wh, sizeof(m_wh));
end;

procedure TWaveSound.Stop();
begin
   waveOutReset(m_hwo);
end;

procedure TWaveSound.Close();
begin
   if m_hwo = 0 then begin
      Exit;
   end;
   waveOutReset(m_hwo);
	waveOutUnprepareHeader(m_hwo, @m_wh, sizeof(m_wh));
	waveOutClose(m_hwo);
   m_hwo := 0;
end;

constructor TSideTone.Create(freq: Integer);
begin
   Inherited Create();
   FFrequency := freq;
   FToneFile := '';
end;

destructor TSideTone.Destroy();
begin
   Inherited;
end;

procedure TSideTone.Open();
var
   FTone: TToneGen;
   szTempFile: array[0..MAX_PATH] of Char;
   dtNow: TDateTime;
begin
   if FToneFile = '' then begin
      dtNow := Now;
      ZeroMemory(@szTempFile, SizeOf(szTempFile));
      GetTempFileName(PChar(ExtractFilePath(Application.ExeName)), PChar('zcw'), Trunc(dtNow), @szTempFile);
      FToneFile := ChangeFileExt(szTempFile, '.wav');
   end;

   FTone := TToneGen.Create(nil);
   FTone.Waveform := tgSine;
   FTone.Duration := 1000;
   FTone.Loop := True;
   FTone.Frequency := FFrequency;
   FTone.Prepare();
   FTone.ExportFile(FToneFile);

   Inherited Open(FToneFile);

   FTone.Free();
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

   if FileExists(FToneFile) = True then begin
      DeleteFile(FToneFile);
   end;
end;

procedure TSideTone.SetFrequency(freq: Integer);
begin
   FFrequency := freq;
   Close();
   Open();
end;

end.
