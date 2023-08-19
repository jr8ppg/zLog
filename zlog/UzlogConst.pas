unit UzLogConst;

interface

uses
  Graphics;

type
  TMode = (mCW, mSSB, mFM, mAM, mRTTY, mFT4, mFT8, mOther);
  TBand = (b19, b35, b7, b10, b14, b18, b21, b24, b28, b50, b144, b430, b1200, b2400, b5600, b10g, bTarget, bUnknown);
  TPower = (p001, p002, p005, p010, p020, p025, p050, p100, p200, p500, p1000);

  TContestMode = (cmMix = 0, cmCw, cmPh, cmOther, cmAll);
  TContestCategory = (ccSingleOp = 0, ccMultiOpMultiTx, ccMultiOpSingleTx, ccMultiOpTwoTx);
  TSo2rType = (so2rNone = 0, so2rCom, so2rNeo);
  TQslState = (qsNone = 0, qsPseQsl, qsNoQsl);

  TFrequency = Int64;

const
  HiBand = b10g;

type
  TBandBool = array[b19..HiBand] of boolean;

type
  TPlayMessageFinishedProc = procedure(Sender: TObject; mode: TMode; fAbort: Boolean) of object;

const
  // SerialContestType
  _USEUTC = 32767;
  _CR = Chr($0d); // carriage return
  _LF = Chr($0a);
  SER_ALL = 1;
  SER_BAND = 2;
  SER_MS = 3;    // separate serial for run/multi stns

  TXLIST_MM = '0,1,2,3,4,5,6,7,8,9';
  TXLIST_MS = '0,1';

type
  TIcomInfo = record
    name : string;
    addr : byte;
    minband, maxband : TBand;
    RitCtrl: Boolean;
    XitCtrl: Boolean;
  end;

