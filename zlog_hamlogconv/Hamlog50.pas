unit Hamlog50;

interface

uses
  WinApi.Windows, System.SysUtils;

const
	IsQSOdata = 16;
	IsMASdata = 32;
	DbsCallDX =	IsQSOdata;
	DbsCodeDX =  (1 + IsQSOdata);
	MasCodeDX =  (2 + IsMASdata);
	MasFCodeDX = (3 + IsMASdata);
	MasFHedEDX = (4 + IsMASdata);
	DbsGlidDX =  (5 + IsQSOdata);	//	ＧＬ
	DbsNoNDX  =	 (8 + IsQSOdata);
	MasNoNDX  =  (9 + IsMASdata);
	is_DXQSO = 8;
	isCQ_CALLED = 16;   //	自局のCQで交信が始まる
	Chk1_Checked = 32;
	Chk2_Checked = 64;
	Top2Flag_57 = 57;		//	先頭からFlag1まで TQsoBuff
	Top2Flag_43 = 43;		//	先頭からFlag1で TLogData
	DX_SKIP = 256;		{ 501B 以上をスキップ }
	DUP__CHECK = 512;	{ 該当データは複数あるか？ }
	CallIndexLen = 8;	//	コールサインの８文字までインデックスをつける

	SUCCESS	 = 0;		{	成  功	}
	SUCCESS_ = 1;		{	成功・書き換えや変更なし	}
	NODBF	= 2;		{	DBFHでない	}
	NONDX	= 3;		{	NDXでない	}
	NOPEN	= 5;		{	オープンできない・されていない	}
	NOMEM	= 6;		{	メモリーが確保できない	}
	R_IOERR	= 7;		{	インデックスリードエラー	}
	W_IOERR	= 8;		{	インデックスライトエラー	}
	DBFEOF	= 10;		{	DBFHの終わり	}
	DBFBOF	= 11;		{	DBFHのはじめ	}
	NDXEOF	= 12;		{	NDXの終わり	}
	NDXBOF	= 13;		{	NDXのはじめ	}
	NOSYC	= 15;		{	DBFH と NDX が不整合	}
	NOSET	= 16;		{	キーポインタが未設定	}
	NOKEY	= 17;		{	キーが無い	}
	MAYBE	= 18;		{	キーが部分一致	}
	RD_ERR	= 21;		{	ディスクリードエラー	}
	WR_ERR	= 22;		{	ディスクライトエラー	}
	MKIDXERR = 23;		{	インデックス構築エラー	}
	NO_DBR	= 24;		{	データが不整合	}
	NOTEMP	= 25;		{	作業ファイルが作れない	}
	NO_KEY	= 26;		{	キー表現式が不正	}
	NO_STK	= 27;		{	スタックオーバーフロー	}
	NO_SORT	= 29;		{	不正なソート、又は重複	}

	LDBF_NOPEN = 40;	{	HAMLOG.HDBがオープンできない	}
	MDBF_NOPEN = 42;	{	HAMLOG.MSTがオープンできない	}
	KAKUNIN_NO = $0010;	//	データ登録時確認メッセージ無し
	FIELD_COUNT = 14;	//	入力項目は１４個
	U_Option = 0;	{ USER.TXT }
	V_Option = 1;
	W_Option = 2;

	X19MHZ = 0;
	X35MHZ = 1;		{	3.5MHz～3.8MHz	}
	X7_MHZ = 2;
	X10MHZ = 3;
	X14MHZ = 4;
	X18MHZ = 5;
	X21MHZ = 6;
	X24MHZ = 7;
	X28MHZ = 8;		{	28MHz ～ 29MHz	}
	X50MHZ = 9;
	X144MHZ = 10;
	X430MHZ = 11;
	X120MHZ = 12;
	X240MHZ = 13;
	X560MHZ = 14;
	MAXBAND = 15;
	SATELLITE = 16;
	TurboHAMLOG: PAnsiChar = 'Turbo HAMLOG/Win';
	WKD_STAT = 45;		{ HAMLOG.MSTの39ﾊﾞｲﾄ目から4ﾊﾞｲﾄ 1+6+34+4}
