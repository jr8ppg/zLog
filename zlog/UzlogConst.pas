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
  RIGNAMES : array[0..14] of string =
('None',
 'TS-690/450',
 'TS-850',
 'TS-790',
 'TS-2000',
 'TS-2000/P',
 'FT-817',
 'FT-847',
 'FT-920',
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

implementation

end.
