unit UzLogConst;

interface

type
  TMode = (mCW, mSSB, mFM, mAM, mRTTY, mOther);
  TBand = (b19, b35, b7, b10, b14, b18, b21, b24, b28, b50, b144, b430, b1200, b2400, b5600, b10g);
  TPower = (p001, p002, p005, p010, p020, p025, p050, p100, p200, p500, p1000);

const
  HiBand = b10g;

type
  TBandBool = array[b19..HiBand] of boolean;

const
  // SerialContestType
  _USEUTC = 32767;
  _CR = Chr($0d); // carriage return
  _LF = Chr($0a);
  SER_ALL = 1;
  SER_BAND = 2;
  SER_MS = 3;    // separate serial for run/multi stns

const
  RIGNAMES : array[0..15] of string =
('None',
 'TS-690/450',
 'TS-850',
 'TS-790',
 'TS-2000',
 'TS-2000/P',
 'FT-817',
 'FT-847',
 'FT-920',
 'FT-991',
 'FT-100',
 'FT-1000',
 'FT-1000MP',
 'MarkV/FT-1000MP',
 'FT-1000MP Mark-V Field',
 'FT-2000'
 );

const
  maxbank = 3; // bank 3 reserved for rtty
  maxstr = 8;
  maxmaxstr = 12; // f11 and f12 only accessible via zlog.ini

const
  ZLinkHeader = '#ZLOG#';
  actAdd = $0A;
  actDelete = $0D;
  actInsert = $07;
  actEdit = $0E;
  actLock = $AA;
  actUnlock = $BB;

  LineBreakCode : array [0..2] of string
    = (Chr($0d)+Chr($0a), Chr($0d), Chr($0a));
  _sep = '~'; {separator character}

const
  NewPowerString : array[p001..p1000] of string =
                       ('P', 'L', 'M', 'H',  '',  '',  '',  '',  '',  '',  '');

const
  MHzString: array[b19..HiBand] of string = ('1.9','3.5','7','10','14',
                                             '18','21','24','28','50','144',
                                             '430','1200','2400','5600','10G');

  BandString: array[b19..HiBand] of string = ('1.9 MHz','3.5 MHz','7 MHz','10 MHz',
                                             '14 MHz', '18 MHz','21 MHz','24 MHz','28 MHz',
                                             '50 MHz','144 MHz','430 MHz','1200 MHz','2400 MHz',
                                             '5600 MHz','10 GHz & up');

  ADIFBandString : array[b19..HiBand] of string = ('160m','80m','40m','30m',
                                             '20m', '17m','15m','12m','10m',
                                             '6m','2m','70cm','23cm','13cm',
                                             '6cm','3cm');

  ModeString : array[mCW..mOther] of string = ('CW','SSB','FM','AM','RTTY','Other');

  pwrP = TPower(0);
  pwrL = TPower(1);
  pwrM = TPower(2);
  pwrH = TPower(3);

const
  default_primary_shortcut: array[0..102] of string = (
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
    'F1',               // #10
    'F2',
    'F3',
    'F4',
    'F5',
    'F6',               // #15
    'F7',
    'F8',
    'F9',
    'F10',
    'F11',              // #20
    'F12',
    'Shift+F1',
    'Shift+F2',
    'Shift+F3',
    'Shift+F4',         // #25
    'Shift+F5',
    'Shift+F6',
    'Shift+F7',
    'Shift+F8',
    'Shift+F11',        // #30
    'Shift+F12',
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
    'Ctrl+Q',
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
    'Alt+.',
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
    'Shift+M',
    'Shift+B',          // #90
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
    '',
    ''
  );

  default_secondary_shortcut: array[0..102] of string = (
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
    '',
    ''
  );

const
  MEMO_DUPE = '-DUPE-';
  MEMO_PSE_QSL = 'PSE QSL';
  MEMO_NO_QSL = 'NO QSL';

implementation

end.

