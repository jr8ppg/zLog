unit WinKeyer;

interface

const
  // Admin <00><nn> nn is a value from 0 to 8
  WK_ADMIN_CMD = $00;
  WK_ADMIN_CAL = $00;
  WK_ADMIN_RESET = $01;
  WK_ADMIN_OPEN = $02;
  WK_ADMIN_CLOSE = $03;
  WK_ADMIN_ECHO = $04;
  WK_ADMIN_PADDLE_A2D = $05;
  WK_ADMIN_SET_WK2_MODE = 11;
  WK_ADMIN_SET_LOW_BAUD = 17;       // Set Low Baud Change serial comm. Baud Rate to 1200 (default)
  WK_ADMIN_SET_HIGH_BAUD = 18;      // Set High Baud Change serial comm. Baud Rate to 9600
  WK_ADMIN_SET_WK3_MODE = 20;
  WK_ADMIN_SIDETONE_VOLUME = 24;    // 25: Set Sidetone Volume <00><24><n> where n =0x1 for low and n=0x4 for high

  // Sidetone Frequency <01><nn> nn is a value from 1 to 10
  WK_SIDETONE_CMD = $01;
  WK_SIDETONE_PADDLEONLY = $80;

  // Set WPM Speed <02><nn> nn is in the range of 5-99 WPM
  // Example: <02><12> set 18 WPM
  WK_SETWPM_CMD = $02;

  //Set PTT Lead/Tail <04><nn1><nn2> nn1 sets lead in time, nn2 sets tail time
  //both values range 0 to 250 in 10 mSecs steps
  WK_SET_PTTDELAY_CMD = $04;

  // Setup Speed Pot <05><nn1><nn2><nn3>
  // nn1 = MINWPM, nn2 = WPMRANGE, nn3 = POTRANGE
  WK_SET_SPEEDPOT_CMD = $05;

  // Get Speed Pot <07> no parameter
  // Request to WinKey to return current speed pot setting.
  WK_GET_SPEEDPOT_CMD = $07;

  // Backspace <08> Backup the input buffer pointer by one character.
  WK_BACKSPACE_CMD = $08;

  // Set PinConfig <09><nn> Set the PINCFG Register
  WK_SET_PINCFG_CMD = $09;

  // Clear Buffer <0A> no parameters
  WK_CLEAR_CMD = $0a;

  // Key Immediate <0B><nn> nn = 01 key down, n = 00 key up
  WK_KEY_IMMEDIATE_CMD = $0b;

  WK_KEY_IMMEDIATE_KEYDOWN = $01;
  WK_KEY_IMMEDIATE_KEYUP = $00;

  // Set WinKeyer Mode <0E><nn> nn = Mode bit field in binary
  WK_SETMODE_CMD = $0e;

  WK_SETMODE_CTSPACING               = $01;  // 0 (LSB) CT Spacing when=1, Normal Wordspace when=0
  WK_SETMODE_AUTOSPACE               = $02;  // 1 Autospace (1=Enabled, 0=Disabled)
  WK_SETMODE_SERIALECHOBACK          = $04;  // 2 Serial Echoback (1=Enabled, 0=Disabled)
  WK_SETMODE_PADDLESWAP              = $08;  // 3 Paddle Swap (1=Swap, 0=Normal)
  WK_SETMODE_Iambic_A                = $10;  // 4 10 = Ultimatic 11 = Bug Mode
  WK_SETMODE_Ultimatic               = $20;  // 5 Key Mode: 00 = Iambic B 01 = Iambic A
  WK_SETMODE_Iambic_B                = $00;
  WK_SETMODE_BUGMODE                 = $30;

  WK_SETMODE_PADDLE_ECHOBACK         = $40;  // 6 Paddle Echoback (1=Enabled, 0=Disabled)
  WK_SETMODE_DISABLE_PADDLE_WATCHDOG = $80;  // 7 (MSB) Disable Paddle watchdog

  // Request Winkeyer2 Status <15> no parameter, Return Winkeyer2Åfs status byte
  WK_STATUS_CMD     = $15;
  WK_STATUS_XOFF    = $01;    // Buffer is more than 2/3 full when = 1
  WK_STATUS_BREAKIN = $02;    // Paddle break-in active when = 1
  WK_STATUS_BUSY    = $04;    // Keyer is busy sending Morse when = 1
  WK_STATUS_KEYDOWN = $08;    // Keydown status (Tune) 1 = keydown
  WK_STATUS_WAIT    = $10;    // WK is waiting for an internally timed event to finish

  // Buffered Commands
  // PTT On/Off <18><nn> nn = 01 PTT on, n = 00 PTT off
  WK_PTT_CMD = $18;
  WK_PTT_ON = 1;
  WK_PTT_OFF = 0;

type
  TWinKeyerSendStatus = (wkssNone = 0, wkssMessage, wkssCallsign);

implementation

end.
