unit UGridLocator;

interface

uses
  System.SysUtils;

function glDmsToDeg(D, M, S: Integer): Extended;
function glDegToDms(deg: Extended; var D, M, S: Integer): Boolean;
function glDegToGrid(latitude, longitude: Extended): string;
procedure glGridToDeg(strGridLoc: string; var latitude, longitude: Extended);

implementation

function glDmsToDeg(D, M, S: Integer): Extended;
var
   deg: Extended;
begin
   deg := (D + (M / 60) + (S / 3600));

   Result := deg;
end;

function glDegToDms(deg: Extended; var D, M, S: Integer): Boolean;
begin
   D := Trunc(deg);
   M := Trunc((deg - D) * 60);
   S := Trunc((((deg - D) * 60) - M) * 60);
   Result := True;
end;

function glDegToGrid(latitude, longitude: Extended): string;
var
   strGridLoc: string;
   N: Integer;
   Index: Integer;
   S: string;
   strLatitudeTemp: string;
   strLongitudeTemp: string;
begin
   strGridLoc := '';
   latitude := (latitude + 90) / 10;
   longitude := (longitude + 180) / 20;

   strLatitudeTemp := FloatToStr(latitude);
   strLongitudeTemp := FloatToStr(longitude);

   // ‚P•¶š–Ú‚ÍLongtitude‚Ì®”•”
   N := Trunc(longitude);
   strGridLoc := strGridLoc + Char(Ord('A') + N);

   // ‚Q•¶š–Ú‚ÍLatitude‚Ì®”•”
   N := Trunc(latitude);
   strGridLoc := strGridLoc + Char(Ord('A') + N);

   // ‚R•¶š–Ú‚ÍLongtitude‚Ì­”•”‚PŒ…–Ú‚Ì”š
   S := strLongitudeTemp;
   Index := Pos('.', S);
   if Index = 0 then begin
      strGridLoc := strGridLoc + '0';
   end
   else begin
      strGridLoc := strGridLoc + Copy(S, Index + 1, 1);
   end;

   // ‚S•¶š–Ú‚ÍLatitude‚Ì­”•”‚PŒ…–Ú‚Ì”š
   S := strLatitudeTemp;
   Index := Pos('.', S);
   if Index = 0 then begin
      strGridLoc := strGridLoc + '0';
   end
   else begin
      strGridLoc := strGridLoc + Copy(S, Index + 1, 1);
   end;

   // ‚T•¶š–Ú‚ÍLongtitude‚Ì¬”“_ˆÈ‰º‚QŒ…–ÚˆÈ~‚ğæ‚èo‚µA‚PŒ…–Ú‚ğ®”•”‚Æ‚µ‚Ä2.4”{‚·‚é
   // ex) 15.98644 -> 8.644 ‚Æ‚·‚é
   S := strLongitudeTemp;
   Index := Pos('.', S);
   if Index = 0 then begin
      strGridLoc := strGridLoc + 'A';
   end
   else begin
      S := Copy(S, Index + 2);
      Insert('.', S, 2);
      N := Trunc(StrToFloatDef(S, 0) * 2.4);
      strGridLoc := strGridLoc + Char(Ord('A') + N);
   end;

   // ‚U•¶š–Ú‚ÍLatitude‚Ì¬”“_ˆÈ‰º‚QŒ…–ÚˆÈ~‚ğæ‚èo‚µA‚PŒ…–Ú‚ğ®”•”‚Æ‚µ‚Ä2.4”{‚·‚é
   S := strLatitudeTemp;
   Index := Pos('.', S);
   if Index = 0 then begin
      strGridLoc := strGridLoc + 'A';
   end
   else begin
      S := Copy(S, Index + 2);
      Insert('.', S, 2);
      N := Trunc(StrToFloatDef(S, 0) * 2.4);
      strGridLoc := strGridLoc + Char(Ord('A') + N);
   end;

   Result := strGridLoc;
end;

procedure glGridToDeg(strGridLoc: string; var latitude, longitude: Extended);
var
   N: Integer;
begin
   // ‚P•¶š–Ú‚ÍLongitude‚Ì®”•”
   longitude := Ord(strGridLoc[1]) - Ord('A');

   // ‚Q•¶š–Ú‚ÍLatitude‚Ì®”•”
   latitude := Ord(strGridLoc[2]) - Ord('A');

   // ‚R•¶š–Ú‚ÍLongitude‚Ì­”•”‚PŒ…–Ú‚Ì”š
   longitude := longitude + ((Ord(strGridLoc[3]) - Ord('0')) / 10);

   // ‚S•¶š–Ú‚Ílatitude‚Ì­”•”‚PŒ…–Ú‚Ì”š
   latitude := latitude + ((Ord(strGridLoc[4]) - Ord('0')) / 10);

   // ‚T•¶š–Ú‚ÍLongitude‚Ì¬”“_ˆÈ‰º‚QŒ…–ÚˆÈ~‚ğæ‚èo‚µA‚PŒ…–Ú‚ğ®”•”‚Æ‚µ‚Ä2.4”{‚·‚é
   N := Ord(strGridLoc[5]) - Ord('A');
   longitude := longitude + ((N / 2.4) / 100) + 0.00208;

   // ‚U•¶š–Ú‚ÍLatitude‚Ì¬”“_ˆÈ‰º‚QŒ…–ÚˆÈ~‚ğæ‚èo‚µA‚PŒ…–Ú‚ğ®”•”‚Æ‚µ‚Ä2.4”{‚·‚é
   N := Ord(strGridLoc[6]) - Ord('A');
   latitude := latitude + ((N / 2.4) / 100) + 0.00208;

   longitude := longitude * 20 - 180;
   latitude := latitude * 10 - 90;
end;

end.