//	WM_COPYDATA ----------------
	THW_ENTER = $10000;	//	データ送信後、ENTERキーを押したのと同じ
	THW_FOCUS = $20000;	//	データ送信後、編集ボックスにフォーカス
	THW_SAVEBOX_ON = $40000;	//	データ保存時
	THW_SAVEBOX_OFF = $80000;	//	データ保存時
	THW_APPLIHWND =  $100000;	//	メインウインドウのハンドル

type
	TIDXh = Packed record
		np_: Pointer;
		fp_: Integer;
		w_flag: SmallInt;
		fname: array [0..MAX_PATH-1] of AnsiChar;
	end;

	TDBFh = Packed record
		lupdt: array [0..3] of Byte;
		rcount: LongInt;
		hsize, rsize: SmallInt;
		recnm: LongInt;
		fhandle: Integer;
		update: SmallInt;
		fname: array [0..MAX_PATH-1] of AnsiChar;
	end;
//---------------------- 旧形式データ ------------------------
	TDBRh = Packed record
		lupdt: array [0..3] of Byte;
		rcount: LongInt;
		fhandle: Integer;
		update: SmallInt;
	end;

	TRBuff = Packed record
		qBuff: array [0..139] of AnsiChar;
		rm_1, rm_2: PAnsiChar;
		rsize: Byte;
	end;

	TOldData = Packed record
		cBuff: array [0..52] of AnsiChar;
		ofs: LongInt;
		dummy: AnsiChar;
	end;

	TOldBuff = Packed record
		Calls: array [0..7] of AnsiChar;
		Potbl: array [0..3] of AnsiChar;
		Date: array [0..8] of AnsiChar;
		Time: array [0..6] of AnsiChar;
		Hiss: array [0..3] of AnsiChar;
		Myrs: array [0..3] of AnsiChar;
		Freq: array [0..7] of AnsiChar;
		Mode: array [0..3] of AnsiChar;
		Code: array [0..6] of AnsiChar;
		Glid: array [0..6] of AnsiChar;
		Qsl:  array [0..3] of AnsiChar;		{ Qsl, Send, Rcv }
		_Name: array [0..12] of AnsiChar;
		Qth: array [0..28] of AnsiChar;
		Rmk1: array [0..54] of AnsiChar;
		Rmk2: array [0..54] of AnsiChar;
	end;

	TOldLog = Packed record
		Qso: TOldBuff;		//	ＱＳＯバッファ
		logdt: TOldData;
		ldbf: TDBFh;
		ldbR: TDBRh;
		rbf: TRBuff;
	end;
//-------------------- 旧形式データ・ここまで --------------------

	TLogStruct = Packed record
		fld: PAnsiChar;			//	ﾌｨｰﾙﾄﾞ名
		len: Integer;			//	ﾌｨｰﾙﾄﾞ長
	end;

	TLogData = Packed record
		calls: array [0..19] of AnsiChar;	//	ｺｰﾙｻｲﾝ
		date: array [0..3] of AnsiChar;		//	日付
		time: array [0..1] of AnsiChar;		//	時間
		code: array [0..5] of AnsiChar;		//	JCCｺｰﾄﾞ
		glid: array [0..5] of AnsiChar;		//	ｸﾞﾘｯﾄﾞﾛｹｰﾀｰ
		qsl: array [0..2] of AnsiChar; 		//	QSL Via, Send, Rcv
		flag1: Word;
		hiss: array [0..755] of AnsiChar;	//	"HIS","MY","FREQ","MODE","NAME","QTH","RMK1","RMK2"
		myrs, freq, mode, _name, qth, rmk1, rmk2: PAnsiChar;
		dummy: AnsiChar;
	end;

	pTQsoBuff = ^TQsoBuff;
	TQsoBuff = Packed record
		Calls: array [0..20] of AnsiChar;
		Date: array [0..8] of AnsiChar;
		Time: array [0..6] of AnsiChar;
		Code: array [0..6] of AnsiChar;
		Glid: array [0..6] of AnsiChar;
		Qsl:  array [0..3] of AnsiChar;		//	Qsl, Send, Rcv
		Flag1: Word;
		Hiss: array [0..763] of AnsiChar;
		Myrs, Freq, Mode, _Name, Qth, Rmk1, Rmk2: PAnsiChar;
		HissLen, MyrsLen, FreqLen, ModeLen, NameLen, QthLen, Rmk1Len, Rmk2Len: Byte;
	end;

	pTQsoBuff3 = ^TQsoBuff3;
	TQsoBuff3 = Packed record
		Calls, Date,	//	04/08/20
		Time,	//	10:20J
		Code, Glid,
		Hiss, Myrs, Freq, Mode,
		_Name, Qth, Rmk1, Rmk2: String;
		Qsl: array [0..3] of AnsiChar;
		Flag1: Word;
	end;

	TJccgMas = Packed record
		code: array [0..5] of AnsiChar;
		qth: array [0..33] of AnsiChar;
		flg: AnsiChar;
		hed: array [0..3] of AnsiChar;	//	Hed + Eria
		Cfm: Word;
		Wkd: Word;
		Ido: array [0..5] of Byte;
		dummy: AnsiChar;
	end;

	TThLog = Packed record
		Qso: TQsoBuff;		//	ＱＳＯバッファ
		logdt: TLogData;
		jccmas: TJccgMas;
		ldbf: TDBFh;
		mdbf: TDBFh;
		Ndxp: array [0..5] of TIDXh;
		flush: SmallInt;
	end;