const
  MAXICOM = 52;

  ICOMLIST : array[1..MAXICOM] of TIcomInfo =
     (
       (name: 'IC-703';       addr: $68; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-705';       addr: $A4; minband: b19; maxband: b430;   RitCtrl: True;  XitCtrl: True),
       (name: 'IC-706';       addr: $48; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-706MkII';   addr: $4E; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-706MkII-G'; addr: $58; minband: b19; maxband: b430;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-707';       addr: $3E; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-718';       addr: $5E; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-721(IC-725)'; addr: $28; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-726';       addr: $30; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-728';       addr: $38; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-729';       addr: $3A; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-731(IC-735)'; addr: $04; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-732(IC-737)'; addr: $04; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-736';       addr: $40; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-738';       addr: $44; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-746';       addr: $56; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-746PRO(IC-7400)'; addr: $66; minband: b19; maxband: b144; RitCtrl: False; XitCtrl: False),
       (name: 'IC-7000';      addr: $70; minband: b19; maxband: b430;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-7100';      addr: $88; minband: b19; maxband: b430;   RitCtrl: True;  XitCtrl: False),
       (name: 'IC-7200';      addr: $76; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-7300';      addr: $94; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7400';      addr: $66; minband: b19; maxband: b144;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-7410';      addr: $80; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-750/750A(IC-751)'; addr: $1C; minband: b19; maxband: b28; RitCtrl: False; XitCtrl: False),
       (name: 'IC-756';       addr: $50; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-756PRO';    addr: $5C; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-756PROII';  addr: $64; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-756PRO3';   addr: $6E; minband: b19; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-7600';      addr: $7A; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7610';      addr: $98; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7700';      addr: $74; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-78';        addr: $62; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-7800';      addr: $6A; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-7851';      addr: $8E; minband: b19; maxband: b50;    RitCtrl: True;  XitCtrl: True),
       (name: 'IC-760(IC-761)'; addr: $1E; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-760PRO(IC-765)'; addr: $2C; minband: b19; maxband: b28; RitCtrl: False; XitCtrl: False),
       (name: 'IC-775';       addr: $46; minband: b19; maxband: b28;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-780(IC-781)'; addr: $26; minband: b19; maxband: b28;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-575';       addr: $16; minband: b28; maxband: b50;    RitCtrl: False; XitCtrl: False),
       (name: 'IC-820';       addr: $42; minband: b144; maxband: b430;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-821';       addr: $4C; minband: b144; maxband: b430;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-905';       addr: $AC; minband: b144; maxband: b10g;  RitCtrl: True;  XitCtrl: True),
       (name: 'IC-910/911';   addr: $60; minband: b144; maxband: b1200; RitCtrl: False; XitCtrl: False),
       (name: 'IC-970';       addr: $2E; minband: b144; maxband: b1200; RitCtrl: False; XitCtrl: False),
       (name: 'IC-271';       addr: $20; minband: b144; maxband: b144;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-275';       addr: $10; minband: b144; maxband: b144;  RitCtrl: False; XitCtrl: False),
       (name: 'IC-371(IC-471)'; addr: $22; minband: b430; maxband: b430; RitCtrl: False; XitCtrl: False),
       (name: 'IC-375(IC-475)'; addr: $14; minband: b430; maxband: b430; RitCtrl: False; XitCtrl: False),
       (name: 'IC-9100';      addr: $7C; minband: b19; maxband: b1200;   RitCtrl: False; XitCtrl: False),
       (name: 'IC-9700';      addr: $A2; minband: b144; maxband: b1200;  RitCtrl: True;  XitCtrl: False),
       (name: 'IC-1271';      addr: $24; minband: b1200; maxband: b1200; RitCtrl: False; XitCtrl: False),
       (name: 'IC-1275';      addr: $18; minband: b1200; maxband: b1200; RitCtrl: False; XitCtrl: False)
     );

const
  RIGNAMES : array[0..22] of string =
('None',
 'TS-690/450',
 'TS-850',
 'TS-790',
 'TS-2000',
 'TS-2000/P',
 'TS-570',
 'TS-590/890',
 'TS-990',
 'FT-710',
 'FT-817',
 'FT-847',
 'FT-920',
 'FT-991',
 'FT-100',
 'FT-1000',
 'FT-1011(PC->RIG)',
 'FT-1000MP',
 'MarkV/FT-1000MP',
 'FT-1000MP Mark-V Field',
 'FT-2000',
 'FTDX-3000',
 'FTDX-5000/9000'
 );

const
  maxbank = 3; // bank 3 reserved for rtty
  maxmessage = 12; // f11 and f12 only accessible via zlog.ini

const
  ZLinkHeader = '#ZLOG#';
  actAdd = $0A;
  actDelete = $0D;
  actInsert = $07;
  actEdit = $0E;
  actLock = $AA;
  actUnlock = $BB;
  actEditOrAdd = $0C;

  LineBreakCode : array [0..2] of string
    = (Chr($0d)+Chr($0a), Chr($0d), Chr($0a));
  _sep = '~'; {separator character}

const
  NewPowerString : array[p001..p1000] of string =
                       ('P', 'L', 'M', 'H',  '',  '',  '',  '',  '',  '',  '');

const
  MHzString: array[b19..bUnknown] of string = ('1.9','3.5','7','10','14',
                                             '18','21','24','28','50','144',
                                             '430','1200','2400','5600','10G','Target','Unknown');

  BandString: array[b19..HiBand] of string = ('1.9 MHz','3.5 MHz','7 MHz','10 MHz',
                                             '14 MHz', '18 MHz','21 MHz','24 MHz','28 MHz',
                                             '50 MHz','144 MHz','430 MHz','1200 MHz','2400 MHz',
                                             '5600 MHz','10 GHz & up');

  ADIFBandString : array[b19..HiBand] of string = ('160m','80m','40m','30m',
                                             '20m', '17m','15m','12m','10m',
                                             '6m','2m','70cm','23cm','13cm',
                                             '6cm','3cm');

  ModeString : array[mCW..mOther] of string = ('CW','SSB','FM','AM','RTTY','FT4','FT8','Other');
  ModeString2 : array[mCW..mOther] of string = ('CW','PH','PH','PH','RTTY','DG','DG','Other');

  pwrP = TPower(0);
  pwrL = TPower(1);
  pwrM = TPower(2);
  pwrH = TPower(3);

type
  TQSORateStyle = ( rsOriginal = 0, rsByBand, rsByFreqRange );
  TQSORateStartPosition = ( spFirstQSO = 0, spCurrentTime, spLastQSO );

type
  TSendRepeatEvent = procedure(Sender: TObject; nLoopCount: Integer) of object;

const
  default_graph_bar_color: array[b19..HiBand] of TColor = (
    $0080FF00, $000000FF, $00FF0000, $00808080,
    $0000FFFF, $00808080, $00FF00FF, $00808080,
    $00FFFF80, $004080FF, $00FF8000, $00C080FF,
    $00FF0080, $00359CF3, $00144CF1, $0080FFFF
  );
  default_graph_text_color: array[b19..HiBand] of TColor = (
    $00400040, $00FFFFFF, $00FFFFFF, $00FFFFFF,
    $00000000, $00FFFFFF, $00000000, $00FFFFFF,
    $00000000, $00FFFFFF, $00FFFFFF, $00000000,
    $00FFFFFF, $00000000, $00FFFFFF, $00400040
  );

  default_other_bg_color: array[0..1] of TColor = (
    $000080FF, $00B16A47
  );

  default_other_fg_color: array[0..1] of TColor = (
    $00FFFFFF, $00FFFFFF
  );

  default_zaq_bg_color: array[0..3] of TColor = (
    $00FFFF80, $00EAD5CF, $00F5EBE9, $00DCDCDC
  );

  default_zaq_fg_color: array[0..3] of TColor = (
    $00000000, $00000000, $00000000, $00000000
  );

const
  default_primary_shortcut: array[0..161] of string = (
    'Ctrl+F1',          // #00
    'Ctrl+F2',
    'Ctrl+F3',
    'Ctrl+F4',
    'Ctrl+F5',
    'Ctrl+F6',          // #05
    'Ctrl+F7',
    'Ctrl+F8',
    'Ctrl+F10',
    'Ctrl+F12',
    '',                 // #10
    'F2',
    'F3',
    'F4',
    'F5',
    'F6',               // #15
    'F7',
    'F8',
    '',                 // #18 actionCheckMulti
    '',                 // #19 actionShowCheckPartial
    '',                 // #20 actionPlayCQA2
    '',                 // #21 actionPlayCQA3
    'Shift+F1',         // #22 actionPlayMessageB01
    'Shift+F2',         // #23 actionPlayMessageB02
    'Shift+F3',         // #24 actionPlayMessageB03
    'Shift+F4',         // #25 actionPlayMessageB04
    'Shift+F5',         // #26 actionPlayMessageB05
    'Shift+F6',         // #27 actionPlayMessageB06
    'Shift+F7',         // #28 actionPlayMessageB07
    'Shift+F8',         // #29 actionPlayMessageB08
    '',                 // #30 actionPlayCQB2
    '',                 // #31 actionPlayCQB3
    'Ctrl+Enter',
    'Ctrl+N',
    'Shift+Ctrl+N',
    'Ctrl+S',           // #35
    'Shift+Ctrl+S',
    'PgUp',
    'PgDn',
    'Ctrl+A',
    'Ctrl+B',           // #40
    'Ctrl+D',
    'Ctrl+E',
    'Ctrl+F',
    'Ctrl+G',
    'Ctrl+H',           // #45
    'Ctrl+I',
    'Ctrl+J',
    'Ctrl+K',
    'Ctrl+L',
    'Ctrl+O',           // #50
    'Ctrl+P',
    '',
    'Ctrl+R',
    'Ctrl+T',
    'Ctrl+U',           // #55
    'Ctrl+W',
    'Ctrl+Z',
    'Alt+B',
    'Alt+C',
    'Alt+K',            // #60
    'Alt+M',
    'Alt+N',
    'Alt+O',
    'Alt+P',
    'Alt+Q',            // #65
    'Alt+R',
    'Alt+S',
    'Alt+T',
    'Alt+W',
    'Alt+Z',            // #70
    'Shift+X',
    '',
    '',
    '',
    '',                 // #75
    '',
    '',
    '',
    '',
    '',                 // #80
    '',
    'Tab',
    'Down',
    'Ctrl+M',
    '',                 // #85
    '',
    '',
    'Shift+Ctrl+I',
    'Shift+B',
    'Shift+M',          // #90
    'Shift+P',
    'Shift+F',
    'Shift+R',
    'Shift+S',
    'Shift+T',          // #95
    'Shift+U',
    'Shift+Y',
    'Shift+Z',
    '',                 // #99
    'Alt+L',            // #100
    '',                 // #101 actionQuickMemo1
    '',                 // #102 actionQuickMemo2
    '',                 // #103 actionCwMessagePad
    '',                 // #104 actionCorrectSentNr
    '',                 // #105 actionSetLastFreq
    '',                 // #106 actionQuickMemo3
    '',                 // #107 actionQuickMemo4
    '',                 // #108 actionQuickMemo5
    'F9',               // #109 actionPlayMessageA09
    'F10',              // #110 actionPlayMessageA10
    'Shift+F9',         // #111 actionPlayMessageB09
    'Shift+F10',        // #112 actionPlayMessageB10
    'Esc',              // #113 actionCQAbort
    'F11',              // #114 actionPlayMessageA11
    'F12',              // #115 actionPlayMessageA12
    'F1',               // #116 actionPlayCQA1
    'Shift+F11',        // #117 actionPlayMessageB11
    'Shift+F12',        // #118 actionPlayMessageB12
    '',                 // #119 actionPlayCQB1
    'Shift+O',          // #120 actionToggleCqSp
    '',                 // #121 actionCQRptUp
    '',                 // #122 actionCQRptDown
    '',                 // #123 actionSetCQMessage1
    '',                 // #124 actionSetCQMessage2
    '',                 // #125 actionSetCQMessage3
    '',                 // #126 actionToggleRit
    '',                 // #127 actionToggleXit
    '',                 // #128 actionRitClear
    '',                 // #129 actionToggleAntiZeroin
    '',                 // #130 actionAntiZeroin
    '',                 // #131 actionFunctionKeyPanel
    '',                 // #132 actionShowQsoRateEx
    '',                 // #133 actionShowQsyInfo
    '',                 // #134 actionShowSo2rNeoCp
    '',                 // #135 actionSo2rNeoRx1
    '',                 // #136 actionSo2rNeoRx2
    '',                 // #137 actionSo2rNeoRxBoth
    '',                 // #138 actionSelectRig1
    '',                 // #139 actionSelectRig2
    '',                 // #140 actionSelectRig3
    '',                 // #141 actionSo2rNeoCanRxSel
    '',                 // #142 actionShowInformation
    '',                 // #143 actionToggleSo2r2bsiq
    '',                 // #144 actionSo2rNeoToggleAutoRxSelect
    'Shift+V',          // #145 actionToggleTx
    '',                 // #146 actionToggleSo2rWait
    'Shift+C',          // #147 actionToggleRx
    '',                 // #148 actionMatchRxToTx
    '',                 // #149 actionMatchTxToRx
    'Shift+D',          // #150 actionToggleRigPair
    'Ctrl+0',           // #151 actionChangeTxNr0
    'Ctrl+1',           // #152 actionChangeTxNr1
    '',                 // #153 actionChangeTxNr2
    'Ctrl+Q',           // #154 actionPseQsl
    'Shift+Ctrl+Q',     // #155 actionNoQsl
    '',                 // #156 actionMsgMgr
    'Shift+Ctrl+B',     // #157 actionChangeBand2
    'Shift+Ctrl+M',     // #158 actionChangeMode2
    'Shift+Ctrl+P',     // #159 actionChangePower2
    'Alt+Y',            // #160 actionToggleTxNr
    ''                  // #161 actionShowCWMonitor
  );

  default_secondary_shortcut: array[0..161] of string = (
    '',                 // #00
    '',
    '',
    '',
    '',
    '',                 // #05
    '',
    '',
    '',
    '',
    '',                 // #10
    '',
    '',
    '',
    '',
    '',                 // #15
    '',
    '',
    '',
    '',
    '',                 // #20
    '',
    '',
    '',
    '',
    '',                 // #25
    '',
    '',
    '',
    '',
    '',                 // #30
    '',
    '',
    '',
    '',
    '',                 // #35
    '',
    '',
    '',
    '',
    '',                 // #40
    '',
    '',
    '',
    '',
    '',                 // #45
    '',
    '',
    '',
    '',
    '',                 // #50
    '',
    '',
    '',
    '',
    '',                 // #55
    '',
    '',
    '',
    '',
    '',                 // #60
    '',
    '',
    '',
    '',
    '',                 // #65
    '',
    '',
    '',
    '',
    '',                 // #70
    '',
    '',
    '',
    '',
    '',                 // #75
    '',
    '',
    '',
    '',
    '',                 // #80
    '',
    '',
    ';',
    '',
    '@',                // #85
    '\',
    '',
    '',
    '',
    '',                 // #90
    '',
    '',
    '',
    '',
    '',                 // #95
    '',
    '',
    '',
    '',                 // #99
    '',                 // #100
    '',                 // #101
    '',
    '',
    '',
    '',                 // #105
    '',
    '',
    '',
    '',
    '',                 // #110
    '',
    '',                 // #112
    '',                 // #113
    '',                 // #114 actionPlayMessageA11
    '',                 // #115 actionPlayMessageA12
    '',                 // #116 actionPlayCQA1
    '',                 // #117 actionPlayMessageB11
    '',                 // #118 actionPlayMessageB12
    '',                 // #119 actionPlayCQB1
    '',                 // #120 actionToggleCqSp
    '',                 // #121 actionCQRptUp
    '',                 // #122 actionCQRptDown
    '',                 // #123 actionSetCQMessage1
    '',                 // #124 actionSetCQMessage2
    '',                 // #125 actionSetCQMessage3
    '',                 // #126 actionToggleRit
    '',                 // #127 actionToggleXit
    '',                 // #128 actionRitClear
    '',                 // #129 actionToggleAntiZeroin
    '',                 // #130 actionAntiZeroin
    '',                 // #131 actionFunctionKeyPanel
    '',                 // #132 actionShowQsoRateEx
    '',                 // #133 actionShowQsyInfo
    '',                 // #134 actionShowSo2rNeoCp
    '',                 // #135 actionSo2rNeoRx1
    '',                 // #136 actionSo2rNeoRx2
    '',                 // #137 actionSo2rNeoRxBoth
    '',                 // #138 actionSelectRig1
    '',                 // #139 actionSelectRig2
    '',                 // #140 actionSelectRig3
    '',                 // #141 actionSo2rNeoCanRxSel
    '',                 // #142 actionShowInformation
    '',                 // #143 actionToggleAutoRigSwitch
    '',                 // #144 actionSo2rNeoToggleAutoRxSelect
    '',                 // #145 actionToggleTx
    '',                 // #146 actionToggleCqInvert
    '',                 // #147 actionToggleRx
    '',                 // #148 actionMatchRxToTx
    '',                 // #149 actionMatchTxToRx
    '',                 // #150 actionToggleRigPair
    '',                 // #151 actionChangeTxNr0
    '',                 // #152 actionChangeTxNr1
    '',                 // #153 actionChangeTxNr2
    '',                 // #154 actionPseQsl
    '',                 // #155 actionNoQsl
    '',                 // #156 actionMsgMgr
    '',                 // #157 actionChangeBand2
    '',                 // #158 actionChangeMode2
    '',                 // #159 actionChangePower2
    '',                 // #160 actionToggleTxNr
    ''                  // #161 actionShowCWMonitor
  );

const
  MEMO_DUPE = '-DUPE-';
  MEMO_PSE_QSL = 'PSE QSL';
  MEMO_NO_QSL = 'NO QSL';
  MEMO_QSY_VIOLATION = '*QSY Violation*';

implementation

end.

