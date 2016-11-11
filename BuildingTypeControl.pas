unit BuildingTypeControl;

interface

uses
  TypeControl;

const
  _BUILDING_UNKNOWN_     : LongInt = -1;
  BUILDING_GUARDIAN_TOWER: LongInt = 0;
  BUILDING_FACTION_BASE  : LongInt = 1;
  _BUILDING_COUNT_       : LongInt = 2;

type
  TBuildingType = LongInt;
  TBuildingTypeArray = TLongIntArray;
  TBuildingTypeArray2D = TLongIntArray2D;
  TBuildingTypeArray3D = TLongIntArray3D;
  TBuildingTypeArray4D = TLongIntArray4D;
  TBuildingTypeArray5D = TLongIntArray5D;

implementation

end.
