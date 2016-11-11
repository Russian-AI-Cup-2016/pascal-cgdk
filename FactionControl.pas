unit FactionControl;

interface

uses
  TypeControl;

const
  _FACTION_UNKNOWN_: LongInt = -1;
  FACTION_ACADEMY  : LongInt = 0;
  FACTION_RENEGADES: LongInt = 1;
  FACTION_NEUTRAL  : LongInt = 2;
  FACTION_OTHER    : LongInt = 3;
  _FACTION_COUNT_  : LongInt = 4;

type
  TFaction = LongInt;
  TFactionArray = TLongIntArray;
  TFactionArray2D = TLongIntArray2D;
  TFactionArray3D = TLongIntArray3D;
  TFactionArray4D = TLongIntArray4D;
  TFactionArray5D = TLongIntArray5D;

implementation

end.
