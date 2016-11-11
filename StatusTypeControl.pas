unit StatusTypeControl;

interface

uses
  TypeControl;

const
  _STATUS_UNKNOWN_: LongInt = -1;
  STATUS_BURNING  : LongInt = 0;
  STATUS_EMPOWERED: LongInt = 1;
  STATUS_FROZEN   : LongInt = 2;
  STATUS_HASTENED : LongInt = 3;
  STATUS_SHIELDED : LongInt = 4;
  _STATUS_COUNT_  : LongInt = 5;

type
  TStatusType = LongInt;
  TStatusTypeArray = TLongIntArray;
  TStatusTypeArray2D = TLongIntArray2D;
  TStatusTypeArray3D = TLongIntArray3D;
  TStatusTypeArray4D = TLongIntArray4D;
  TStatusTypeArray5D = TLongIntArray5D;

implementation

end.
