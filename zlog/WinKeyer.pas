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

  // Sidetone Frequency <01><nn> nn is a value from 1 to 10
  WK_SIDETONE_CMD = $01;

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

  // Clear Buffer <0A> no parameters
  WK_CLEAR_CMD = $0a;

  // Buffered Commands
  // PTT On/Off <18><nn> nn = 01 PTT on, n = 00 PTT off
  WK_PTT_CMD = $18;
  WK_PTT_ON = 1;
  WK_PTT_OFF = 0;

implementation

end.
