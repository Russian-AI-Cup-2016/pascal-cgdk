unit BonusTypeControl;

interface

uses
  TypeControl;

const
  _BONUS_UNKNOWN_: LongInt = -1;
  BONUS_EMPOWER  : LongInt = 0;
  BONUS_HASTE    : LongInt = 1;
  BONUS_SHIELD   : LongInt = 2;
  _BONUS_COUNT_  : LongInt = 3;

type
  TBonusType = LongInt;
  TBonusTypeArray = TLongIntArray;
  TBonusTypeArray2D = TLongIntArray2D;
  TBonusTypeArray3D = TLongIntArray3D;
  TBonusTypeArray4D = TLongIntArray4D;
  TBonusTypeArray5D = TLongIntArray5D;

implementation

end.
