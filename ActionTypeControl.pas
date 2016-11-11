unit ActionTypeControl;

interface

uses
  TypeControl;

const
  _ACTION_UNKNOWN_    : LongInt = -1;
  ACTION_NONE         : LongInt = 0;
  ACTION_STAFF        : LongInt = 1;
  ACTION_MAGIC_MISSILE: LongInt = 2;
  ACTION_FROST_BOLT   : LongInt = 3;
  ACTION_FIREBALL     : LongInt = 4;
  ACTION_HASTE        : LongInt = 5;
  ACTION_SHIELD       : LongInt = 6;
  _ACTION_COUNT_      : LongInt = 7;

type
  TActionType = LongInt;
  TActionTypeArray = TLongIntArray;
  TActionTypeArray2D = TLongIntArray2D;
  TActionTypeArray3D = TLongIntArray3D;
  TActionTypeArray4D = TLongIntArray4D;
  TActionTypeArray5D = TLongIntArray5D;

implementation

end.
