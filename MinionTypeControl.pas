unit MinionTypeControl;

interface

uses
  TypeControl;

const
  _MINION_UNKNOWN_      : LongInt = -1;
  MINION_ORC_WOODCUTTER : LongInt = 0;
  MINION_FETISH_BLOWDART: LongInt = 1;
  _MINION_COUNT_        : LongInt = 2;

type
  TMinionType = LongInt;
  TMinionTypeArray = TLongIntArray;
  TMinionTypeArray2D = TLongIntArray2D;
  TMinionTypeArray3D = TLongIntArray3D;
  TMinionTypeArray4D = TLongIntArray4D;
  TMinionTypeArray5D = TLongIntArray5D;

implementation

end.