{ ====== ユーザーリスト検索用構造体 ====== }
	TLogUser2 = Packed record
		fpos: array [0..2] of AnsiChar;
		calli: LongInt;
	end;

	pQsoBuff3Arry = ^TQsoBuff3Arry;
	TQsoBuff3Arry = array [0..1999999] of TQsoBuff3;

	pIntArray = ^TIntArray;
	TIntArray = array [0..1999999] of Integer;
	pWordArray = ^TWordArray;
	TWordArray = array [0..1999999] of Word;
	pBoolArray = ^TBoolArray;
	TBoolArray = array [0..1999999] of ByteBool;
	TGetDiskFreeSpEx = function(lpDirectoryName: PAnsiChar;
			var lpFreeBytesAvailableToCaller, lpTotalNumberOfBytes,
			lpTotalNumberOfFreeBytes: Comp): BOOL;	stdcall;
	TUnLha32 = function(const _hwnd: THandle; const _CmdLine: PAnsiChar;
			_Output: PAnsiChar; const _Size: Integer): Integer; stdcall;
	TAboutBoxDll = procedure(sstr: PAnsiChar);	StdCall;

{ ***** From HAMLOG50.DLL ***** }
function  GetThdllVersion:	Integer;	StdCall;
function  MakeIndex(const Dname, Key, IdxName: PAnsiChar): Integer; StdCall;
function  dbf_create(const fname: PAnsiChar; var s: TLogStruct): Integer; StdCall;
function  dbf_open(const fname: PAnsiChar; var dbf: TDBFh): Integer; StdCall;
procedure dbf_close(var dbf: TDBFh); StdCall;
function  dbf_read(var dbf: TDBFh; rno: LongInt; var buf): Integer; StdCall;
function  dbf_read2(var dbf: TDBFh; rno: Longint; var buf; cnt: Integer): Integer; StdCall;
function  dbf_rsize(var dbf: TDBFh): Integer; StdCall;
function  dbf_write(var dbf: TDBFh; rno: LongInt; buf: PAnsiChar): Integer; StdCall;
function  dbf_write2(var dbf: TDBFh; rno: LongInt; const buf: PAnsiChar; const fst, size: Integer): Integer; StdCall;
function  DB_append(var Th: TThLog; const rno: Integer): Integer; StdCall;
function  THW_skip(var Th: TThLog; const n, flg: Integer): Integer; StdCall;
function  THW_seek(var Th: TThLog; Key: PAnsiChar; const flg: Integer): Integer; StdCall;
function  THW_top(var Th: TThLog; const flg: Integer): Integer; StdCall;
function  THW_btm(var Th: TThLog; const flg: Integer): Integer; StdCall;
function  dbf_packwk(var dbf: TDBFh; buff: PAnsiChar; size: Integer): Integer; StdCall;
function  dbf_delete(var dbf: TDBFh; const rno: LongInt): Integer; StdCall;
function  THW_read(var Th: TThLog; const rno: Longint; const flg: Integer): Integer; StdCall;
function  THW_readv(var Th: TThLog; const rno: Longint; var Qso: TQsoBuff): Integer; StdCall;
function  THW_update(var Th, Th2: TThLog; const rno: Longint; const flg: Integer; var mes: Integer): Integer; StdCall;
function  THW_append(var Th: TThLog; const flg: Integer; var mes: Integer): Integer; StdCall;
procedure THW_flush(var Th: TThLog);	StdCall;
function  Idx_ReadKey(var Th: TThLog; const flg: Integer): PAnsiChar; StdCall;
function  idx_open(const fname: PAnsiChar; var idx: TIDXh): Integer;	StdCall;
procedure idx_close(var idx: TIDXh); StdCall;
function  idx_search(var idx: TIDXh; const key: PAnsiChar; len: Integer): LongInt; StdCall;
function  idx_next(var idx: TIDXh): LongInt; StdCall;
function  idx_back(var idx: TIDXh): LongInt; StdCall;
function  idx_top(var idx: TIDXh): LongInt; StdCall;
function  idx_bottom(var idx: TIDXh): LongInt; StdCall;
function  isPortable(const c: PAnsiChar): Integer;	StdCall;
procedure GetDxEntity(const calls: PAnsiChar; buff: PAnsiChar);	StdCall;
procedure QSL_Rcv(var Th: TThLog; const rno: Longint; const mk: AnsiChar); StdCall;
procedure QSL_Send(var Th: TThLog; const rno: Longint; const mk: AnsiChar); StdCall;
function  StrToLong(const astr: PAnsiChar): LongInt;	StdCall;
function  HamlogOpen(AboutBoxDll: TAboutBoxDll; var Th: TThLog; const fname: PAnsiChar; const isComp: Integer): Integer; StdCall;
procedure HamlogClose(var Th: TThLog; const isComp: Integer); StdCall;
function  THW_idxrmv(var Th: TThLog; const rno: Longint; const i: Integer; const key: PAnsiChar): Integer;	StdCall;
function  FreqPCheck(const freq: PAnsiChar): Integer;	StdCall;
procedure Wget_bit(wstr: PAnsiChar; var wc: TJccgMas);	StdCall;
procedure Wput_bit(var Th: TThLog; const wc: PAnsiChar);	StdCall;
function  ChosonCheck(const cd: PAnsiChar): Integer;	StdCall;
procedure WkdCfmCheck(Handle: HDC; var Th: TThLog; var wno: LongInt; const NoWkd: PAnsiChar; const Non: AnsiChar);	StdCall;
function  Get_lupdate(var dbf: TDBFh): PAnsiChar;	StdCall;
procedure THW_zap(var Th: TThLog);	StdCall;
function  T_Open(const fname: PAnsiChar): Integer;	StdCall;
procedure T_Puts(const buff: PAnsiChar; Handle: Integer);	StdCall;
function  T_GetDbs(var buff; slen, handle: Integer): Integer;	StdCall;
function  T_Gets(var buff; slen, handle: Integer): Integer;	StdCall;
function  JStrStr(const s1, s2: PAnsiChar): Integer;	StdCall;
function  DateComp(const d1, d2: PAnsiChar): Integer;	StdCall;
function  isExPrefix(const call1, call2, call3: PAnsiChar; const calls: PAnsiChar): Integer; StdCall;
function  DateTimeSort(const HdbFile: PAnsiChar): Integer;	StdCall;
function  MasterSort(var Th: TThLog): Integer;	StdCall;
function  CopyFromMAS(var Th: TThLog): Longint;	StdCall;
function  dbf_rcount(var dbf: TDBFh): LongInt;	StdCall;
function  dbf_recno(var dbf: TDBFh): LongInt;	StdCall;
procedure _Qsorter(var pData; const Cnt, size: Integer);	StdCall;
function  Han2ZenStr(const str: PAnsiChar): PAnsiChar;	StdCall;
function  SetDbsShare(const i: Integer): Boolean;	StdCall;

function  DbsDbrOpen(var th: TOldLog; fname: PAnsiChar): Integer;	StdCall;
procedure DbsDbrClose(var th: TOldLog); StdCall;
function  DbsDbrRead(var th: TOldLog; rno: LongInt): Integer;	StdCall;

implementation

const	HamlogDllName = 'Hamlog50.dll';

{ ****  by  Borland C++ Ver5.0J **** }
function  GetThdllVersion;	external HamlogDllName;	//	Index 1;
function  MakeIndex;		   external HamlogDllName;	//	Index 2;
function  dbf_create;		external HamlogDllName;	//	Index 3;
function  dbf_open;			external HamlogDllName;	//	Index 4;
procedure dbf_close;		   external HamlogDllName;	//	Index 5;
function  dbf_read;			external HamlogDllName;	//	Index 6;
function  dbf_rsize;		   external HamlogDllName;	//	Index 7;
function  dbf_write;		   external HamlogDllName;	//	Index 8;
function  dbf_write2;		external HamlogDllName;	//	Index 9;
function  DB_append;		   external HamlogDllName;
function  THW_read;			external HamlogDllName;	//	Index 10;
function  THW_readv;		   external HamlogDllName;
function  THW_skip;			external HamlogDllName;	//	Index 11;
function  THW_seek;			external HamlogDllName;	//	Index 12;
function  THW_top;			external HamlogDllName;	//	Index 13;
function  THW_btm;			external HamlogDllName;	//	Index 14;
function  dbf_read2;		   external HamlogDllName;
function  dbf_packwk;		external HamlogDllName;	//	Index 16;
function  dbf_delete;		external HamlogDllName;	//	Index 17;
function  THW_update;		external HamlogDllName;	//	Index 18;
function  THW_append;		external HamlogDllName;	//	Index 19;
procedure THW_flush;		   external HamlogDllName;	//	Index 20;
function  Idx_ReadKey;		external HamlogDllName;	//	Index 21;
function  idx_open;			external HamlogDllName;	//	Index 22;
procedure idx_close;		   external HamlogDllName;	//	Index 23;
function  idx_search;		external HamlogDllName;	//	Index 24;
function  idx_next;			external HamlogDllName;	//	Index 25;
function  idx_back;			external HamlogDllName;	//	Index 26;
function  idx_top;			external HamlogDllName;	//	Index 27;
function  idx_bottom;		external HamlogDllName;	//	Index 28;
procedure GetDxEntity;		external HamlogDllName;
function  isPortable;		external HamlogDllName;
procedure QSL_Rcv;			external HamlogDllName;	//	Index 30;
procedure QSL_Send;			external HamlogDllName;	//	Index 31;
function  StrToLong;		   external HamlogDllName;	//	Index 32;
function  HamlogOpen;		external HamlogDllName;	//	Index 37;
procedure HamlogClose;		external HamlogDllName;	//	Index 38;
function  THW_idxrmv;      external HamlogDllName;	//	Index 39;
function  FreqPCheck;		external HamlogDllName;	//	Index 40;
procedure Wget_bit;			external HamlogDllName;	//	Index 41;
procedure Wput_bit;			external HamlogDllName;	//	Index 42;
function  ChosonCheck;		external HamlogDllName;	//	Index 43;
function  JStrStr;			external HamlogDllName;
procedure WkdCfmCheck;		external HamlogDllName;	//	Index 44;
function  Get_lupdate;		external HamlogDllName;	//	Index 45;
procedure THW_zap;			external HamlogDllName;	//	Index 46;
function  T_Open;			   external HamlogDllName;	//	Index 48;
procedure T_Puts;			   external HamlogDllName;	//	Index 49;
function  T_GetDbs;			external HamlogDllName;	//	Index 50;
function  T_Gets;			   external HamlogDllName;	//	Index 51;
function  DateComp;			external HamlogDllName;	//	Index 53;
function  isExPrefix;      external HamlogDllName;	//	Index 54;
function  DateTimeSort;		external HamlogDllName;	//	Index 57;
function  MasterSort;		external HamlogDllName;	//	Index 58;
function  CopyFromMAS;		external HamlogDllName;	//	Index 60;
function  dbf_rcount;		external HamlogDllName;	//	Index 62;
function  dbf_recno;		   external HamlogDllName;	//	Index 63;
procedure _Qsorter;			external HamlogDllName;
function  Han2ZenStr;		external HamlogDllName;
function  SetDbsShare;		external HamlogDllName;
function  DbsDbrOpen;		external HamlogDllName;
procedure DbsDbrClose;		external HamlogDllName;
function  DbsDbrRead;		external HamlogDllName;

end.

